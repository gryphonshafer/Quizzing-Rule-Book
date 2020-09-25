use FindBin '$Bin';
use Mojo::DOM;
use Mojo::File 'path';
use Test::Most;
use Text::MultiMarkdown 'markdown';

my $content = "$Bin/../../content";
my $tables;

lives_ok(
    sub {
        $tables = Mojo::DOM
            ->new( markdown( path("$content/index.md")->slurp ) )
            ->find('a')->map( attr => 'href' )->grep( sub { not m|//| } )->map( sub {
                Mojo::DOM->new( markdown( path("$content/$_")->slurp ) )->find('table')->map( sub {
                    my $headers = $_->find('thead tr th')->map('text')->to_array;
                    my $node    = $_;
                    $node       = $node->previous while ( $node and $node->tag and $node->tag !~ /^h\d$/ );

                    {
                        header => ( ( $node and $node->text ) ? $node->text : 'Untitled' ),
                        rows   => $_->find('tbody tr')->map( sub {
                            my $row;
                            @$row{@$headers} = @{ $_->find('td')->map('text')->to_array };
                            $row;
                        } )->to_array,
                    };
                } );
            } )->grep( sub { $_->size } )->map( sub { @{ $_->to_array } } )->to_array
    },
    'parse content for tables',
);

my $material_years;
lives_ok( sub {
    $material_years = ( grep { $_->{header} eq 'Material Rotation Schedule' } @$tables )[0]->{rows};
}, 'find material years data' );

for my $year (
    [ Romans => 'Epistle'   ],
    [ John   => 'Narrative' ],
) {
    is(
        ( grep { $_->{'Material Scope References'} =~ /\b$year->[0]\b/ } @$material_years )[0]->{Style},
        $year->[1],
        "$year->[0] is $year->[1]",
    );
}

# TODO: verify all references can be parsed by Bible::Reference once said module supports wider range

my $distribution;
lives_ok( sub {
    $distribution = ( grep { $_->{header} eq 'Question Type Distribution' } @$tables )[0]->{rows};
}, 'find distribution data' );

is_deeply(
    [ sort keys %{ $distribution->[0] } ],
    [
        'Maximum',
        'Minimum',
        'Question Types',
        'Type Group',
    ],
    'distribution table row has proper columns',
);

done_testing;
