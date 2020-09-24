# Quiz Events

    Set the question answer duration to 30.

## Rulings

### Correct

### Incorrect

### Challenges

### Protests

## Fouls

## Time-Outs

    Set the timeout duration to 60.

## Substitutions

## Scoring

Below are the the scoring calculation rules and the logic for them. This procedure is executed after every "quiz event" (defined below).

### Scoring Terms and Definitions

**Quiz Event**
: Label for whatever quiz event triggered the run of the procedure; possible values are: "question", "foul", "timeout", "sub-in", "sub-out", "challenge", "unreadiness", and "unsportsmanlike"

**Quiz Type**
: Current quiz type, defined under the *Quiz Process/Types of Quizzes* section

**Current/Next Question Form**
: Current or next question "form" such as: "Standard", "Toss-Up", and "Bonus"

**Current/Next Question Integer**
: Current or next question core integer value; for example, if on question 17A, the value is 17

**Current/Next Question Label**
: Current or next question label, the possible suffix; for example, if on question 17A, the value is A

**Current/Next Question Number**
: Current or next question number, which is a combination of integer and label

**Ruling**
: Ruling on a question; possible values are: "correct", "incorrect", and "none" (meaning no jump)

**Challenge**
: Ruling on a challenge; possible values are: "accepted" and "overruled"

**Overruled Challenges**
: Integer representing total overruled challenges for the given team

**Quizzer Score Increment**
: Amount the given quizzer's score should be incremented

**Team Score Increment**
: Amount the given team's score should be incremented

**Quizzer Correct Answers**
: Integer representing total correct answers for the given quizzer

**Quizzer Incorrect Answers**
: Integer representing total incorrect answers for the given quizzer

**Team Correct Answers**
: Integer representing total correct answers for the given team

**Team Incorrect Answers**
: Integer representing total incorrect answers for the given team

**Team Quizzers with Correct Answers**
: Integer representing total number of quizzers for the given team with correct answers

**Quizzer Fouls**
: Integer representing total number of fouls for the given quizzer

**Team Fouls**
: Integer representing total number of fouls for the given team

**Quizzer Name**
: Name of the given quizzer (first and last)

**Scoresheet Label**
: String (which should be irreducably short) that will be filled in the appropriate scoresheet cell for the given quizzer (and given team provided "Scoresheet Team Label" is not also defined)

**Scoresheet Team Label**
: String (which should be irreducably short) that will be filled in the appropriate scoresheet cell for the given team; normally, this is left undefined and thus "Scoresheet Label" is used

**Message**
: An optional string for a message text to display; for example: "Quiz Out"

**Team Roster**
: This is an array of quizzer objects, each of which contains a "correct answers" value

### Scoring Logic

