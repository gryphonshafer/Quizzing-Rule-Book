use Test::Most;
use exact -conf;
use Mojo::DOM;
use Mojo::File 'path';
use Text::MultiMarkdown 'markdown';

my $rule_book_dir = join( '/', map { conf->get(@$_) } (
    [ qw( config_app root_dir ) ],
    ['content_dir'],
    [ qw( rule_book dir ) ],
) );

ok( -r "$rule_book_dir/index.md", 'index.md exists and is readable' );

my $a;
lives_ok(
    sub {
        $a = Mojo::DOM
            ->new( markdown( path("$rule_book_dir/index.md")->slurp ) )
            ->find('a')->map( attr => 'href' )->grep( sub { not m|//| } )->to_array
    },
    'for index.md: render MultiMarkdown, parse HTML, find local links',
);

is_deeply( $a, conf->get( qw( rule_book docs ) ), 'links are correct' );

lives_ok(
    sub { Mojo::DOM->new( markdown( path("$rule_book_dir/$_")->slurp ) ) },
    "render MultiMarkdown, parse HTML for: $_",
) for (@$a);

done_testing;
