use Test2::V0;
use exact -conf;
use Cwd 'getcwd';
use Mojo::File 'path';
use Text::Gitignore 'build_gitignore_matcher';

my $root_dir = conf->get( qw( config_app root_dir ) );
my $cwd = getcwd();
chdir($root_dir);

my $matcher = build_gitignore_matcher( [
    './.git', map { s|^/|./|; $_ } split( "\n", path('.gitignore')->slurp )
] );

path('.')
    ->list_tree({ hidden => 1 })
    ->map( sub { './' . $_->to_rel } )
    ->grep( sub { -f $_ and -T $_ and not $matcher->($_) } )
    ->each( sub {
        my $md = path($_)->slurp;
        ok( $md !~ /[^[:ascii:]]/, "ASCII check on $_" ) or do {
            my ( $line, @lines );
            for ( split( /\n/, $md ) ) {
                $line++;
                push( @lines, $line ) if ( /[^[:ascii:]]/ );
            }
            diag( 'Non-ASCII character(s) found on line(s): ' . join( ', ', @lines) );
        };
    } );

chdir($cwd);
done_testing;
