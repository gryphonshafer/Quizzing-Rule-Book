# Quiz Events

    Set question answer duration to 30.

## Rulings

### Correct

### Incorrect

### Challenges

### Protests

## Fouls

## Time-Outs

    Set timeout duration to 60.

## Substitutions

## Scoring

**TODO:** Convert the below JavaScript into English-Speak.

    // input.
    //     number   : Current question number (i.e. "16", "17A")
    //     as       : Current question "as" value (i.e. "Standard", "Toss-Up", "Bonus")
    //     form     : Type of event (enum: "question", "foul", "timeout", "sub-in",
    //                "sub-out", "challenge", "readiness", "unsportsmanlike" )
    //     result   : Result of current answer (enum: "success", "failure", "none" )
    //     quizzer  : Quizzer data object (of quizzer for the event)
    //     quizzers : Array of quizzer data objects (of all quizzers in the team)
    //     team     : Team data object
    //     quiz     : Complex data structure of teams, quizzers, and scores
    //     history  : Array of questions and results of the past in the quiz thus far
    //     sk_type  : The current score type in use (as defined on admin page and set in quiz setup)
    //     sk_types : All score types for the current program (as defined on admin page)

    // output.
    //     number      : Next question number (i.e. "16", "17A")
    //     as          : Next question "as" value (i.e. "Standard", "Toss-Up", "Bonus")
    //     quizzer     : Quizzer incremental score value following result
    //     team        : Team incremental score value following result
    //     label       : Text for the quizzer/question cell scoresheet display
    //     team_label  : Text override for the team cell scoresheet display
    //     skip_counts : Boolean; default false; if true, will skip quizzer counts incrementing
    //     message     : Optional alert message text (i.e. "Quiz Out")
    //     sk_type     : If set, will change the current score type to this value

    var int_number = parseInt( input.number );
    output.number  = input.number;
    output.as      = input.as;

    if ( input.as == "Bonus" ) output.skip_counts = true;

    if ( input.form == "question" ) {
        if ( input.result == "success" ) {
            output.as      = "Standard";
            output.number  = int_number + 1;
            output.quizzer = 20;
            output.team    = 20;
            output.label   = 20;

            if (
                input.as == "Bonus" && (
                    ( int_number >= 17 && input.sk_type != "2-Team 15-Question Tie-Breaker" ) ||
                    ( int_number >= 13 && input.sk_type == "2-Team 15-Question Tie-Breaker" )
                )
            ) {
                output.quizzer = 10;
                output.team    = 10;
                output.label   = 10;
            }

            if ( input.as == "Bonus" ) {
                output.label += "B";
            }
            else {
                var quizzers_with_corrects = input.quizzers.filter( function (value) {
                    return value.correct > 0;
                } );
                if ( quizzers_with_corrects.length >= 2 && input.quizzer.correct == 0 ) {
                    output.team  += 10;
                    output.label += "+";
                    output.message =
                        ( quizzers_with_corrects.length + 1 ) + "-Quizzer Bonus: " + input.quizzer.name;
                }
            }

            if ( input.quizzer.correct == 3 && input.as != "Bonus" ) {
                if ( input.quizzer.incorrect == 0 ) {
                    output.team    += 10;
                    output.quizzer += 10;
                    output.label   += "+";
                }
                output.message = "Quiz Out: " + input.quizzer.name;
            }
        }
        else if ( input.result == "failure" ) {
            output.label = "E";

            if ( input.as == "Standard" && input.sk_type.substr( 0, 1 ) == "3" ) {
                output.as = "Toss-Up";
            }
            else if (
                input.as == "Toss-Up" ||
                ( input.as == "Standard" && input.sk_type.substr( 0, 1 ) == "2" )
            ) {
                output.as = "Bonus";
            }
            else if ( input.as == "Bonus" ) {
                output.label = "BE";
                output.as    = "Standard";
            }

            if (
                ( int_number < 16 && input.sk_type != "2-Team 15-Question Tie-Breaker" ) ||
                ( int_number < 12 && input.sk_type == "2-Team 15-Question Tie-Breaker" )
            ) {
                output.number = int_number + 1;
            }
            else if (
                input.number == int_number && input.as != "Bonus" &&
                input.sk_type != "2-Team 15-Question Tie-Breaker"
            ) {
                output.number = int_number + "A";
            }
            else if (
                input.number == int_number + "A" && input.as != "Bonus" ||
                ( input.number == int_number && input.sk_type == "2-Team 15-Question Tie-Breaker" )
            ) {
                output.number = int_number + "B";
            }
            else if (
                input.number == int_number + "B" || input.as == "Bonus"
            ) {
                output.number = int_number + 1;
            }

            if ( input.as != "Bonus" ) {
                if ( input.quizzer.incorrect >= 1 || input.team.incorrect >= 2 ) {
                    output.quizzer = -10;
                    output.team    = -10;
                    output.label   += "--";
                }
                else if ( int_number >= 17 ) {
                    output.team  = -10;
                    output.label += "-";
                }
            }

            if ( input.quizzer.incorrect == 2 )
                output.message = "Error Out: " + input.quizzer.name;
        }
        else if ( input.result == "none" ) {
            output.as     = "Standard";
            output.number = int_number + 1;
        }

        if (
            output.as == "Standard" && output.number == 21 &&
            ( input.sk_type == "3-Team 20-Question" || input.sk_type == "2-Team 20-Question" )
        ) output.sk_type = "2-Team Overtime";
    }

    else if ( input.form == "foul" ) {
        output.label = "F";

        var quizzer_fouls = 0;
        var team_fouls    = 0;

        if ( input.quizzer.events )
            quizzer_fouls = Object.values( input.quizzer.events ).filter( function (value) {
                return value.toString().indexOf("F") != -1;
            } ).length;

        for ( var i = 0; i < input.quizzers.length; i++ ) {
            if ( input.quizzers[i].events ) {
                team_fouls += Object.values( input.quizzers[i].events ).filter( function (value) {
                    return value.toString().indexOf("F") != -1;
                } ).length;
            }
        }

        if ( quizzer_fouls >= 2 ) {
            output.quizzer = -10;
            output.team    = -10;
            output.label   += "--";
        }
        else if ( team_fouls >= 3 ) {
            output.team  = -10;
            output.label += "-";
        }
    }

    else if ( input.form == "timeout" ) {
        output.team_label = "T";
    }

    else if ( input.form == "sub-in" ) {
        output.label = "S+";
    }

    else if ( input.form == "sub-out" ) {
        output.label = "S-";
    }

    else if ( input.form == "challenge" ) {
        output.team_label = "C";

        if ( input.result == "failure" ) {
            var overruled_challenges = [];
            if ( input.team.events )
                overruled_challenges = Object.values( input.team.events ).filter( function (value) {
                    return value.toString().indexOf("C~") != -1 || value.toString().indexOf("C-") != -1;
                } );
            if ( overruled_challenges.length >= 1 ) {
                output.team_label += "-";
                output.team       = -10;
            }
            else {
                output.team_label += "~";
            }
        }
        else {
            output.team_label += "^";
        }
    }

    else if ( input.form == "readiness" ) {
        output.team_label = "R-";
        output.team       = -20;
    }

    else if ( input.form == "unsportsmanlike" ) {
        output.team_label = "U-";
        output.team       = -10;
    }
