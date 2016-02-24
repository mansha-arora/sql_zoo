-- 1. Year, subject, and winner for Nobel prizes for 1950

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- 2. Winner for 1962 Nobel prize for Literature

SELECT winner
FROM nobel
WHERE yr = 1962 AND subject = 'Literature';

-- 3. Year and subject that won the Nobel prize for Albert Einstein

SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4. Name for Peace prize winners since 2000, inclusive

SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000;

-- 5. Year, subject, and winner for Literature prize winners from 1980 to 1989,
--    inclusive

SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989;

-- 6. Year, subject, and winner for the presidential winners Theodore
--    Roosevelt, Woodrow Wilson, and Jimmy Carter

SELECT yr, subject, winner
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter');

-- 7. Winners with the first name John

SELECT winner
FROM nobel
WHERE winner LIKE 'John %';

-- 8. Year, subject, and winner for Physics in 1980 or Chemistry in 1984

SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Physics' AND yr = 1980)
  OR (subject = 'Chemistry' AND yr = 1984);

-- 9. Year, subject, and winner for 1980 excluding Chemistry and Medicine

SELECT winner
FROM nobel
WHERE yr = 1980
  AND (subject NOT IN ('Chemistry', 'Medicine'));

-- 10. Year, subject, and winner for Medicine before 1910 or for Literature in
--     2004 or later

SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910)
  OR (subject = 'Literature' AND yr >= 2004);

-- 11. Year, subject, and winner for the prize won by Peter Grünberg

SELECT yr, subject, winner
FROM nobel
WHERE winner = 'Peter Grünberg';

-- 12. Year, subject, and winner for the prize won by Eugene O'Neill

SELECT yr, subject, winner
FROM nobel
WHERE winner = 'Eugene O''Neill';

-- 13. Winner, year, and subject for knights, ordered by year, descending, then
--     by name, ascending

SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%' OR winner LIKE 'Dame%'
ORDER BY yr DESC, winner;

-- 14. Winners and subject for 1984, ordered with Chemistry and Physics last,
--     then by subject, then by winner

SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('Chemistry', 'Physics'), subject, winner;