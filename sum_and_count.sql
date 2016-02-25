-- 1. Total population of the world

SELECT SUM(population)
FROM world;

-- 2. List of all continents

SELECT DISTINCT continent
FROM world;

-- 3. Total GDP of Africa

SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

-- 4. The number of countries with an area of at least 1 million sq km

SELECT COUNT(*)
FROM world
WHERE area >= 1000000;

-- 5. Total population of France, Germany, and Spain

SELECT SUM(population)
FROM world
WHERE name IN ('France', 'Germany', 'Spain');

-- 6. Continent and number of countries for each continent

SELECT continent, COUNT(*)
FROM world
GROUP BY continent;

-- 7. Continent and number of countries with populations of at least 10 million
--    for each continent

SELECT continent, COUNT(*)
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8. List of continents with a total population of at least 100 million

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;