-- Leetcode 50 SQL QUESTIONS 

-- Table: Products
-- Write a solution to find the ids of products that are both low fat and recyclable.

select product_id from products 
where low_fats= "Y" AND recyclable="Y";

-- Table: Customer
-- Find the names of the customer that are not referred by the customer with id = 2.

select name from customer 
where referee_id IS NULL or referee_id<>2; 

-- Table: World
-- Write a solution to find the name, population, and area of the big countries.

select name, population , area from world
where population>=25000000 OR area>=3000000;

-- Table: Views
-- Write a solution to find all the authors that viewed at least one of their own articles.

select DISTINCT(a.author_id) as id
from views as a
JOIN views as b
ON a.author_id=b.viewer_id
AND a.article_id=b.article_id
order by a.author_id asc; 

-- Table: Tweets
-- Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.

select tweet_id from tweets 
where length(content)>15;

