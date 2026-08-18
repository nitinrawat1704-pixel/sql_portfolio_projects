Q1.Modify it to show the game, team, player, gtime for all goals scored by player 'Leandro Trossard'
-- select game,team,player,gtime from goal where player="Leandro Trossard" ;

Q2 Show the id, teamname and coach for the team with code 'BEL'
-- select id,teamname,coach from team where id="BEL";

Q3. Show the player, gtime and teamname for every goal with goal time (gtime) less than 8 minutes.
-- select player,gtime,t.teamname 
-- from goal g inner join team t on g.team=t.id
-- where gtime<8;

Q4.Show the player, teamname and coach for every goal scored by a team with coach named 'Sébastien'
-- select g.player,t.teamname,t.coach from team t inner join goal g on  t.id=g.team where coach like "Sébastien%";

Q5. For each goal by 'Harry Edward Kane' show the player, the game id and the city
-- select goal.player,game.id,game.city 
-- from goal inner join game on goal.game=game.id 
-- where goal.player="Harry Edward Kane";

Q6. List the player and team (short code) for every goal scored in 'Vancouver'
-- select goal.player,goal.team 
-- from goal inner join game on goal.game=game.id
-- where game.city="Vancouver";
