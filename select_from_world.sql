-- 1. The results of a simple SQL command

SELECT name, continent, population
FROM world;

-- 2. Name for countries with populations of at least 200 million

SELECT name
FROM world
WHERE population >= 200000000;

-- 3. Name and per capita GDP for countries with populations of at least 200
--    million

SELECT name, gdp/population
FROM world
WHERE population >= 200000000;

-- 4. Name and population in millions for South American countries

SELECT name, population/1000000
FROM world
WHERE continent = 'South America';

-- 5. Name and population for France, Germany, and Italy

SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6. Countries which have a name that includes the word United

SELECT name
FROM world
WHERE name LIKE '%United%';

-- 7. Name, population, and area for countries with an area greater than 3
--    million sq km or a population greater than 250 million

SELECT name, population, area
FROM world
WHERE area > 3000000
  OR  population > 250000000;

-- 8. Name, population, and area for countries with an area greater than 3
--    million sq km or a population greater than 250 million, but not both

SELECT name, population, area
FROM world
WHERE (area > 3000000
  OR  population > 250000000)
  AND NOT (area > 3000000
           AND population > 250000000);

-- 9. Name, population in millions to 2 decimal places, and GDP in billions to
--    2 decimal places for South American countries

SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America';

-- 10. Name and per capita GDP rounded to the nearest 1000 for countries with a
--     GDP of at least 1 trillion

SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000;

-- 11. Name and continent for countries with names beginning with N,
--     substituting Australasia for Oceania

SELECT name,
  CASE
    WHEN continent = 'Oceania' THEN 'Australasia'
    ELSE continent
  END
FROM world
WHERE name LIKE 'N%';

-- 12. Name and continent for countries with names beginning with A or B,
--     substituting Eurasia for Europe or Asia, and America for North America,
--     South America, or Caribbean

SELECT name,
  CASE
    WHEN continent IN ('Europe', 'Asia') THEN 'Eurasia'
    WHEN continent 
         IN ('North America', 'South America', 'Caribbean') THEN 'America'
    ELSE continent
  END
FROM world
WHERE name LIKE 'A%' OR name LIKE 'B%';

-- 13. Name, original continent, and new continent for all countries,
--     substituting Australasia for Oceania, Europe/Asia for Eurasia, putting
--     Turkey in Europe/Asia, putting Caribbean islands starting with B in
--     North America, and other Caribbean islands in South America

SELECT name, continent,
  CASE
    WHEN continent = 'Oceania' THEN 'Australasia'
    WHEN continent = 'Eurasia' THEN 'Europe/Asia'
    WHEN name = 'Turkey' THEN 'Europe/Asia'
    WHEN continent = 'Caribbean' AND name LIKE 'B%' THEN 'North America'
    WHEN continent = 'Caribbean' AND name NOT LIKE 'B%' THEN 'South America'
    ELSE continent
  END
FROM world
ORDER BY name;