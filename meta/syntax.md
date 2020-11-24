# Document Syntax

The following document describes and demonstrates how to use document syntax. Document syntax is a subset of MultiMarkdown. Unless explicitly stated, all syntax within this document is supported. Only what is specified in this document is supported. Generally speaking, paragraphs should be written without line breaks and separated by two line breaks (resulting in a single empty line).

A back-tick is a `. Back-ticks are used in the source of this document to render code for a given markup. Do not use back-ticks in the document.

## Text Emphasis

Emphasis, italics, words are written with *single asterisks*. (`*single asterisks*`).

Strong emphasis, bold, words are written with **double asterisks**. (`**double asterisks**`)

Combined emphasis and strong emphasis can be done with with ***triple asterisks***. (`***triple asterisks***`)

## Lists

Lists should always be simple bullet lists, constructed with dashes, `-` as the first character.

- All lists should begin with no indentation
- There should always be multiple items in a list
    - Sub-lists must be indented exactly 4 spaces

## Block Quotes

Block quotes are supported by starting a line with a `>` character.

> In the beginning was the Word, and the Word was with God, and the Word was God.

## Terms and Definitions

Terms and definitions such as the following are supported:

**Term**
: Definition

The syntax for which is:

    Term
    : Definition

## Links

External links (like to <https://pnwquizzing.org>) should be in the form `<https://pnwquizzing.org>`.

## Tables

Tables such as the following are supported:

| Tables   | Are           | Supported  |
|----------|:-------------:|-----------:|
| col 3 is | right-aligned |     $1,600 |
| col 2 is | centered      |        $12 |
| col 1 is | left-aligned  |         $1 |

The syntax for which is (with `\n` representing a line break):

    | Tables   | Are           | Supported  |\n
    |----------|:-------------:|-----------:|\n
    | col 3 is | right-aligned |     $1,600 |\n
    | col 2 is | centered      |        $12 |\n
    | col 1 is | left-aligned  |         $1 |\n

## English-Script

English-Script (or English::Script) is a strict subset of simple English that can be used to stipulate rules in human-readable English that can be converted into software code. All English-Script lines should be indented using intent spacing of 4 spaces per indent. For example:

    Set prime to 3.
    Set the special prime value to 3.
    Set the answer to 123,456.78.

    If the question type is "INT" then apply the following block.
        If the jumped quizzer correct sum is 4, then set the jumped quizzer quiz out to true.
        Set the alert message to "Quiz out!"
    This is the end of the block.

**Use indented code *only* for English-Script.** For a complete set of English-Script grammar: <https://metacpan.org/pod/English::Script#DEFAULT-GRAMMAR>

## Headers

`# Header 1 Example`

Header 1 are used for section titles. Section titles in the current document are large, blue, and bold with a red horizontal rule underneath. There should only ever be 1 "Header 1" per document, and it should always be the document's first line and represent it's title. Note that filenames should always be the header in full lower-case with spaces replaced with underscores and an `.md` extension.

`## Header 2 Example`

Header 2 are used for sub-section titles. Sub-section titles in the current document are red and bold.

`### Header 3 Example`

Header 3 are used for part titles. Part titles in the current document are black, bold, and underlined.

`#### Header 4 Example`

`##### Header 5 Example`

`###### Header 6 Example`
