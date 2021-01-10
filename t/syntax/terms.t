use Test2::V0;
use exact -conf;
use Mojo::File 'path';

my $root_dir      = conf->get( qw( config_app root_dir ) );
my $rule_book_dir = join( '/', map { conf->get(@$_) } (
    [ qw( config_app root_dir ) ],
    ['content_dir'],
    [ qw( rule_book dir ) ],
) );

my ( $acronymic_terms, $acronyms );
path($rule_book_dir)->list_tree->each( sub {
    my $file = $_;
    my $line;
    for ( split( /\n/, $file->slurp ) ) {
        $line++;
        next if ( /^\s{4,}/ or /^\[[^\]]*\]\([^\)]*\)$/ );

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

done_testing;
