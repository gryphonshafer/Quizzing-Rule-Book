#!/usr/bin/env perl
use exact -cli;
use Mojo::File 'path';
use Text::MultiMarkdown 'markdown';

my $opt = options( qw{ input|i=s } );

pod2usage('Input must be defined') unless $opt->{input};
pod2usage('Unable to read input') unless -r $opt->{input};

say markdown( path( $opt->{input} )->slurp );

=head1 NAME

render.pl - Build HTML from Markdown files

=head1 SYNOPSIS

    sass.pl OPTIONS
        -i, --input  # relative path and filename to Markdown source file
        -h, --help
        -m, --man

=head1 DESCRIPTION

This program will build HTML from Markdown files.

=head1 OPTIONS

=head2 -i, --input

This should be the relative path and filename to Markdown source file.
