# Style Guide

What follows are style guide requirments for the rule book project. These are conventions we should attempt to follow, but they are not hard and fast rules like the [syntax document](syntax.md).

## Terms and Definitions

There are 3 styles to provide terms and definitions.

For simple sets of words, follow a modified *Associated Press* (AP) style. Provide the full name, like "Associated Press" in the previous sentence, as italic followed by an acronym or shortened name in parentheses.

For terms that can be described in a sentence, use Markdown's "Terms and Definitions" as defined in the [syntax document](syntax.md).

For terms that require lengthier definitions, write the term as a header and description as paragraphs below it.

## Reserved Header Names

There are header names that are reserved for special purposes:

- Application
- Commentary
- Examples
- Scoring

At any given normal header level (and thus any given spot within a document's information architecture), providing any of the reserved header names indicates that any content within that header is considered tagged by the reserved name such that processing of the source can selectively include or exclude that section.

The "Application" reserved header should contain English-Script appropriate for determining when the rule defined by the parent header is applicable. The "Scoring" reserved header should contain English-Script appropriate for calculating scoring effects.

## "Question" De-Overloading

The word "question" is significantly overloaded in the current rule book. We're going to try to de-overload it by splitting its usage among the following terms (which should be defined somewhere appropriate in the rule book):

**Question**
: Everything (type, ref, question text, answer text, etc.)

**Answer**
: Everything the quizzer says (answer, remaining question, ref, etc.)

**Question Text**
: The full question text of the question

**Answer Text**
: The full answer text of the question

**Read Question**
: Everything the QM says (excluding prompts and rulings)
