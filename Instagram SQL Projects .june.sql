-- 📊 Instagram Analytics & Data Cleaning SQL Project

-- 📌 Project Overview

-- -- This project demonstrates real-world SQL Data Cleaning, Data Analysis, and Business 
-- Insights using an Instagram-style database. It is designed to strengthen SQL skills commonly 
-- required for Data Analyst, Business Analyst, and Power BI Developer roles.

-- -- The project covers everything from cleaning messy data to generating analytical 
-- reports using advanced SQL concepts such as JOINs, Aggregate Functions, Window Functions,
-- CTEs, Views, CASE Statements, and Subqueries.
-------------------------------------------------------------------------------------------
-- 🎯 Project Objective

-- The main objective of this project is to:

-- Clean messy Instagram data
-- Detect duplicate records
-- Handle NULL and blank values
-- Standardize inconsistent data
-- Perform business analysis using SQL
-- Practice interview-level SQL queries
-- Build an end-to-end SQL portfolio project
----------------------------------------------------------------------------
CREATE TABLE instagram_users (
    user_id INT,
    username VARCHAR(50),
    full_name VARCHAR(100),
    city VARCHAR(50),
    join_date VARCHAR(20)
);

INSERT INTO instagram_users VALUES
(1,'NEHA_92','Neha Baraskar','Indore','2025-01-15'),
(2,'neha_92','neha baraskar','indore','2025-01-15'),
(3,'Rahul_23','Rahul Sharma','Delhi','2025-02-10'),
(4,'  Priya_89  ','Priya Patel','Mumbai','2025-03-01'),
(5,NULL,'Aman Gupta','Pune','2025-04-01'),
(6,'Kavya_12','','Jaipur','2025-04-15'),
(7,'Sameer_77','Sameer Khan','Delhi','invalid-date'),
(8,'POOJA_56','Pooja Jain','Mumbai','2025-05-01'),
(9,'Rohan_90','Rohan Das','Kolkata',NULL),
(10,'NEHA_92','Neha Baraskar','Indore','2025-01-15');

---------------------------------------------------------------
CREATE TABLE posts (
    post_id INT,
    user_id INT,
    post_type VARCHAR(20),
    likes_count INT,
    post_date VARCHAR(20)
);

INSERT INTO posts VALUES
(101,1,'Reel',100,'2025-06-01'),
(102,1,'Post',200,'2025-06-02'),
(103,2,'Reel',5000,'2025-06-03'),
(104,3,'Story',50,'2025-06-04'),
(105,4,'Post',NULL,'2025-06-05'),
(106,5,'Reel',75,'2025-06-06'),
(107,6,'Story',90,'2025-06-07'),
(108,7,'Post',120,'wrong-date'),
(109,8,'Reel',150,'2025-06-09'),
(110,1,'Reel',100,'2025-06-01');

--------------------------------------------------------

CREATE TABLE followers (
    follow_id INT,
    follower_id INT,
    following_id INT
);

INSERT INTO followers VALUES
(1,1,2),
(2,1,2),
(3,2,3),
(4,3,4),
(5,4,5),
(6,5,6),
(7,6,7),
(8,7,8),
(9,8,9),
(10,9,10);

--------------------------------------------------------

CREATE TABLE comments (
    comment_id INT,
    post_id INT,
    comment_text VARCHAR(100)
);

INSERT INTO comments VALUES
(1,101,'Nice Post'),
(2,102,'great post'),
(3,103,'GREAT POST'),
(4,104,NULL),
(5,105,'Awesome'),
(6,106,''),
(7,107,'Excellent'),
(8,108,'nice post'),
(9,109,'Good'),
(10,110,'Nice Post');

------------------------------------------------------------
CREATE TABLE hashtags (
    hashtag_id INT,
    post_id INT,
    hashtag_name VARCHAR(50)
);

INSERT INTO hashtags VALUES
(1,101,'#DataScience'),
(2,102,'#datascience'),
(3,103,'#SQL'),
(4,104,'#sql'),
(5,105,NULL),
(6,106,' #PowerBI'),
(7,107,'#Excel '),
(8,108,'#Python'),
(9,109,'#PYTHON'),
(10,110,'#DataScience');
------------------------------------------------------------


---===========================================================


-- # Data Cleaning Questions

-- ### 1. Duplicate Usernames
select  username  from instagram_users 
group by username 
having count(*)  > 1 ; 
--------------------------------------------------------

-- Find all usernames that appear more than once in `instagram_users`.
select username , count(username) as more_2times from instagram_users 
group by username 
having count(*)> 1 
----------------------------------------------------------
-- Find follower-following pairs that are duplicated in `followers`.

SELECT follower_id,
       following_id,
       COUNT(*) AS duplicate_count
FROM followers
GROUP BY follower_id, following_id
HAVING COUNT(*) > 1;
-------------------------------------------------------
-- ### 3. Duplicate Hashtags

select lower(trim(hashtag_name)) , count(*) as duplicates_count 
from hashtags
where hashtag_name IS NOT NULL
group by lower(trim(hashtag_name))
having count(* )> 1; 
--------------------------------------------------------
-- Find hashtags that appear more than once after converting them to lowercase.

