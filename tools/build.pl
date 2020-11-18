#!/usr/bin/env perl
use exact -cli, -conf;
use File::Basename qw( dirname basename );
use Mojo::File 'path';
use PDF::FromHTML;
use Text::MultiMarkdown 'markdown';

my $opt = options( 'docs|d=s{,}', 'filter|f=s{,}', 'type|t=s', 'output|o=s' );

$opt->{docs}   = [ conf->get( qw( rule_book dir ) ) ] unless ( $opt->{docs} and @{ $opt->{docs} } );
$opt->{type} //= 'pdf';
$opt->{filter} = conf->get( qw( rule_book levels ) )
    if ( $opt->{filter} and grep { lc($_) eq 'all' } @{ $opt->{filter} } );

my $content_dir = conf->get( qw( config_app root_dir ) ) . '/' . conf->get( qw( content_dir ) );
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
            $content_dir . '/' . $_ . '/.md';
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

$output =~ s/^\s*#+\s*$_\s*$//img for ( @{ $opt->{filter} } );

if ( $opt->{type} eq 'html' or $opt->{type} eq 'pdf' ) {
    $output = markdown($output);
}

if ( $opt->{type} eq 'pdf' ) {
    my $pdf = PDF::FromHTML->new;
    $pdf->load_file(\$output);

    $pdf->convert(
        # With PDF::API2, font names such as 'traditional' also works
        # Font        => 'traditional',
        # LineHeight  => 10,
        # Landscape   => 1,

        PageWidth       => 640,
        PageResolution  => 540,
        FontBold        => 'HelveticaBold',
        FontOblique     => 'HelveticaOblique',
        FontBoldOblique => 'HelveticaBoldOblique',
        LineHeight      => 12,
        FontUnicode     => 'Helvetica',
        # Font            => (same as FontUnicode),
        PageSize        => 'A4',
        Landscape       => 0,
    );

    $pdf->write_file(\$output);
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

This program will build various documents from Markdown source files.

=head1 OPTIONS

=head2 -d, --docs

This is...
