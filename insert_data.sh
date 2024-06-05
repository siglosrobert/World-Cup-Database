#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams;")

# insert into teams
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != winner ]]
  then
    # get winner
      WINNER_ID=$($PSQL "SELECT team_id from teams where name='$WINNER';")
      # if winner not in team table
      if [[ -z $WINNER_ID ]]
      # insert winner
      then
        INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
        # Echo insert
        if [[ $INSERT_WINNER_RESULT == 'INSERT 0 1' ]]
        then
          echo Inserted into team, $WINNER
        fi
      fi
    # get opponent
      OPPONENT_ID=$($PSQL "Select team_id from teams where name='$OPPONENT';")
    # if opponent not in team table
      if [[ -z  $OPPONENT_ID ]]
      # insert opponent
      then 
        INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
        # Echo insert
        if [[ $INSERT_OPPONENT_RESULT == 'INSERT 0 1' ]]
        then
          echo Inserted into team, $OPPONENT
        fi
      fi
  fi
done

#insert into games
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    #get winner ID
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    #get Opponent ID 
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    #insert games
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")
    #Echo insert
    if [[ $INSERT_GAME_RESULT == 'INSERT 0 1' ]]
    then
      echo Inserted into games, $WINNER vs $OPPONENT, Year: $YEAR ROUND: $ROUND
    fi
  fi
done
