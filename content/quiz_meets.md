# Quiz Meets

## Preliminary Rounds

### Team Points Calculation

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

## Championship Quizzes
