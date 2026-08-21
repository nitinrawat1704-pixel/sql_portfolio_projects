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

Q7.For each team playing on 2026-07-01, show the city and the teamname

-- select city,teamname from game g inner join team t
-- on t.id=g.team1 
-- OR t.id = g.team2
-- where played="2026-07-01";

Q8.For every goal scored on '2026-07-02' show the teamname, and the player who scored
-- select t.teamname,g.player
-- from team t inner join goal g on t.id=g.team
-- inner join game ga on g.game=ga.id 
-- where ga.played='2026-07-02';

Q9.For every goal scored in Mexico City show the date played, the player and that players position (pos)
-- select
-- game.played,goal.player,player.pos
-- from game inner join goal on game.id=goal.game
-- inner join  player on goal.player=player.playername
-- where game.city="Mexico City";

Q10.For each goal scored by a defender, show the player, their teamname.

-- select player.playername, team.teamname
-- from goal
-- inner join  player on goal.player = player.playername
-- join team
-- on player.team = team.id
-- where player.pos = 'DEF';


Q11.For each goal scored in extra time, show the player, their position, teamname and city
-- select
-- goal.player,player.pos,team.teamname,game.city
-- from
-- goal inner join player on goal.player=player.playername
-- inner join team on player.team=team.id
-- inner join game on goal.game=game.id
-- where goal.gtime between 91 and 120;

Q12.List the player and the teamname for every goal scored in 'Vancouver'

-- select goal.player,team.teamname
-- from team inner join goal on team.id=goal.team
-- inner join game on goal.game=game.id
-- where game.city="Vancouver";
