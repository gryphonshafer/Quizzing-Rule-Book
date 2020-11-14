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
- Example/Examples
- Scoring

At any given normal header level (and thus any given spot within a document's information architecture), providing any of the reserved header names indicates that any content within that header is considered tagged by the reserved name such that processing of the source can selectively include or exclude that section.

The "Application" reserved header should contain English-Script appropriate for determining when the rule defined by the parent header is applicable. (Note that "Application" headers are unlikely to exist in version 1 and will slowly appear in greater number over successive versions.) The "Scoring" reserved header should contain English-Script appropriate for calculating scoring effects.

Here's an example use-case:

    ### Quiz Question Topic

    This is a paragraph describing the rules for this
    particular quiz question topic.

    #### Application

        If specific situation is true and a different specific
        situation is true, then application is true.

    #### Commentary

    This is commentary around this quiz question topic.

    #### Examples

    This is an example of this quiz question topic.

    This is another example of this quiz question topic.

    #### Scoring

        If specific situation is true and a different specific
        situation is true, then add 10 to team score.

It's unlikely that all reserved header names will apply.
