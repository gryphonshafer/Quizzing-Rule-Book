# Quiz Meets

The tournament brackets are based on 3 things: A preliminary round (or "prelims"), an elimination round (or "brackets") at the discretion of the meet director, and championship quizzes.

## Preliminary Rounds

Team points are calculated using a team's score at the end of question 20, together with their place, which could be determined at the end of question 20 or after the end of overtime. Teams start with a base number of points based on their place and receive additional points based on their team score. The specifics are detailed in the section below.

In case of a tie, points are awarded according to the team score at the end of question 20. Overtime is used solely to determine placements.

If ties are not being broken in prelims, more than 1 team can receive 1st place or 2nd place points. If 2 tied for 1st, then other team is 3rd. If 2 tied for 2nd, then the 1st team is 1st and the other 2 are 2nd.

### Team Points Calculation

Team points are calculated by dividing the team score immediately after question 20 (including any A and B questions) by 10 and then applying placement adjustment:

- No change for 1st, minimum of 10 points
- -1 points for 2nd, minimum of 5 points
- -2 points for 3rd, minimum of 1 point

#### Logic

    Set place to 1.
    For each team in the teams list, apply the following block.
        If place is 1, then apply the following block.
            Set base points to 10.
            Set overage origin to 100.
        This is the end of the block.
        Otherwise, if place is 2, then apply the following block.
            Set base points to 5.
            Set overage origin to 60.
        This is the end of the block.
        Otherwise, if place is 3, then apply the following block.
            Set base points to 1.
            Set overage origin to 30.
        This is the end of the block.

        Set score overage to team score at the end of regular quizzing minus overage origin.
        If score overage is less than 0, then set score overage to 0.
        Set team points to score overage divided by 10 plus base points.
    This is the end of the block.

## Elimination Rounds

The following may be used, in order, to break ties in team placements after preliminary quizzing:

- Head-to-head competition in previous quizzes
- Total points scored in preliminaries
- Least number of errors

In addition, a tie-breaker quiz may be used for ties that determine which bracket a team will compete in for elimination quizzing.

### Elimination Round Brackets

#### Tournament Bracket "A"

This bracket is based on the "winner-move-up" philosophy and is designed to select the best team out of a possible 9 teams through winning rather than losing. The teams are then arranged in order (from 1st to 9th place) by points. The winners of quizzes A, D, and F meet in quiz G for the championship.

In this bracket, the top 3 teams are involved in a triple-elimination, the middle 3 teams in a double-elimination, and the last 3 teams in a single-elimination. This way only those teams that have earned the right through winning will advance to the final quiz.

**Bracket Design**

This bracket does not require each team to lose to be eliminated.

- Quiz A: Teams 1, 2, 3
- Quiz B: Teams 4, 5, 6
- Quiz C: Teams 7, 8, 9
- Quiz D: 2nd Quiz A, 3rd Quiz A, 1st Quiz B
- Quiz E: 2nd Quiz B, 3rd Quiz B, 1st Quiz C
- Quiz F: 2nd Quiz D, 3rd Quiz D, 1st Quiz E
- Quiz G: Winner Quiz A, Winner Quiz D, Winner Quiz F
- Quiz H: Same 3 Teams in Quiz G

**Championship Quiz**

- Quiz I: If the winner of Quiz G does not win Quiz H, Quiz I will have the winners of Quiz G and H (only). The other team will be eliminated.

#### Tournament Bracket "B"

Each team in the final 9 must lose twice. A team may make the finals by actually winning only 1 quiz in this tournament bracket.

**Bracket Design**

- Quiz A: Teams 1, 6, 7
- Quiz B: Teams 2, 5, 8
- Quiz C: Teams 3, 4, 9
- Quiz D: 1st Quiz A, 1st Quiz C, 2nd Quiz B
- Quiz E: 1st Quiz B, 2nd Quiz A, 2nd Quiz C
- Quiz F: 3rd Quiz A, 3rd Quiz B, 3rd Quiz C
- Quiz G: 3rd Quiz D, 3rd Quiz E, 1st Quiz F
- Quiz H: 2nd Quiz D, 2nd Quiz E, 1st Quiz G

**Championship Quizzes**

- Quiz I: 1st Quiz D, 1st Quiz E, 1st Quiz H
- Quiz J: 2nd Quiz I, 1st Quiz I, 3rd Quiz I
- Quiz K: 2nd Quiz J, 1st Quiz J, 3rd Quiz J (when no team has taken 1st twice)

If the same team took 3rd place in Quiz I and J, then Quiz K will be a 2-team quiz to determine 1st and 2nd place.

- Quiz L: 3rd Quiz K, 1st Quiz K, 2nd Quiz K (when no team has taken 1st twice)

#### Tournament Bracket "C"

This bracket is a combination of brackets A and B. A team must win at least 2 quizzes to obtain a position in the finals.

**Bracket Design**

- Quiz A: Teams 1, 4, 9
- Quiz B: Teams 2, 5, 7
- Quiz C: Teams 3, 6, 8
- Quiz D: 1st Quiz A, 1st Quiz B, 1nd Quiz C
- Quiz E: 2nd Quiz A, 2nd Quiz B, 2nd Quiz C
- Quiz F: 3rd Quiz A, 3rd Quiz B, 3rd Quiz C
- Quiz G: 2nd Quiz D, 3rd Quiz D, 1st Quiz E
- Quiz H: 2nd Quiz E, 3rd Quiz E, 1st Quiz F
- Quiz I: 2nd Quiz G, 3rd Quiz G, 1st Quiz H

**Championship Quizzes**

- Quiz J: 1st Quiz D, 1st Quiz G, 1st Quiz I
- Quiz K: 2nd Quiz J, 1st Quiz J, 3rd Quiz J
- Quiz L: 2nd Quiz K, 1st Quiz K, 3rd Quiz K (when no team has taken 1st twice)

If the same team took 3rd place in Quiz J and K, then Quiz L will be a 2-team quiz to determine 1st and 2nd place.

- Quiz M: 3rd Quiz L, 1st Quiz L, 2nd Quiz L (when no team has taken 1st twice)

## Championship Quizzes

A team must win twice to become the champion team. All 3 teams will continue to quiz until 1 team wins twice.

If the same team wins the 1st 2 championship quizzes, 2nd place is determined by the most 2nd places. If that is a tie, 2nd place will be determined by the clarification section (below).

If the champion team is determined in 3 quizzes, 2nd and 3rd places will be determined by the clarification section (below).

If the champion team is determined in 4 quizzes, 2nd place is determined by the most 2nd places. If that is a tie, 2nd place will be determined by the clarification section (below).

### Clarification for 2nd and 3rd Place

If necessitated from the above championship quizzes, 2nd place will be determined as follows:

1. The team that scored the most points in the championship quizzes; or if there is a tie,
2. The winner if the 2 teams quizzed earlier; or
3. The team with the highest average points in the final 9; or if there is a tie,
4. The highest standing in the preliminary round