select lower(trim(hashtag_name )), count(*) from hashtags
where hashtag_name is not null 
group by lower(trim(hashtag_name ))
having count(*) > 1 ; 
-------------------------------------------------------------------
-- Find all records where `username` is NULL.

select  user_id , username from instagram_users
where  username is null 
---------------------------------------------------------------------
-- ### 5. Blank Values ('')

select * from comments 
where comment_text = ''; 
-------------------------------------------------------------
-- Find users whose `full_name` is blank.

select *   from instagram_users
where full_name = ''; 
-----------------------------------------------------------
-- Find usernames having leading spaces.

SELECT *
FROM instagram_users
WHERE username <> LTRIM(username);

---------------------------------------------------------
-- Find usernames having leading spaces.

select username  from  instagram_users
where username  <> LTRIM( username ) ; 
-----------------------------------------------------------
-- Find usernames having trailing spaces.
select username from  instagram_users
where username <> RTRIM(username) 
-----------------------------------------------------------------
-- Find usernames that are not stored in lowercase.

select username from instagram_users
where username <> lower(username ) ; 
------------------------------------------------=--
-- Find records where `join_date` is not a valid date.
SELECT *
FROM instagram_users
WHERE join_date = 'invalid-date'
   OR join_date IS NULL;

   -------------------------------------------------
   -- Find records where `join_date` is not a valid date.
SELECT *
FROM instagram_users
WHERE join_date = 'invalid-date';

--------------------------------------------------------
-- Find posts where likes are unusually high (>1000).
SELECT *
FROM posts
WHERE likes_count > 1000;
-------------------------------------------------------

-- Find posts where likes are unusually high (>1000).
select * from posts 
where likes_count > 1000
--------------------------------------------------------------

-- Display all users from Mumbai.

select *  from instagram_users  
where city = trim(' Mumbai ')  ;
----------------------------------------------------
-- Build a final Instagram Analytics Report using all 5 tables.
select * from  instagram_users as i
inner join posts  as p
on p.user_id = i.user_id 
inner join hashtags as h
on p.post_id = h.post_id 
inner join  comments as c
on c.post_id = h.post_id 
---------------------------------------------
-- Show posts having likes greater than 100.
select likes_count from posts 
where likes_count > 100 

---------------------------------------------------
-- Display users sorted by username.
select username from instagram_users
order by username asc 
---------------------------------------------------

-- Show all unique cities.
select distinct(city)   from instagram_users

----------------------------------------------------
-- Find total likes across all posts.
SELECT SUM(likes_count) AS total_likes
FROM posts;

--------------------------------------------------
-- Show all unique cities.
select distinct ( city) from instagram_users 

----------------------------------------------------

-- Find total likes across all posts.
select sum(likes_count) from posts 
------------------------------------------------------------
-- Count users in each city.

select  city , count(*) as count_username  from instagram_users
group by city ; 
-----------------------------------------------------------
-- Show cities having more than 1 user.
select  city , count(*) as user_name   from  instagram_users
group by city 
having count(*)  > 1 ; 
---------------------------------------------------------------
-- Display username and their post type.

select i.username , p.post_type  from posts as p
inner join  instagram_users as i
on p.user_id =i.user_id

----------------------------------------------------------------------
-- Find users who never created a post.
select i. username from instagram_users as i 
left join posts as p
on p.user_id =i.user_id
WHERE p.user_id IS NULL;
---------------------------------------------------------------
-- Categorize posts:

-- * High Engagement (>200)
-- * Medium (100-200)
-- * Low (<100)

	   SELECT
    post_id,
    likes_count,
    CASE
        WHEN likes_count > 200 THEN 'High Engagement'
        WHEN likes_count BETWEEN 100 AND 200 THEN 'Medium'
        WHEN likes_count < 100 THEN 'Low'
    END AS engagement_category
FROM posts;
----------------------------------------------------

-- Find posts having likes greater than average likes.
SELECT *
FROM posts
WHERE likes_count > (
    SELECT AVG(likes_count)
    FROM posts
);
-------------------------------------------
-- Display all usernames and hashtag names in a single column.

select username from instagram_users
union all 
select hashtag_name  from hashtags ;
------------------------------------------------------------
-- Create a CTE to calculate total likes per user.

with cte as ( 
select i.username , sum(p.likes_count) as total_like  from posts as p
inner join instagram_users as i
on p.user_id = i.user_id 
group by i.username)

(select username , total_like from cte )  ; 
---------------------------------------------------
-- Extract year from valid `join_date`.

ALTER TABLE instagram_users
ALTER COLUMN join_date TYPE DATE
USING join_date::DATE;

select join_date , extract ( year from join_date ) as year_new 
from instagram_users 
-------------------------------------------
-- Convert all usernames to lowercase.

SELECT lower(USERNAME)  FROM instagram_users 

------------------------------------------------------
-- Remove leading and trailing spaces from usernames.

select trim(username ) as new_user from instagram_users 
----------------------------------------------------------------

-- Find top 3 users based on total likes.

