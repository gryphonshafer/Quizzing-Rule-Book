use Test::Most;
use exact -conf;
use Mojo::File 'path';

my $root_dir      = conf->get( qw( config_app root_dir ) );
my $rule_book_dir = join( '/', map { conf->get(@$_) } (
    [ qw( config_app root_dir ) ],
    ['content_dir'],
    [ qw( rule_book dir ) ],
) );

my ( $md_terms, $acronymic_terms, $acronyms );
path($rule_book_dir)->list_tree->each( sub {
    my $file = $_;
    my $line;
    for ( split( /\n/, $file->slurp ) ) {
        $line++;
        next if ( /^\s{4,}/ or /^\[[^\]]*\]\([^\)]*\)$/ );

        push( @{ $md_terms->{$1} }, [ $file->to_rel($root_dir), $line ] ) if ( /^\*{2}([^\*]+)\*{2}$/ );

        push( @{ $acronymic_terms->{$2}{$1} }, [ $file->to_rel($root_dir), $line ] )
            while ( /\*([^\*]+)\*\s+\(([^\)]+)\)/g );

        push( @{ $acronymic_terms->{$2}{$1} }, [ $file->to_rel($root_dir), $line ] )
            while ( /#\s+([\w\s]+)\s+\(([^\)]+)\)/g );

        while ( /([A-Z]{2,})/g ) {
            my $match = $1;
            next if ( $match =~ /^[X-Z]/ );
            push( @{ $acronyms->{$match} }, [ $file->to_rel($root_dir), $line ] );
        }
    }
} );

for my $acronym ( sort keys %$acronymic_terms ) {
    my %acronymic_terms = map { s/s$//; lc($_) => 1 } keys %{ $acronymic_terms->{$acronym} };
    ok( scalar( keys %acronymic_terms ) == 1, "$acronym has no duplicate terms" ) or diag(
        "$acronym has duplicate terms:\n",
        join( "\n",
            map {
                ' ' x 4 . '"' . $_ . '" from:' . "\n" . join( "\n", map {
                    ' ' x 8 . $_->[0] . ', line ' . $_->[1];
                } @{ $acronymic_terms->{$acronym}{$_} } );
            } sort keys %{ $acronymic_terms->{$acronym} }
        ),
    );
}

ok( exists $acronymic_terms->{$_}, "$_ defined" ) or diag(
    "$_ not defined:\n",
    join( "\n",
        map {
            ' ' x 4 . $_->[0] . ', line ' . $_->[1];
        } @{ $acronyms->{$_} }
    ),
) for ( sort keys %$acronyms );

my %terms = map { s/s$//; lc($_) => 1 } (
    keys %$md_terms,
    map { keys %{ $acronymic_terms->{$_} } } keys %$acronymic_terms,
);

my $terms_re = '(.?)(' . join( '|',
    map { $_ . 's?' }
    map { $_->[0] }
    sort { $b->[1] <=> $a->[1] }
    map { [ $_, length $_ ] }
    keys %terms
) . ')(.?)';

path($rule_book_dir)->list_tree->each( sub {
    my $file = $_;
    my ( $line, @unmarked_terms );
    for ( split( /\n/, $file->slurp ) ) {
        $line++;
        next if ( /^\s{4,}/ or /^\[[^\]]*\]\([^\)]*\)$/ );
        push( @unmarked_terms, [ $2, $line ] )
            if ( /$terms_re/i and $1 ne '*' and $3 ne '*' );
    }

    ok( @unmarked_terms == 0, 'No terms unitalicized in: ' . $file->to_rel($root_dir) ) or diag(
        'Terms unitalicized in ', $file->to_rel($root_dir), ":\n",
        join( "\n", map {
            ' ' x 4 . 'line ' . $_->[1] . ': "' . $_->[0] . '"'
        } @unmarked_terms )
    );
} );

done_testing;
