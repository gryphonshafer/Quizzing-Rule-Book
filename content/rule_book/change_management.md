# Change Management Process

The Bible Quizzing Rule Book and all associated subordinate documentation are open for amendment by anyone. This describes the process for those changes and how the documents will be managed for annual *International Bible Quizzing* (IBQ) championship meets.

The rule book source material is written as a series of highly-structured Markdown files that can be used to automatically generate consumable content in a desired form. These source files along with supporting documentation and tooling are maintained in a public GitHub project:

[https://github.com/gryphonshafer/Quizzing-Rule-Book](https://github.com/gryphonshafer/Quizzing-Rule-Book)

For any proposed changes, the content change should be submitted as a *pull request* (PR) to this project. These submissions can be from anyone. If someone has a change proposal but is daunted by GitHub PR handling, they can contact the project's owner or anyone else for assistance.

Submitted PRs will be in an open review period for 3 calendar months from the date they are submitted, during which time they can be discussed and debated by anyone using the comment features on GitHub.

At the conclusion of the 3 months, a simple majority of the 6 quizzing members of the CQLT shall ratify or dismiss the PR. The CQLT may appoint a standing rules committee to whom ratification responsibility can be delegated. In that case, a simple majority of the standing rules committee is sufficient for PR ratification.

Submitted PRs that are ratified will be merged to an `integration` branch. Immediately following each IBQ, the `integration` branch will be merged to `master`. Whatever is in `master` will be considered the rule book and supporting documentation for the upcoming IBQ. No changes to `master` are allowed except for this single annual merge from `integration`.
