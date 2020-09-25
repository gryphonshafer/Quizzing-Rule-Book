use English::Script;
use FindBin '$Bin';
use Mojo::DOM;
use Mojo::File 'path';
use Test::Most;
use Text::MultiMarkdown 'markdown';

my $content = "$Bin/../../content";
my $speak;

lives_ok(
    sub {
        $speak = Mojo::DOM
            ->new( markdown( path("$content/index.md")->slurp ) )
            ->find('a')->map( attr => 'href' )->grep( sub { not m|//| } )->map( sub {
                my $file = $_;
                Mojo::DOM->new( markdown( path("$content/$file")->slurp ) )->find('pre code')->map( sub {
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
# TODO: uncomment after English::Script supports negative numbers
# lives_ok( sub { $es->parse( $_->{block} ) }, "code parse: $_->{file} -- $_->{header}" ) for (@$speak);

done_testing;
