#!/usr/bin/env perl
use exact -cli, -conf;
use File::Basename qw( dirname basename );
use Mojo::File 'path';
use PDF::WebKit;
use Text::MultiMarkdown 'markdown';

my $opt = options( 'docs|d=s{,}', 'filter|f=s{,}', 'type|t=s', 'output|o=s' );

$opt->{docs}   = [ conf->get( qw( rule_book dir ) ) ] unless ( $opt->{docs} and @{ $opt->{docs} } );
$opt->{type} //= 'pdf';
$opt->{filter} = conf->get( qw( rule_book levels ) )
    if ( $opt->{filter} and grep { lc($_) eq 'all' } @{ $opt->{filter} } );

my $content_dir = conf->get( qw( config_app root_dir ) ) . '/' . conf->get('content_dir');
my $output      = join( "\n",
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

$output =~ s/^\s*#+\s*$_\s.*?(?=\n#)//imsg for ( @{ $opt->{filter} } );

my %header_level;
sub headers ($level) {
    delete $header_level{$_} for ( grep { $_ > $level } keys %header_level );
    $header_level{$level}++;
    return join( '', map { $header_level{$_} . '.' } 2 .. $level );
}
$output =~ s/^(\s*)(#{2,})/ $1 . $2 . ' ' . headers( length($2) ) /mge;
$output =~ s/^(\s*)\-(#+)/$1$2/mg;

if ( $opt->{type} eq 'html' or $opt->{type} eq 'pdf' ) {
    $output =~ s/(\n\|[^\n]*\|[ \t]*\n\n)/$1\n/g;

    $output = q{<!doctype html>
        <html lang="en">
        <head>
            <title>Bible Quizzing Rule Book Project</title>
            <meta charset="utf-8">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,600;1,400;1,600&display=swap">

            <style type="text/css">

                body {
                    margin-left    : 0.5in;
                    margin-right   : 0.5in;
                    margin-top     : 0in;
                    margin-bottom  : 0.5in;
                    font-family    : 'Open Sans', sans-serif;
                    font-size      : 11pt;
                    line-height    : 1.5em;
                    letter-spacing : 0.01em;
                }

                section {
                    page-break-inside : avoid;
                }

                h1 {
                    margin: 24pt 0 12pt -12pt;
                    font-size : 24pt;
                    padding-bottom: 12pt;
                    border-bottom : 1px solid gainsboro;
                }

                h2 {
                    margin: 18pt 0 18pt -10pt;
                    font-size : 18pt;
                    padding-bottom: 6pt;
                    border-bottom : 1px solid gainsboro;
                }

                h3 {
                    margin: 16pt 0 16pt -8pt;
                    font-size : 16pt;
                }

                h4 {
                    margin: 13pt 0 13pt -6pt;
                    font-size : 13pt;
                }

                h5 {
                    margin: 12pt 0 12pt -4pt;
                    font-size : 12pt;
                }

                h6 {
                    margin: 11pt 0 11pt -2pt;
                    font-size : 11pt;
                }

                dt {
                    margin-left: 1em;
                }

                dd {
                    margin-bottom: 1em;
                }

                table {
                    border-collapse: collapse;
                }

                table,
                table th,
                table td {
                    border : 1px solid gainsboro;
                }

                th, td {
                    padding : 5px 10px;
                }

                tr:nth-child(even) td {
                    background-color: whitesmoke;
                }

                pre {
                    padding       : 1.0em 1.5em;
                    border-radius : 0.5em;
                }

                code {
                    border-radius : 0.25em;
                    padding       : 0.02em 0.25em;
                }

                pre > code {
                    border-radius : 0;
                    padding       : 0;
                }

                pre, code {
                    background-color : whitesmoke;
                    font-family      : monospace;
                    font-size        : 10pt;
                }

                blockquote {
                    color        : gray;
                    border-left  : 4px solid lightgray;
                    padding-left : 1em;
                    margin-left  : 0;
                }

            </style>
        </head>
        <body>
    } . markdown($output) . '</body></html>';

    $output =~ s|(<h\d[^\n]+)|</section><section>$1|g;
    $output =~ s|(</body></html>)|</section>$1|g;
    $output =~ s|</section><section>|<section>|;
    $output =~ s|(</section><section><h\d[^\n]+\s+)</section><section>(<h\d)|$1$2|g;
}

if ( $opt->{type} eq 'pdf' ) {
    my $kit = PDF::WebKit->new(
        \$output,
        'margin_left'   => '0.25in',
        'margin_right'  => '0.25in',
        'margin_top'    => '0.5in',
        'margin_bottom' => '0.25in',
    );
    $output = $kit->to_pdf;
}

if ( $opt->{output} ) {
    path( $opt->{output} )->spurt($output);
}
else {
    say $output;
}

=head1 NAME

build.pl - Build various documents from Markdown source files

=head1 SYNOPSIS

    build.pl OPTIONS
        -d, --docs   DOCS_LIST        (i.e. "rule_book best_practices"; default: all)
        -f, --filter BLOCKS_TO_FILTER (i.e. "commentary examples example" or "all"; default: none)
        -t, --type   OUTPUT_TYPE      (i.e. "md" or "html" or "pdf"; default: "pdf")
        -o, --output OUTPUT_FILE      (if not defined, output send to STDOUT)
        -h, --help
        -m, --man

=head1 DESCRIPTION

This program will build various documents as PDFs, HTML files, or Markdown files
using the project's Markdown source files.

=head1 OPTIONS

=head2 -d, --docs

List of the specific documents to build.

This can be directories that contain  content by name, like "rule_book" or
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
defined in the application configuration file under rule book "levels".

=head2 -t, --type

This is the type of output. There are only 2 options: "md", "html", and "pdf".
If not specified, "pdf" is assumed.

=head2 -o, --output

This is the file to which the output should be saved. If not specified, output
will be printed to STDOUT.
