use Test::Most;
use exact -me;
use English::Script;
use Mojo::DOM;
use Mojo::File 'path';
use Text::MultiMarkdown 'markdown';

my $content_dir = me('../../content');
my $speak;

lives_ok(
    sub {
        $speak = Mojo::DOM
            ->new( markdown( path("$content_dir/rule_book/index.md")->slurp ) )
            ->find('a')->map( attr => 'href' )->grep( sub { not m|//| } )->map( sub {
                my $file = $_;
                Mojo::DOM->new(
                    markdown( path("$content_dir/rule_book/$file")->slurp )
                )->find('pre code')->map( sub {
                    my $node    = $_->parent;
                    $node       = $node->previous while ( $node and $node->tag and $node->tag !~ /^h\d$/ );

                    {
                        file   => $file,
                        header => ( ( $node and $node->text ) ? $node->text : 'Untitled' ),
                        block  => $_->text,
                    };
                } );
            } )->grep( sub { $_->size } )->map( sub { @{ $_->to_array } } )->to_array
    },
    'parse content for English-Script',
);

my $es = English::Script->new;
lives_ok( sub { $es->parse( $_->{block} ) }, "code parse: $_->{file} -- $_->{header}" ) for (@$speak);

done_testing;
