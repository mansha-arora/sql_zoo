-- 1. Number of stops

SELECT COUNT(*)
FROM stops;

-- 2. Id for Craiglockhart stop

SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3. Id and name for stops on the 4 LRT service

SELECT stops.id, stops.name
FROM stops JOIN route ON (stops.id = route.stop)
WHERE route.num = 4
  AND route.company = 'LRT';

-- 4. Company, number, and number of relevant stops for routes that visit both
--    London Road (stop 149) and Craiglockhart (stop 53)

SELECT company, num, COUNT(*)
FROM route
WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING COUNT(*) = 2;

-- 5. Company, number, start point, and end point for routes from Craiglockhart
--    (stop 53) to London Road (stop 149)

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b
  ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53 AND b.stop = 149;

-- 6. Company, number, named start point, and named end point for routes from
--    Craiglockhart to London Road

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b
  ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'London Road';

-- 7. Company and number for routes from Haymarket to Leith

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b
  ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Haymarket' AND stopb.name = 'Leith';

-- 8. Company and number for routes from Craiglockhart to Tollcross

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b
  ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross';

-- 9. Stop name for stops that may be reached from Craiglockhart (including
--    itself), followed by the relevant company and number of that route

SELECT DISTINCT stopb.name, a.company, a.num
FROM route a JOIN route b
  ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart';

-- 10. First bus number and company, transfer stop name, and second bus number
--     and company for routes involving two buses that go from Craiglockhart to
--     Sighthill

--     Note: SQL Zoo marks this solution as incorrect
--     I believe it is correct except for some obscure ordering differences,
--     although this is difficult to verify

SELECT out_of_c.num, out_of_c.company, out_of_c.name,
       into_s.num, into_s.company
FROM (SELECT DISTINCT a.company, a.num, stopb.id, stopb.name
      FROM route a JOIN route b
        ON (a.company = b.company AND a.num = b.num)
        JOIN stops stopa ON (a.stop = stopa.id)
        JOIN stops stopb ON (b.stop = stopb.id)
      WHERE stopa.name = 'Craiglockhart') out_of_c
  JOIN
     (SELECT DISTINCT stopa.id, stopa.name, a.company, a.num
      FROM route a JOIN route b
        ON (a.company = b.company AND a.num = b.num)
        JOIN stops stopa ON (a.stop = stopa.id)
        JOIN stops stopb ON (b.stop = stopb.id)
      WHERE stopb.name = 'Sighthill') into_s
  ON (out_of_c.id = into_s.id)
WHERE out_of_c.num != into_s.num
  AND out_of_c.name != 'Sighthill'
  AND into_s.name != 'Craiglockhart';