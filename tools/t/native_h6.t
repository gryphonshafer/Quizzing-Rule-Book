use Test::Most;
use exact -conf;
use Mojo::File 'path';

my $root_dir = conf->get( qw( config_app root_dir ) );

path( "$root_dir/" . conf->get('content_dir') )->list_tree->each( sub {
    my $count = () = $_->slurp =~ /^[ ]*#{6,}/mg;
    ok( $count == 0, 'No native H6 in: ' . $_->to_rel($root_dir) )
} );

done_testing;
