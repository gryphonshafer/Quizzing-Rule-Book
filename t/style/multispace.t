use Test2::V0;
use exact -conf;
use Cwd 'getcwd';
use Mojo::File 'path';
use Text::Gitignore 'build_gitignore_matcher';

my $root_dir = conf->get( qw( config_app root_dir ) );
my $cwd = getcwd();
chdir($root_dir);

my $matcher = build_gitignore_matcher( [
    './.git', './t', map { s|^/|./|; $_;} split( "\n", path('.gitignore')->slurp )
] );

path('.')
    ->list_tree({ hidden => 1 })
    ->map( sub { './' . $_->to_rel } )
    ->grep( sub { -f $_ and -T $_ and not $matcher->($_) } )
    ->each( sub {
        my $md = path($_)->slurp;

        ok( $md !~ /^[^\|\[]+\S[ ]{2,}/, "Multispace check on $_" ) or do {
            my ( $line, @lines );
            for ( split( /\n/, $md ) ) {
                $line++;
                push( @lines, $line ) if ( /^[^\|\[]+\S[ ]{2,}/ );
            }
            diag( 'Multispace check failed on line(s): ' . join( ', ', @lines) );
        };

        ok(
            (
                $md !~ /(?:[ ]*\r?\n[ ]*){3,}/ and
                $md !~ /(?:[ ]*\r?\n[ ]*){2,}$/
            ),
            "Multiline check on $_",
        );
    } );

chdir($cwd);
done_testing;
