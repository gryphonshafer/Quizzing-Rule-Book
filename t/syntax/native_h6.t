use Test2::V0;
use exact -conf;
use Mojo::File 'path';

my $root_dir = conf->get( qw( config_app root_dir ) );

path( "$root_dir/" . conf->get('content_dir') )->list_tree->each( sub {
    my $md = $_->slurp;
    my $count = () = $md =~ /^[ ]*#{6,}/mg;
    ok( $count == 0, 'No native H6 in: ' . $_->to_rel($root_dir) ) or do {
        my ( $line, @lines );
        for ( split( /\n/, $md ) ) {
            $line++;
            push( @lines, $line ) if ( /^[ ]*#{6,}/ );
        }
        diag( 'Native H6 found on line(s): ' . join( ', ', @lines) );
    };
} );

done_testing;
