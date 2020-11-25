#!/usr/bin/env perl
use exact -cli, -conf;
use Date::Format 'time2str';
use File::Basename qw( dirname basename );
use Mojo::File 'path';
use PDF::WebKit;
use Text::MultiMarkdown 'markdown';

my $opt = options( 'docs|d=s{,}', 'filter|f=s{,}', 'type|t=s', 'output|o=s', 'config|c' );

$opt->{docs}   = ['rule_book'] unless ( $opt->{docs} and @{ $opt->{docs} } );
$opt->{type} //= 'pdf';

my $root_dir = conf->get( qw( config_app root_dir ) );
my $header   = join( '', <DATA> );
my $params   = {
    build_date    => time2str( '%Y-%m-%d %H:%M:%S %Z', time ),
    build_version => `git rev-parse HEAD`,
};

chomp( $params->{build_version} );
$params->{build_version_short} = substr( $params->{build_version}, 0, 7 );

unless ( $opt->{config} ) {
    $opt->{filter} = filter( $opt->{filter} ) if ( $opt->{filter} );
    $opt = [$opt];
}
else {
    my $build_config = conf->get('build');
    my $build_dir    = $root_dir . '/' . ( $build_config->{dir} || 'build' );

    $opt = [ map {
        my $run = $_;

        for ( qw( type docs filter ) ) {
            $run->{$_} //= $opt->{$_} if ( $opt->{$_} );
            $run->{$_} = [ $run->{$_} ] if ( $run->{$_} and not ref $run->{$_} );
        }

        map {
            my $this        = {%$run};
            $this->{type}   = $_;
            $this->{output} = $build_dir . '/' . $this->{output} . '.' . $_;
            $this->{filter} = filter( $this->{filter} ) if ( $this->{filter} );
            $this;
        } @{ $run->{type} };
    } @{ $build_config->{builds} } ];
}

generate( output($_), $_, $header ) for (@$opt);

sub filter ($filter) {
    return
        ( $filter and grep { lc($_) eq 'all' } @$filter )
            ? [
                @{ conf->get( qw( rule_book special_sections ) ) },
                conf->get( qw( rule_book special_sections_block ) ),
            ]
            : ( not ref $filter ) ? [$filter] : $filter;
}

sub output ($opt) {
    my $content_dir = $root_dir . '/' . conf->get('content_dir');
    return join( "\n",
        map {
            (ref)
                ? $_->[0] . join( '', map {
                    my $md = build($_);
                    $md =~ s/^([ \t]*#)/ $1 . '#' /mge;
                    $md;
                } @{ $_->[1] } )
                : build($_);
        }
        map {
            if ( -f $_ ) {
                $_;
            }
            elsif ( -f $content_dir . '/' . $_ ) {
                $content_dir . '/' . $_;
            }
            elsif ( -f $content_dir . '/' . $_ . '/index.md' ) {
                $content_dir . '/' . $_ . '/index.md';
            }
            elsif ( -f $_ . '/index.md' ) {
                $_ . '/index.md';
            }
            elsif ( -f $content_dir . '/' . $_ . '.md' ) {
                $content_dir . '/' . $_ . '.md';
            }
            elsif ( -f $_ . '.md' ) {
                $_ . '/.md';
            }
            elsif ( -d $content_dir . '/' . $_ or -d $_ ) {
                my $prefix_dir = ( -d $content_dir . '/' . $_ ) ? $content_dir . '/' . $_ : $_;
                opendir( my $dir, $prefix_dir );

                [
                    '# ' . join( ' ', map { ucfirst } split( /\s+/, lc basename $_ ) ) . "\n\n",
                    [ map { $prefix_dir . '/' . $_ } sort grep { substr( $_, 0, 1 ) ne '.' } readdir($dir) ],
                ];
            }
            else {
                die "Unable to locate doc: $_\n";
            }
        }
        @{ $opt->{docs} || [] }
    );
}

sub build ( $file, $level = 0 ) {
    my $md  = path($file)->slurp;
    my $dir = dirname($file);

    $md =~ s/^(\s*)(#+)/$1-$2/mg unless ($level);
    $md =~ s/^([ \t]*\-\s*\[[^\]]*\]\()([^\)]+)(\)[ \t]*)$/ sub_file( $1, $2, $3, $dir, $level ) /mge;
    return $md;
}

