# Bible Quizzing Rule Book

[![test](https://github.com/gryphonshafer/Quizzing-Rule-Book/workflows/test/badge.svg)](https://github.com/gryphonshafer/Quizzing-Rule-Book/actions?query=workflow%3Atest)
[![release](https://github.com/gryphonshafer/Quizzing-Rule-Book/workflows/release/badge.svg)](https://github.com/gryphonshafer/Quizzing-Rule-Book/actions?query=workflow%3Arelease)
[![codecov](https://codecov.io/gh/gryphonshafer/Quizzing-Rule-Book/graph/badge.svg)](https://codecov.io/gh/gryphonshafer/Quizzing-Rule-Book)

This project contains the source content, meta documents, and software tooling for the Bible Quizzing rule book.

## Current Official Renders

The following are the current official renders of documents auto-built from source content and meta documents.

### Rule Book: Minimalist Render

The minimalist render filters all special sections (such as terms, examples, commentary, and logic).

- [Rule Book: Minimalist Render as PDF](../../releases/latest/download/rule_book_min.pdf)
- [Rule Book: Minimalist Render as HTML](../../releases/latest/download/rule_book_min.html)
- [Rule Book: Minimalist Render as Markdown](../../releases/latest/download/rule_book_min.md)

### Rule Book: Reference Render

The "reference" render contains all material except for logic sections, and it moves all terms/definitions to an appendix.

- [Rule Book: Reference Render as PDF](../../releases/latest/download/rule_book_ref.pdf)
- [Rule Book: Reference Render as HTML](../../releases/latest/download/rule_book_ref.html)
- [Rule Book: Reference Render as Markdown](../../releases/latest/download/rule_book_ref.md)

### Rule Book: Full-Content Render

The full-content render contains all material.

- [Rule Book: Full-Content Render as PDF](../../releases/latest/download/rule_book_full.pdf)
- [Rule Book: Full-Content Render as HTML](../../releases/latest/download/rule_book_full.html)
- [Rule Book: Full-Content Render as Markdown](../../releases/latest/download/rule_book_full.md)

### Other Documents

Some other documents that are beyond the scope of the official rule book are also auto-built/rendered:

- Best Practices
    - [Best Practices as PDF](../../releases/latest/download/best_practices.pdf)
    - [Best Practices as HTML](../../releases/latest/download/best_practices.html)
- [Combined Governance Documents as PDF](../../releases/latest/download/governance.pdf)

## Project Overview

The project itself is governed by its own [Change Management Process](content/rule_book/change_management.md).

Source content and meta documents are written in Markdown following the project's:

- [Document Syntax](meta/syntax.md)
- [Style Guide](meta/style_guide.md)

Software consumes this content for a variety of purposes:

- Auto-building/rendering content output at specific interest levels
- Selecting portions of content based on situational applicability
- Describing software specifications for scoring and other objective algorithms and configuration settings

## Links to Auto-Built Documents

Upon any commit and push to `master` or `integration` branches, the auto-build render process is initiated. You can review and download any of these results via:

- [Releases](../../releases)

## Links to Source Documents

The following are links to source documents:

- Content
    - [Rule Book Index](content/rule_book/index.md)
    - [Best Practices](content/best_practices.md)
    - Governance
        - [Mission Statement](content/governance/mission.md)
        - [CMA Quizzing Leadership Team](content/governance/not_bylaws.md)
        - [Scholarships](content/governance/scholarships.md)
- Meta Documents
    - [Document Syntax](meta/syntax.md)
    - [Style Guide](meta/style_guide.md)
