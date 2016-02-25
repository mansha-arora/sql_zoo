- 1. Matchid and player for every German goal

SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- 2. Id, stadium, team1, and team2 for game 1012

SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- 3. Player, teamid, stadium, and mdate for every German goal

SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE goal.teamid = 'GER';

-- 4. Team1, team2, and player for every goal scored by a player called Mario

SELECT game.team1, game.team2, goal.player
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE goal.player LIKE 'Mario %';

-- 5. Player, teamid, coach, and gtime for all goals scored in the first 10
--    minutes (gtime <= 10)

SELECT goal.player, goal.teamid, eteam.coach, goal.gtime
FROM eteam JOIN goal ON (eteam.id = goal.teamid)
WHERE goal.gtime <= 10;

-- 6. Mdate and team1 for games where Fernando Santos was the team1 coach

SELECT game.mdate, eteam.teamname
FROM eteam JOIN game ON (eteam.id = game.team1)
WHERE eteam.coach = 'Fernando Santos';

-- 7. Player for every goal scored in a game where the stadium was National
--    Stadium, Warsaw

SELECT player
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE game.stadium = 'National Stadium, Warsaw';

-- 8. List of all players who scored a goal against Germany

SELECT DISTINCT goal.player
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE (game.team1 = 'GER' OR game.team2 = 'GER')
  AND goal.teamid != 'GER';

-- 9. Teamname and number of goals scored for each team

SELECT eteam.teamname, COUNT(*)
FROM eteam JOIN goal ON (eteam.id = goal.teamid)
GROUP BY eteam.id
ORDER BY eteam.teamname;

-- 10. Stadium and number of goals scored for each stadium

SELECT game.stadium, COUNT(*)
FROM game JOIN goal ON (game.id = goal.matchid)
GROUP BY game.stadium
ORDER BY game.stadium;

-- 11. Matchid, mdate, and number of goals scored for every match involving
--     Poland

SELECT goal.matchid, game.mdate, COUNT(*)
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE game.team1 = 'POL' OR game.team2 = 'POL'
GROUP BY goal.matchid;

-- 12. Matchid, mdate, and number of goals scored by Germany for every match
--     where Germany scored

SELECT goal.matchid, game.mdate, COUNT(*)
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE goal.teamid = 'GER'
GROUP BY goal.matchid;

-- 13. Mdate, matchid, team1, score1 (total goals by team1 that game), team2,
-- and score2 (total goals by team2 that game), for each game, sorted by mdate,
-- matchid, team1, and team2

SELECT game.mdate, game.team1,
       SUM(CASE
             WHEN goal.teamid = game.team1 THEN 1
             ELSE 0
           END) score1, game.team2,
       SUM(CASE
             WHEN goal.teamid = game.team2 THEN 1
             ELSE 0
           END) score2
FROM game LEFT OUTER JOIN goal ON (game.id = goal.matchid)
GROUP BY game.id
ORDER BY game.mdate, goal.matchid, game.team1, game.team2;