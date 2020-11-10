# Change Management Process

This document describes the change management process for the rule book and all related content and meta files written in Markdown in this project. The process will change based on what phase of the initial project we're in at the moment. Each phase is described below.

Note that changes to this document are also governed by the process described in this document.

## Phase 1: Version 1 Development

The initial version development of this project consists of all work conducted on or after Sunday, November 1, 2020 through to the beginning of phase 2, as defined by phase 2. There are 4 developers involved in phase 1:

- Gryphon Shafer
- Scott Peterson
- Jeremy Swingle
- Zachary Tinker

During the initial version development of this project, all changes will be made as follows:

1. A change's author should submit the change as a *Pull Request* (PR) to the project's `master` branch
2. At least 1 developer other than the author should comment on the PR; however, ideally many developers will comment
3. Discussion, debate, and revisions to the PR happen all within GitHub's PR system
4. PR authors will resolve comment threads after:
    - When at least 1 other developer agrees with the PR author or 2 developers agree with each other, which will overrule the PR author
    - The PR author has writen changes to the PR such that the comment thread's end-state vector is addressed
5. The PR is merged to `master` when any of the following is true:
    - 1 developer other than the author agrees with the change and there are no disagreements from the other developers after 1 week from PR submission
    - 2 developers other than the author agree with the change

## Phase 2: Version 1 Quality Assurance

Phase 2 begins once all 4 developers agree that all primary writing and editing that was part of phase 1 has concluded. Additional editing may still take place, but at this point, all 4 developers believe they have a working product that, while potentially containing errors, is not likely missing information.

The following are the steps of phase 2:

1. Gryphon conducts an "OCD pass" of all content, making it align exactly with syntax, style, and other requirements
2. Gryphon submits a PR for review by the other 3 developers
3. Discussion and debate take place as part phase 1 PRs, and eventually the PR is merged to `master`
4. Gryphon builds a single *Adobe PDF file* (PDF) for the entire project
5. Gryphon creates a PR covering the entire project

## Phase 3: CQLT Review and Approval

The PDF will be submitted to the CQLT for review and approval. The 6 quizzing members of the CQLT will have 1 calendar month from the date of submission to review and provide feedback on the submission. Any feedback other than general approval should be made as GitHub comments to the PR covering the entire project.

The 4 developers will respond to any feedback, potentially creating subsequent versions of the output from phase 2 as necessary.

At the end of the 1 month review period of phase 3, if there are no unresolved comments regarding *functional equivalence* (FE) variance, the 6 quizzing members of the CQLT will vote to approve.

## Phase 4: District Ratification

Following the conclusion of phase 3, Gryphon will make available a ratification PR similar to the PR from phase 3 and generate a final PDF of the whole of the project's content. Zachary will submit the PDF and PR link to all "active" districts. ("Active" will mean districts that have responded to the CQLT's email sent October 30, 2020.) Everyone will do as much as they reasonably can to encourage a broad a reading and solicitation of feedback from all Quizzingdom as possible.

During phase 4, anyone may provide feedback on the phase 4 PR. All feedback should be made in the form of comments on the PR on GitHub as this assures us of universal public transparency. The 4 developers will respond to this feedback as they did for phase 3 feedback. The deadline for filing comments will be 3 calendar months from the date phase 4 began.

When a *district's coordinator* (DC) confirms to his or her satisfaction that the PDF represents FE to the current rule book, that DC will notify Zachary of his or her district's ratification of the PDF. Once Zachary receives ratification notification from over 66% of the "active" districts, then phase 4 is complete. The deadline for receiving votes from DCs will be 1 month after the deadline for filing comments. Any "active" district not casting a vote by this deadline will be considered "inactive" for the purposes of this vote. Any DC voting against ratification will be required to provide one or more explicit reasons for their vote.

At this point, the PDF will be ratified but not implemented. It will be at the CQLT's sole discretion as to when to implement the PDF as the rule book for *International Bible Quizzing* (IBQ). It will be at each district's sole discretion as to when to implement the PDF as the rule book for their district programs.

## Phase 5: Ongoing Change Management

This phase is the ongoing change management mechanism for this project indefinitely. This phase beings immediately after Zachary receives 11 or more district ratifications.

For any changes in this phase, changes should be submitted as PRs in GitHub. These submissions can be from anyone. If someone has a change proposal but is daunted by GitHub PR management, they can contact any of the 4 original developers who can offer assistance as they are able.

Submitted PRs will be in an open review period of 3 months, during which time they can be discussed and debated by anyone. At the conclusion of the 3 months, a simple majority of the 6 quizzing members of the CQLT shall ratify or dismiss the PR. The CQLT may appoint a standing rules committee to whom ratification responsibility can be delegated. In that case, a simple majority of the standing rules committee is sufficient for PR ratification.

Submitted PRs that are ratified will be merged to an `integration` branch, not `master`.

During or immediately following each IBQ, the `integration` branch will be merged to `master`. Whatever is in `master` will be considered the rule book and supporting documentation for the upcoming IBQ. No changes to `master` are allowed except for this single annual merge from `integration`.
