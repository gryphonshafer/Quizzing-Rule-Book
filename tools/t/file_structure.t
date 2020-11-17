use Test::Most;
use exact -me;
use Mojo::DOM;
use Mojo::File 'path';
use Text::MultiMarkdown 'markdown';

my $content_dir = me('../../content');

ok( -r "$content_dir/rule_book/index.md", 'index.md exists and is readable' );

my $a;
lives_ok(
    sub {
        $a = Mojo::DOM
            ->new( markdown( path("$content_dir/rule_book/index.md")->slurp ) )
            ->find('a')->map( attr => 'href' )->grep( sub { not m|//| } )->to_array
    },
    'for index.md: render MultiMarkdown, parse HTML, find local links',
);

is_deeply( $a, [ qw(
    material_and_questions.md
    roles_and_responsibilities.md
    quiz_process.md
    quiz_events.md
    quiz_meets.md
    internationals.md
    change_management.md
)], 'links are correct' );

lives_ok(
    sub { Mojo::DOM->new( markdown( path("$content_dir/rule_book/$_")->slurp ) ) },
    "render MultiMarkdown, parse HTML for: $_",
) for (@$a);

done_testing;
