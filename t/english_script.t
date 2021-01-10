use Test2::V0;
use exact -conf;
use English::Script;
use Mojo::DOM;
use Mojo::File 'path';
use Text::MultiMarkdown 'markdown';

my $rule_book_dir = join( '/', map { conf->get(@$_) } (
    [ qw( config_app root_dir ) ],
    ['content_dir'],
    [ qw( rule_book dir ) ],
) );

my $speak;

ok(
    lives {
        $speak = Mojo::DOM
            ->new( markdown( path("$rule_book_dir/index.md")->slurp ) )
            ->find('a')->map( attr => 'href' )->grep( sub { not m|//| } )->map( sub {
                my $file = $_;
                Mojo::DOM->new(
                    markdown( path("$rule_book_dir/$file")->slurp )
                )->find('pre code')->map( sub ($code) {
                    my $node = $code->parent;
                    $node    = $node->previous while ( $node and $node->tag and $node->tag !~ /^h\d$/ );

                    {
                        file   => $file,
                        block  => $code->text,
                        header => (
                            $code->parent->preceding(
                                'h' . (
                                    substr(
                                        $code->parent->preceding('h1, h2, h3, h4, h5, h6')->last->tag,
                                        1,
                                    ) - 1
                                )
                            )->last->text
                        ),
                    };
                } );
            } )->grep( sub { $_->size } )->map( sub { @{ $_->to_array } } )->to_array
    },
    'parse content for English-Script',
) or note $@;

my $es = English::Script->new;
for (@$speak) {
    ok( lives { $es->parse( $_->{block} ) }, "code parse: $_->{file} -- $_->{header}" ) or note $@;
}

is(
    [ sort map { $_->{header} } @$speak ],
    [
        'Answer Duration',
        'Readiness Bonus',
        'Scoring',
        'Team Points Calculation',
        'Timeouts',
        'Types of Quizzes',
    ],
    'code headers are as expected',
);

done_testing;
