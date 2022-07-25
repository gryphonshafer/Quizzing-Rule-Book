# Bible Quizzing Rule Book

[![test](https://github.com/gryphonshafer/Quizzing-Rule-Book/workflows/test/badge.svg)](https://github.com/gryphonshafer/Quizzing-Rule-Book/actions?query=workflow%3Atest)
[![release](https://github.com/gryphonshafer/Quizzing-Rule-Book/workflows/release/badge.svg)](https://github.com/gryphonshafer/Quizzing-Rule-Book/actions?query=workflow%3Arelease)
[![codecov](https://codecov.io/gh/gryphonshafer/Quizzing-Rule-Book/graph/badge.svg)](https://codecov.io/gh/gryphonshafer/Quizzing-Rule-Book)

This project contains the source content and meta documents for the Bible Quizzing rule book.

## Current Official Renders

The following are the current official renders of documents auto-built from source content and meta documents.

### Rule Book: Standard Render

The standard render filters logic sections but keeps everything else.

- [Rule Book: Standard Render as HTML](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_std.html)
- [Rule Book: Standard Render as "Paged" HTML](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_std.paged.html)
- [Rule Book: Standard Render as Markdown](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_std.md)

### Rule Book: Minimalist Render

The minimalist render filters all special sections (such as terms, examples, commentary, and logic).

- [Rule Book: Minimalist Render as HTML](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_min.html)
- [Rule Book: Minimalist Render as "Paged" HTML](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_min.paged.html)
- [Rule Book: Minimalist Render as Markdown](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_min.md)

### Rule Book: Reference Render

The "reference" render contains all material except for logic sections, and it moves all terms/definitions to an appendix.

- [Rule Book: Reference Render as HTML](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_ref.html)
- [Rule Book: Reference Render as "Paged" HTML](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_ref.paged.html)
- [Rule Book: Reference Render as Markdown](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_ref.md)

### Rule Book: Full-Content Render

The full-content render contains all material.

- [Rule Book: Full-Content Render as HTML](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_full.html)
- [Rule Book: Full-Content Render as "Paged" HTML](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_full.paged.html)
- [Rule Book: Full-Content Render as Markdown](https://gldg.us/gh/gryphonshafer/test-book/releases/latest/download/rule_book_full.md)

## Project Overview

The project itself is governed by its own [Change Management Process](rule_book/change_management.md).

Source content and meta documents are written in Markdown following the project's:

- [Document Syntax](meta/syntax.md)
- [Style Guide](meta/style_guide.md)

## Links to Auto-Built Documents

Upon any commit and push to `master` or `integration` branches, the auto-build render process is initiated. You can review and download any of these results via:

- [Releases](../../releases)
