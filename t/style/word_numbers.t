use Test2::V0;
use exact -conf;
use Mojo::File 'path';

my $root_dir = conf->get( qw( config_app root_dir ) );

my $words = join( '|', qw(
    first second third fourth fifth sixth seventh eighth ninth tenth eleventh
    twelfth thirteenth fourteenth fifteenth sixteenth seventeenth eighteenth
    nineteenth twentieth
    one two three four five six seven eight nine ten eleven twelve thirteen fourteen
    fifteen sixteen seventeen eighteen nineteen twenty
) );

path( "$root_dir/" . conf->get('content_dir') )->list_tree->each( sub {
    my $file = $_;
    my ( $line, @lines );
    for ( split( /\n/, $file->slurp ) ) {
        $line++;
        next if (/^>/);
        push( @lines, [ $file->to_rel($root_dir), $line ] ) if ( /\b(?:$words)\b/i );
    }

    ok( @lines == 0, 'No word numbers in: ' . $_->to_rel($root_dir) ) or diag(
        "Word numbers found in:\n",
        join( "\n",
            map { ' ' x 4 . $_->[0] . ', line ' . $_->[1] } @lines
        )
    );
} );

done_testing;
