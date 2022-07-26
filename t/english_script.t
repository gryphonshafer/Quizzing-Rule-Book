use Test2::V0;
use exact -conf;
use English::Script;
use Mojo::DOM;
use Mojo::File 'path';
use Text::MultiMarkdown 'markdown';

my $rule_book_dir = join( '/', map { conf->get(@$_) } ( [ qw( config_app root_dir ) ], ['rule_book_dir'] ) );

my $speak;

ok(
    lives {
        $speak = path($rule_book_dir)->list_tree->map( sub ($file) {
            @{
                Mojo::DOM->new( markdown( $file->slurp ) )->find('pre code')->map( sub ($code) {
                    my $node = $code->parent;
                    $node    = $node->previous while ( $node and $node->tag and $node->tag !~ /^h\d$/ );

                    {
                        file   => $file->to_string,
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
                } )->to_array
            };
        } )->to_array;
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
