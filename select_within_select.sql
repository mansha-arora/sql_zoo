-- 1. Name for countries with population larger than that of Russia

SELECT name
FROM world
WHERE population >
  (SELECT population
   FROM world
   WHERE name = 'Russia');

-- 2. Name for countries in Europe with per capita GDP greater than that of the
--    United Kingdom

SELECT name
FROM world
WHERE continent = 'Europe'
  AND gdp/population >
    (SELECT gdp/population
     FROM world
     WHERE name = 'United Kingdom');

-- 3. Name and continent for countries in the continents containing either
--    Argentina or Australia, ordered by name

SELECT name, continent
FROM world
WHERE continent =
  (SELECT continent
   FROM world
   WHERE name = 'Argentina')
  OR continent =
    (SELECT continent
     FROM world
     WHERE name = 'Australia')
ORDER BY name;

-- 4. Name and population for the countries with population greater than that
--    of Canada and less than that of Poland

SELECT name, population
FROM world
WHERE population >
  (SELECT population
   FROM world
   WHERE name = 'Canada')
  AND population <
    (SELECT population
     FROM world
     WHERE name = 'Poland');

-- 5. Name and population, as a percentage of the population of Germany, for
--    each country in Europe

SELECT name, CONCAT(ROUND(population /
  (SELECT population
   FROM world
   WHERE name = 'Germany') * 100, 0), '%')
FROM world
WHERE continent = 'Europe';

-- 6. Name for countries with GDP greater than that of every country in Europe

SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp
                FROM world
                WHERE continent = 'Europe'
                  AND gdp IS NOT NULL);

-- 7. Continent, name, and area for the largest (by area) country on each
--    continent

SELECT continent, name, area
FROM world a
WHERE area >= ALL(SELECT area
                  FROM world b
                  WHERE a.continent = b.continent
                    AND area IS NOT NULL);

-- 8. Continent and name for the country that comes first alphabetically in the
--    list of countries in that continent

SELECT continent, name
FROM world a
WHERE name <= ALL(SELECT name
                  FROM world b
                  WHERE a.continent = b.continent
                    AND name IS NOT NULL);

-- 9. Name, continent, and population for the countries on continents where all
--    countries have a population less than or equal to 25 million

SELECT name, continent, population
FROM world
WHERE continent IN (SELECT continent
                    FROM world a
                    WHERE 25000000 > ALL(SELECT population
                                         FROM world b
                                         WHERE a.continent = b.continent));

-- 10. Name and continent for countries with more than three times the 
--     population of any other country in the same continent

SELECT name, continent
FROM world a
WHERE population > ALL(SELECT population * 3
                       FROM world b
                       WHERE a.name != b.name
                         AND a.continent = b.continent);