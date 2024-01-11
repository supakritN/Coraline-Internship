-- 1. Top-rated Director for Each Movie Genre:
SELECT 
    g.gen_title AS movie_genre, 
    d.dir_fname, 
    d.dir_lname, 
    MAX(r.rev_stars) AS max_rating
FROM 
    director d
JOIN 
    movie_direction md ON md.dir_id = d.dir_id
JOIN 
    movie m ON m.mov_id = md.mov_id
JOIN 
    rating r ON r.mov_id = m.mov_id
JOIN 
    movie_genres mg ON mg.mov_id = m.mov_id
JOIN 
    genres g ON g.gen_id = mg.gen_id
GROUP BY 
    g.gen_title, d.dir_id
ORDER BY 
    max_rating DESC;
-- 2. Actors' Total Screen Time in Non-null Rated Movies:
SELECT 
    a.act_fname, 
    a.act_lname, 
    m.mov_title,
    SUM(m.mov_time) AS total_duration
FROM 
    actor a
JOIN 
    movie_cast mc ON mc.act_id = a.act_id
JOIN 
    movie m ON m.mov_id = mc.mov_id
JOIN 
    rating r ON r.mov_id = m.mov_id
WHERE 
    r.rev_stars IS NOT NULL
GROUP BY 
    a.act_id, m.mov_id;
-- 3. Top 5 Collaborations between Directors and Female Actors:
SELECT 
    d.dir_fname, 
    d.dir_lname, 
    a.act_fname, 
    a.act_lname, 
    COUNT(*) AS times_collaborated
FROM 
    movie_cast mc
JOIN 
    actor a ON mc.act_id = a.act_id AND a.act_gender = 'F'
JOIN 
    movie_direction md ON md.mov_id = mc.mov_id
JOIN 
    director d ON d.dir_id = md.dir_id
GROUP BY 
    d.dir_id, a.act_id
ORDER BY 
    times_collaborated DESC
LIMIT 5;
-- 4. Changing Genre Title Data Type and Assigning Integer Values:
ALTER TABLE genres ADD COLUMN gen_title_int INTEGER;

SET @row_number := 0;
UPDATE genres 
SET gen_title_int = (@row_number:=@row_number + 1)
ORDER BY gen_title;

-- If you need to drop the original gen_title column and rename gen_title_int to gen_title
ALTER TABLE genres DROP COLUMN gen_title;
ALTER TABLE genres CHANGE COLUMN gen_title_int gen_title INTEGER;

-- 5. Updating Actor Gender Based on Name Patterns:
UPDATE actor
SET act_gender = 'F'
WHERE 
    LOWER(act_fname) LIKE 'em%' OR 
    LOWER(act_fname) LIKE 'char%' OR 
    LOWER(act_lname) LIKE '%dy' OR 
    LOWER(act_lname) LIKE '%sy' OR 
    LOWER(act_lname) LIKE '%lia';

