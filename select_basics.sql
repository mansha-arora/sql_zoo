-- 1. Population of Germany

SELECT population
FROM world
WHERE name = 'Germany';

-- 2. Name and per capita GDP for each country with area > 5 million

SELECT name, gdp/population
FROM world
WHERE area > 5000000;

-- 3. Name and population for Ireland, Iceland, and Denmark

SELECT name, population
FROM world
WHERE name IN ('Ireland', 'Iceland', 'Denmark');

-- 4. Name and area for each country with an area between 200000 and 250000

SELECT name, area
FROM world
WHERE area BETWEEN 200000 AND 250000;