sub sub_file ( $pre, $file, $post, $dir, $level = 0 ) {
    my $sub_file = $dir . '/' . $file;
    $level++;

    if ( -f $sub_file )  {
        my $md = build( $sub_file, $level );
        $md =~ s/^([ \t]*#)/ $1 . '#' x $level /mge;
        return $md;
    }
    else {
        return join( '', $pre, $file, $post );
    }
}

sub generate ( $output, $opt, $header ) {
    $params->{build_file} = Mojo::File->new( $opt->{output} )->to_rel($root_dir);

    my %header_level;
    my $headers = sub ($level) {
        delete $header_level{$_} for ( grep { $_ > $level } keys %header_level );
        $header_level{$level}++;
        return join( '', map { $header_level{$_} . '.' } 2 .. $level );
    };

    $output =~ s/^\s*\-*\s*#+\s*$_\s.*?(?=\n#)//imsg for ( @{ $opt->{filter} } );
    $output =~ s/^(\s*)(#{2,})/ $1 . $2 . ' ' . $headers->( length($2) ) /mge;
    $output =~ s/^(\s*)\-(#+)/$1$2/mg;
    $output =~ s/\[\s*\[\s*$_\s*\]\s*\]/$params->{$_}/ig for ( keys %$params );

    if ( $opt->{all} ) {
        my $special_sections_block = conf->get( qw( rule_book special_sections_block ) );
        $output =~ s/^\s*#+\s*$special_sections_block\s.*?(?=\n#)//imsg;
    }

    if ( $opt->{type} eq 'html' or $opt->{type} eq 'pdf' ) {
        $output =~ s/(\n\|[^\n]*\|[ \t]*\n\n)/$1\n/g;

        my $this_header = $header;

        my $media_print = {
            html => q{
                @media only print {
                    body {
                        font-size     : 10pt;
                        margin-left   : 1.3em;
                        margin-right  : 0.2em;
                        margin-top    : 0.2em;
                        margin-bottom : 0.2em;
                    }
                }
            },
            pdf => q{
                @media only print {
                    body {
                        font-size     : 13pt;
                        margin-left   : 1.3em;
                        margin-right  : 0em;
                        margin-top    : 0em;
                        margin-bottom : 0em;
                    }
                }
            },
        };

        $this_header =~ s|(?=</style>)| $media_print->{ $opt->{type} } |e;

        $output = $this_header . markdown($output) . '</body></html>';

        $output =~ s|(<h\d[^\n]+)|</section><section>$1|g;
        $output =~ s|(</body></html>)|</section>$1|g;
        $output =~ s|</section><section>|<section>|;
        $output =~ s|(</section><section><h\d[^\n]+\s+)</section><section>(<h\d)|$1$2|g;
    }

    if ( $opt->{type} eq 'pdf' ) {
        my $kit = PDF::WebKit->new(
            \$output,
            'margin_left'   => '0.5in',
            'margin_right'  => '0.5in',
            'margin_top'    => '0.5in',
            'margin_bottom' => '0.5in',
        );
        $output = $kit->to_pdf;
    }

    if ( $opt->{output} ) {
        path( $opt->{output} )->spurt($output);
    }
    else {
        say $output;
    }

    return;
}

=head1 NAME

build.pl - Build various documents from Markdown source files

=head1 SYNOPSIS

    build.pl OPTIONS
        -d, --docs   DOCS_LIST        ("rule_book best_practices"; default: "rule_book")
        -f, --filter BLOCKS_TO_FILTER ("commentary examples example" or "all"; default: none)
        -t, --type   OUTPUT_TYPE      ("md" or "html" or "pdf"; default: "pdf")
        -o, --output OUTPUT_FILE      (if not defined, output send to STDOUT)
        -c, --config                  (use app config settings to override all others)
        -h, --help
        -m, --man

=head1 DESCRIPTION

This program will build various documents as PDFs, HTML files, or Markdown files
using the project's Markdown source files.

=head1 OPTIONS

=head2 -d, --docs

List of the specific documents to build.

This can be directories that contain content by name, like "rule_book" or
"best_practices" (where these directores  contain or don't contain an "index.md"
file). In the case of a directory without an "index.md" file, the folder name
will be used to create a pseudo index.

Documents listed for this flag can also be specific files within the content
directory or specific files or directories relative to the project root.

Whatever list of documents provides, these will be incorporated into a single
output.

If you don't specify any docs, then "rule_book" is assumed.

=head2 -f, --filter

Filter sections by name. For example, if you pass "examples", all headers and
their associated sections are filtered. )Note that "examples" will match
"Examples" headers but not "Example" headers.)

You can alternatively pass "all" to filter all "filterable" sections, which are
defined in the application configuration file under rule book "special_sections".

=head2 -t, --type

This is the type of output. There are only 2 options: "md", "html", and "pdf".
If not specified, "pdf" is assumed.

=head2 -o, --output

This is the file to which the output should be saved. If not specified, output
will be printed to STDOUT.

=head2 -c, --config

If you include this flag, all other settings are ignored, and instead the
application's configuration file is read, looking for a "build" section. This
data will be used to potentially build multiple outputs.

=cut

__DATA__
<!doctype html>
<html lang="en">
    <head>
        <title>Bible Quizzing Rule Book Project</title>
        <meta charset="utf-8">

        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,600;1,400;1,600&display=swap">

        <style type="text/css">

            body {
                margin-left    : 3em;
                margin-right   : 3em;
                margin-top     : 2em;
                margin-bottom  : 3em;
                font-family    : 'Open Sans', sans-serif;
                font-size      : 11pt;
                line-height    : 1.5em;
                letter-spacing : 0.01em;
            }

            section {
                page-break-inside : avoid;
            }

            h1 {
                margin         : 0em 0 0.7em -0.7em;
                font-size      : 200%;
                padding-bottom : 12pt;
                border-bottom  : 1px solid gainsboro;
            }

            h2 {
                margin         : 1.4em 0 0.7em -0.7em;
                font-size      : 150%;
                padding-bottom : 6pt;
                border-bottom  : 1px solid gainsboro;
            }

            h3 {
                margin    : 1.4em 0 0.7em -0.7em;
                font-size : 133%;
            }

            h4 {
                margin    : 1.4em 0 0.7em -0.7em;
                font-size : 110%;
            }

            h5 {
                margin    : 1.4em 0 0.7em -0.7em;
                font-size : 105%;
            }

            h6 {
                margin    : 1.4em 0 0.7em -0.7em;
                font-size : 95%;
            }

            dt {
                margin-left : 1em;
            }

            dd {
                margin-bottom : 1em;
            }

            table {
                border-collapse : collapse;
            }

            table,
            table th,
            table td {
                border : 1px solid gainsboro;
            }

            th, td {
                padding : 0.35em 0.7em;
            }

            tr:nth-child(even) td {
                background-color : whitesmoke;
            }

            pre, code {
                background-color : whitesmoke;
                font-family      : monospace;
            }

            pre {
                padding       : 1.0em 1.25em;
                border-radius : 0.5em;
                line-height   : 1.05em;
            }

            code {
                border-radius  : 0.25em;
                padding        : 0.02em 0.25em;
                letter-spacing : -0.05em;
            }

            pre > code {
                border-radius : 0;
                padding       : 0;
                white-space   : pre-wrap;
            }

            blockquote {
                color        : gray;
                border-left  : 0.3em solid lightgray;
                padding-left : 1em;
                margin-left  : 0;
            }
        </style>
    </head>
    <body>