This is the scoring logic, defined using English-Script. (For more information, see <https://metacpan.org/pod/English::Script#DEFAULT-GRAMMAR>).

    If the quiz event is a "question", then apply the following block.
        If the ruling is "correct", then apply the following block.
            If the current question form is not "Bonus", then apply the following block.
                Add 1 to quizzer correct answers.
                Add 1 to team correct answers.
            This is the end of the block.

            For each specific quizzer in the team roster, apply the following block.
                If the specific quizzer correct answers value is greater than 0,
                    then add 1 to the team quizzers with correct answers.
            This is the end of the block.

            Set the quizzer score increment to 20.
            Set the team score increment to 20.
            Set the scoresheet label to 20.
            Set the next question form to "Standard".
            Set the next question number to the current question integer plus 1.

            If
                the quiz type is not "2-Team 15-Question Tie-Breaker" and
                the current question integer is greater than or equal to 17 or
                the quiz type is "2-Team 15-Question Tie-Breaker" and
                the current question integer is greater than or equal to 13,
            then set reduced bonus points to true.

            If the current question form is "Bonus", then apply the following block.
                If reduced bonus points is true, then apply the following block.
                    Set the quizzer score increment to 10.
                    Set the team score increment to 10.
                    Set the scoresheet label to 10.
                This is the end of the block.

                Append "B" to the scoresheet label.
            This is the end of the block.

            Otherwise, if
                the team quizzers with correct answers value is greater than or equal to 3
                and the quizzer correct answers value is 0,
            then apply the following block.
                Add 10 to the team score increment.
                Append "+" to the scoresheet label.
                Set type of nth bonus to team quizzers with correct answers value plus 1.
                Set message to type of nth bonus plus "-Quizzer Bonus: " plus quizzer name.
            This is the end of the block.

            Otherwise, if the quizzer correct answers is 4 and the current question form is not "Bonus",
                then apply the following block.

                If the quizzer incorrect answers is 0, then apply the following block.
                    Add 10 to the team score increment.
                    Add 10 to the quizzer score increment.
                    Append "+" to the scoresheet label.
                This is the end of the block.

                Set message to "Quiz Out: " plus quizzer name.
            This is the end of the block.
        This is the end of the block.

        Otherwise, if the ruling is "incorrect", then apply the following block.
            If the current question form is not "Bonus", then apply the following block.
                Add 1 to quizzer incorrect answers.
                Add 1 to team incorrect answers.
            This is the end of the block.

            Set the scoresheet label to "E".

            If the current question form is "Standard" the quiz type begins with "3", then
                set the next question form to "Toss-Up".
            Otherwise, if
                the current question form is "Toss-Up" or
                the current question form is "Standard" and the quiz type begins with "2", then
                set the next question form to "Bonus".
            Otherwise, if the current question form is "Bonus", then apply the following block.
                Set the scoresheet label to "BE";
                set the next question form to "Standard".
            This is the end of the block.

            If
                the current question integer is less than 16 and
                the quiz type is not "2-Team 15-Question Tie-Breaker" or
                the current question integer is less than 12 and
                the quiz type is "2-Team 15-Question Tie-Breaker",
                then set the next question number to the current question integer plus 1.
            Otherwise, if
                the current question number is the current question integer and
                the current question form is not "Bonus" and
                the quiz type is not "2-Team 15-Question Tie-Breaker",
                then set the next question number to the current question integer plus "A".
            Otherwise, if
                the current question number is the current question integer plus "A" and
                the current question form is not "Bonus" or
                the current question number is the current question integer and
                the quiz type is "2-Team 15-Question Tie-Breaker",
                then set the next question number to the current question integer plus "B".
            Otherwise, if
                the current question number is the current question integer plus "B" and
                the current question form is "Bonus",
                then set the next question number to the current question integer plus 1.

            If the current question form is not "Bonus", then apply the following block.
                If
                    the quizzer incorrect answers value is greater than or equal to 2 or
                    the team incorrect answers value is greater than or equal to 3,
                then apply the following block.
                    Set the quizzer score increment to -10.
                    Set the team score increment to -10.
                    Append "--" to the scoresheet label.
                This is the end of the block.
                Otherwise, if
                    the current question integer is greater than or equal to 17,
                then apply the following block.
                    Set the team score increment to -10.
                    Append "-" to the scoresheet label.
                This is the end of the block.
            This is the end of the block.

            If the quizzer incorrect answers value is 3,
                then set message to "Error Out: " plus quizzer name.
        This is the end of the block.

        Otherwise, if the ruling is "none" then apply the following block.
            Set the next question form to "Standard".
            Set the next question number to the current question integer plus 1.
        This is the end of the block.

        If the quiz type is "3-Team 20-Question" or the quiz type is "2-Team 20-Question",
            then set 20 question quiz to true.

        If
            20 question quiz is true and
            the next question form is "Standard" and
            the next question number is 21,
        then set the quiz type to "2-Team Overtime".
    This is the end of the block.

    Otherwise, if the quiz event is a "foul", then apply the following block.
        Add 1 to quizzer fouls.
        Add 1 to team fouls.
        Set the scoresheet label to "F".

        If the quizzer fouls value is greater than or equal to 2, then apply the following block.
            Set the quizzer score increment to -10.
            Set the team score increment to -10.
            Append "--" to the scoresheet label.
        This is the end of the block.
        Otherwise, if the team fouls value is greater than or equal to 3, then apply the following block.
            Set the team score increment to -10.
            Append "-" to the scoresheet label.
        This is the end of the block.
    This is the end of the block.

    Otherwise, if the quiz event is a "timeout", then set the scoresheet team label to "T".
    Otherwise, if the quiz event is a "sub-in", then set the scoresheet team label to "S+".
    Otherwise, if the quiz event is a "sub-out", then set the scoresheet team label to "S-".
    Otherwise, if the quiz event is a "challenge", then apply the following block.
        Set the scoresheet team label to "C".
        If the challenge is overruled, then apply the following block.
            Add 1 to overruled challenges.
            If the overruled challenges value is greater than or equal to 2, then apply the following block.
                Set the team score increment to -10.
                Append "-" to the scoresheet team label.
            This is the end of the block.
            Otherwise, append "~" to the scoresheet team label.
        This is the end of the block.
        Otherwise, append "^" to the scoresheet team label.
    This is the end of the block.
    Otherwise, if the quiz event is a "unreadiness", then apply the following block.
        Set the scoresheet team label to "R-".
        Set the team score increment to -20.
    This is the end of the block.
    Otherwise, if the quiz event is a "unsportsmanlike", then apply the following block.
        Set the scoresheet team label to "U-".
        Set the team score increment to -10.
    This is the end of the block.
