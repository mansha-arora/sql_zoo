-- 1. Id and title for 1962 films

SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2. Year for Citizen Kane

SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3. Id, title, and year for all Star Trek movies, ordered by year

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4. Title for films with ids 11768, 11955, and 21191

SELECT title
FROM movie
WHERE id IN (11768, 11955, 21191);

-- 5. Id for Glenn Close

SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 6. Id for Glenn Close

SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 7. Cast list for Casablanca

SELECT actor.name
FROM actor JOIN casting ON (actor.id = casting.actorid)
WHERE casting.movieid = 11768;

-- 8. Cast list for Alien

SELECT actor.name
FROM actor JOIN casting ON (actor.id = casting.actorid)
WHERE casting.movieid = (SELECT id
                         FROM movie
                         WHERE title = 'Alien');

-- 9. Title for films in which Harrison Ford has appeared

SELECT movie.title
FROM movie JOIN (SELECT casting.movieid
                 FROM actor JOIN casting ON (actor.id = casting.actorid)
                 WHERE actor.name = 'Harrison Ford') hf_castings
  ON (movie.id = hf_castings.movieid);

-- 10. Title for films in which Harrison Ford has appeared, but not in a
--     starring role

SELECT movie.title
FROM movie JOIN (SELECT casting.movieid
                 FROM actor JOIN casting ON (actor.id = casting.actorid)
                 WHERE actor.name = 'Harrison Ford'
                   AND casting.ord != 1) hf_castings
  ON (movie.id = hf_castings.movieid);

-- 11. Title and leading actor name for 1962 films

SELECT movie.title, leading_actors.name
FROM movie JOIN (SELECT actor.name, casting.movieid
                 FROM actor JOIN casting ON (actor.id = casting.actorid)
                 WHERE casting.ord = 1) leading_actors
  ON (movie.id = leading_actors.movieid)
WHERE yr = 1962;

-- 12. Year and number of movies made by John Travolta each year, for years
--     when he made more than 2 movies

SELECT movie.yr, COUNT(*) AS movies_that_year
FROM movie JOIN (SELECT casting.movieid
                  FROM actor JOIN casting ON (actor.id = casting.actorid)
                  WHERE actor.name = 'John Travolta') jt_castings
  ON (movie.id = jt_castings.movieid)
GROUP BY movie.yr
HAVING movies_that_year > 2;

-- 13. Title and leading actor for films in which Julie Andrews has appeared

SELECT movie.title, leading_actors.name
FROM movie JOIN (SELECT actor.name, casting.movieid
                 FROM actor JOIN casting ON (actor.id = casting.actorid)
                 WHERE casting.ord = 1) leading_actors
  ON (movie.id = leading_actors.movieid)
WHERE movie.id IN (SELECT casting.movieid
                   FROM actor JOIN casting ON (actor.id = casting.actorid)
                   WHERE actor.name = 'Julie Andrews');

-- 14. Name for actors who have had at least 30 starring roles, in alphabetical
--     order

SELECT a.name
FROM actor a JOIN (SELECT b.id, b.name, casting.movieid
                   FROM actor b JOIN casting ON (b.id = casting.actorid)
                   WHERE casting.ord = 1) leading_actors
  ON (a.id = leading_actors.id)
GROUP BY a.id
HAVING COUNT(*) >= 30
ORDER BY a.name;

-- 15. Title for 1978 films, ordered by number of actors, descending

SELECT movie.title, cast_counts.cast_count
FROM movie JOIN (SELECT casting.movieid, COUNT(*) AS cast_count
                 FROM actor JOIN casting ON (actor.id = casting.actorid)
                 GROUP BY casting.movieid) cast_counts
  ON (movie.id = cast_counts.movieid)
WHERE yr = 1978
ORDER BY cast_counts.cast_count DESC;

-- 16. Name for actors who have worked with Art Garfunkel

SELECT a1.name
FROM actor a1 JOIN casting c1 ON (a1.id = c1.actorid)
WHERE c1.movieid IN (SELECT c2.movieid
                     FROM actor a2 JOIN casting c2 
                       ON (a2.id = c2.actorid)
                     WHERE a2.name = 'Art Garfunkel')
  AND a1.name != 'Art Garfunkel';