select i. username ,  sum( p.likes_count) as totals_l from instagram_users as i 
inner join posts as p
on p.user_id = i.user_id 
group by  i. username , p.likes_count 
order by totals_l desc 
limit  3 ; 
---------------------------------------------------

-- Assign row numbers to posts based on likes.

select   likes_count , row_number () over ( order by likes_count ) as totao_likes 
from posts 
------------------------------------------------------------------
-- Rank users by total likes.

SELECT
    user_id,
    SUM(likes_count) AS total_likes,
    RANK() OVER (ORDER BY SUM(likes_count) DESC) AS user_rank
FROM posts
GROUP BY user_id;
---------------------------------------------------------

-- Dense rank users by total likes.

select user_id , sum(likes_count ) as total_likes ,dense_rank() OVER (ORDER BY SUM(likes_count) DESC) AS user_rank
FROM posts
GROUP BY user_id;

-------------------------------------------------------------------

-- Calculate running total of likes ordered by post_id.
SELECT
    post_id,
    likes_count,
    SUM(likes_count) OVER (
        ORDER BY post_id
    ) AS running_total_likes
FROM posts;

---------------------------------------------------------
-- Find most liked post of each user.
SELECT
    i.user_id,
    i.username,
    MAX(p.likes_count) AS most_liked_post
FROM instagram_users i
INNER JOIN posts p
    ON i.user_id = p.user_id
GROUP BY i.user_id, i.username;
---------------------------------------------------
-- Standardize all city names to Proper Case.
select  INITCAP(trim(city))  as new_city  from instagram_users 
------------------------------------------------------------
-- Identify usernames that would violate a UNIQUE constraint.
SELECT
    username,
    COUNT(*) AS duplicate_count
FROM instagram_users
GROUP BY username
HAVING COUNT(*) > 1;
--------------------

-- Create a view showing username, city and total likes.

CREATE VIEW user_likes_view AS
SELECT
    i.username,
    i.city,
    SUM(p.likes_count) AS total_likes
FROM instagram_users i
INNER JOIN posts p
    ON i.user_id = p.user_id
GROUP BY i.username, i.city;

SELECT *
FROM user_likes_view;
---------------------------------------------------------
-- Which city generated the highest total likes?
SELECT
    i.city,
    SUM(p.likes_count) AS total_likes
FROM instagram_users AS i
INNER JOIN posts AS p
ON i.user_id = p.user_id
GROUP BY i.city
ORDER BY total_likes DESC
LIMIT 1;
------------------------------------------------------

-- Which user has the highest engagement?
select i.username , sum( p.likes_count) as total_likes from instagram_users as i
inner join  posts as p
 ON i.user_id = p.user_id
GROUP BY i.username 
order by  total_likes desc limit 2 ; 
--------------------------------------------------
-- Find duplicate usernames ignoring case and spaces.
SELECT
    LOWER(TRIM(username)) AS username,
    COUNT(*) AS total_count
FROM instagram_users
GROUP BY LOWER(TRIM(username))
HAVING COUNT(*) > 1;
-------------------------------------------
-------------------------------------------------
select * from hashtags -- hastag_id , post_id 
select * from comments  -- comments_id , post_id , 
select * from  followers -- follow_id , follower_id , following_id 
select * from instagram_users --- user_id , 
select * from posts -- post_id , user_id , 
---------------------------------------------------------------


-- Create a clean version of `instagram_users` with duplicates removed.

select username , count(*) from  instagram_users 
group by username 
having count(* )>1 
----------------------------------------------------------------



-----------------------------------------------

-- Find top influencer based on total likes and followers.
select i. username , sum(p. likes_count) as total from posts as p
inner join instagram_users  as i
on p.user_id = i.user_id 
group by i. username
order by total desc 
limit 1 ; 
--------------------------------------------------------------

-- Find users whose join_date is NULL or invalid.

select username , join_date from instagram_users 
where join_Date is null ;
-----------------------------------------------------------
-- Find the second highest liked post using a window function.
with cte as ( 
select post_type , likes_count , row_number() over(order by likes_count desc ) as new_w from posts ) 


select post_type , likes_count from cte 
where new_w = 2  ;

---------------
-- Detect invalid hashtags having leading/trailing spaces.
SELECT
    hashtag_name
FROM hashtags
WHERE hashtag_name <> TRIM(hashtag_name);




-- Replace NULL likes with 0 and calculate average likes.

select avg(likes_count ) as total from  posts 


update posts 
set  likes_count = 0
where likes_count is null 
---------------------------------------------

-------------------------------------------------------------
-- Which hashtag is used most frequently?

select h.hashtag_name , count(*)  as total_count from  posts as p
inner join hashtags  as h
on h.post_id = p.post_Id 
group by h.hashtag_name 
ORDER BY total_count DESC
LIMIT 1;

-- Find users with zero posts.

select i.user_id , i.username  from instagram_users as i
left join posts as p
on p.user_id =i.user_id 
where  p.post_id is null ;


-- Find users with zero followers.

SELECT
    i.user_id,
    i.username
FROM instagram_users AS i
LEFT JOIN followers AS f
ON i.user_id = f.following_id
WHERE f.following_id IS NULL;

------------------------END---------------------------------------------








