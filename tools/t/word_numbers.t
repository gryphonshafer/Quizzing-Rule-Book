use Test::Most;
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
    my $count = () = $_->slurp =~ /\b(?:$words)\b/img;
    ok( $count == 0, 'No word numbers in: ' . $_->to_rel($root_dir) );
} );

done_testing;
