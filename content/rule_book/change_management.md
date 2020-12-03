# Change Management Process

This rule book and all associated subordinate documentation, data files, configuration files, software, and other files contained within a GitHub project are open for amendment by anyone. The GitHub project is:

[https://github.com/gryphonshafer/Quizzing-Rule-Book](https://github.com/gryphonshafer/Quizzing-Rule-Book)

This is the management process for those changes and how the documents will be managed for annual *International Bible Quizzing* (IBQ) championship meets.

## Issue Submission

Proposed changes should be submitted as an "Issue" to the GitHub project.

[https://github.com/gryphonshafer/Quizzing-Rule-Book/issues/new](https://github.com/gryphonshafer/Quizzing-Rule-Book/issues/new)

Submitted issues will contain:

- A short but fully descriptive title
- A description that includes:
    - Reference to the section or sections to be amended
    - Proposed amendments to the section or sections
    - Rationale for the changes

## Issue Review and Open Discussion

Everyone is invited to review and discuss submitted issues, adding comments to them to further the discussion. An authorized *Rules Committee* (RC) will review each submitted issue for quality, appropriateness, integrational impact, and other factors. The RC will add comments on the issue as necessary to improve or solicit improvements upon any area the RC feels is needed.

The RC will review all open issues at least every 3 months and will by a simple majority vote decide if each issue is ready for progression, needs to remain in discussion, or should be closed without further action. In all cases, the RC should at minimum provide a summary status explanation comment on every issue it reviews. If an issue is deemed ready for progression, the RC will see that a *pull request* (PR) is created and the issue closed. The PR will be constructed against the `integration` branch of the project.

## Integration Pull Requests

PRs to the `integration` branch will be in an open review period for 3 calendar months from the date they are created, during which time they can be discussed and debated by anyone using the comment features on GitHub. At the conclusion of the 3 months, a simple majority of RC will approve or reject the PR. An approved PR will be immediately merged to the `integration` branch.

## Annual CQLT Ratification

Annually, the CQLT will review a PR of the `integration` branch merged to the `master` branch. A simple majority of the CQLT will ratify or reject the PR. When ratified, the PR will be merged to `master` immediately following that season's IBQ. Whatever is in `master` will be considered the rule book and supporting documentation for the upcoming IBQ.

## Changes to the Master Branch

No changes to `master` are allowed except for:

- The single annual merge from `integration`
- Non-functional changes such as:
    - Punctuation
    - Formatting
    - Grammar
    - Fixes for automated test failures

## Change Notification from GitHub

It's highly recommended anyone interested in following or participating in any rule book discussions or for those who would like to be notified when new rule book versions are published should "Watch" the GitHub project by clicking the "Watch" button near the upper right of the project's home page and selecting the desired watch level.
