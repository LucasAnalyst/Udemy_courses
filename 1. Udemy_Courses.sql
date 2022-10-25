SELECT *
FROM udemy_courses_clean;

/* 1. Find out which subjects are learned the most.*/
SELECT top(1) subject, sum(num_subscribers) as 'The most studied course'
FROM udemy_courses_clean
GROUP BY subject
ORDER BY 'The most studied course' desc;

/* 2. The course that brings in the most money.*/
SELECT top(1) course_title, sum(price*num_subscribers) as TotalPrice
FROM udemy_courses_clean
GROUP BY course_title
ORDER BY TotalPrice desc;

/* 3. Find out the prices of the 10 courses with the highest number of reviews.*/
SELECT udemy_courses_clean.course_title,
       udemy_courses_clean.price,
	   TOPRATE.Total_num_reviews
FROM udemy_courses_clean RIGHT JOIN 
      (SELECT top(10) U.course_title, 
	          sum(U.num_reviews) AS Total_num_reviews
       FROM udemy_courses_clean U
       GROUP BY U.course_title
       ORDER BY Total_num_reviews desc) AS TOPRATE ON udemy_courses_clean.course_title = TOPRATE.course_title
ORDER BY TOPRATE.Total_num_reviews desc;

/* 4. Find out the number of subcribe 10 courses with the lowest reviews.*/
SELECT TOP(10) course_title, 
       SUM(num_subscribers) AS Total_Subscribers,
       SUM(num_reviews) AS Total_num_reviews   
FROM udemy_courses_clean 
GROUP BY course_title
ORDER BY Total_num_reviews;

/* 5. Top 5 highest-grossing courses of the 10 most subcribe courses.*/
SELECT top(5) Top_subcribe.course_title, 
Top_subcribe.Total_price, Top_subcribe.Total_num_subscribers 
FROM (SELECT top(10) U.course_title, SUM(U.num_subscribers) AS Total_num_subscribers, SUM(U.price*U.num_subscribers) AS Total_price
         FROM udemy_courses_clean U
         GROUP BY U.course_title
         ORDER BY Total_num_subscribers DESC) AS Top_subcribe
ORDER BY Top_subcribe.Total_price DESC,Top_subcribe.Total_num_subscribers DESC; 

