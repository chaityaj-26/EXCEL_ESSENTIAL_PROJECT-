CREATE DATABASE Project;
USE Project;
SELECT* FROM global_travel;
DROP TABLE global_travel;
SELECT* FROM global_travel;
USE Project;
ALTER TABLE global_travel DROP COLUMN duration_nights;
ALTER TABLE global_travel DROP COLUMN restaurant_spend_per_day_usd;
ALTER TABLE global_travel DROP COLUMN language_barrier;
ALTER TABLE global_travel DROP COLUMN budget_per_person_usd;
ALTER TABLE global_travel DROP COLUMN repeat_visitor;
ALTER TABLE global_travel DROP COLUMN travel_insurance;
ALTER TABLE global_travel DROP COLUMN local_transport_used;
ALTER TABLE global_travel
MODIFY season VARCHAR(100),
MODIFY origin_country VARCHAR(100),
MODIFY destination_country VARCHAR(100),
MODIFY travel_purpose VARCHAR(100),
MODIFY traveler_type VARCHAR(100),
MODIFY transport_mode VARCHAR(100),
MODIFY visa_type VARCHAR(100),
MODIFY booking_channel VARCHAR(100),
MODIFY overall_satisfaction VARCHAR(100),
MODIFY safety_perception VARCHAR(100),
MODIFY would_recommend VARCHAR(100),
MODIFY accommodation_type VARCHAR(100);
SELECT* FROM global_travel;


#1.THE TOP 5 DESTINATIONS VISITED 
SELECT destination_country,
       COUNT(*) AS total_visits
FROM global_travel
GROUP BY destination_country
ORDER BY total_visits DESC
LIMIT 5;

#2.Shows the most popular travel routes to target specific markets
SELECT origin_country, destination_country,
       COUNT(*) AS total_trips
FROM global_travel
GROUP BY origin_country, destination_country
ORDER BY total_trips DESC
LIMIT 5;

#3.Helps determine peak season to maximize revenue and marketing efforts.SEASON 
SELECT season,
       COUNT(*) AS total_trips
FROM global_travel
GROUP BY season
ORDER BY total_trips DESC
LIMIT 2;

#4.Booking Behavior so we put Offers 45 Days Before
SELECT CASE 
 WHEN advance_booking_days <= 7 THEN 'Last Minute'
 WHEN advance_booking_days <= 45 THEN 'Within 45 Days'
 ELSE 'Early Booking'
END AS booking_type,
COUNT(*) AS total
FROM global_travel
GROUP BY booking_type;

#5.Top Source Country we get to know from which country we can target more 
SELECT origin_country,
       COUNT(*) AS total_travelers
FROM global_travel
GROUP BY origin_country
ORDER BY total_travelers DESC
LIMIT 3;

#6.Most Common Traveler Type
SELECT traveler_type,
       COUNT(*) AS total
FROM global_travel
GROUP BY traveler_type
ORDER BY total DESC
LIMIT 2;

#7.Safety Ranking 
SELECT destination_country,
DENSE_RANK() OVER (ORDER BY AVG(CASE 
                   WHEN safety_perception = 'Safe' THEN 5
                   WHEN safety_perception = 'Neutral' THEN 3
                   WHEN safety_perception = 'Unsafe' THEN 1
                         END) DESC) AS safety_rank
FROM global_travel
GROUP BY destination_country LIMIT 3;

#8.Highest Trip Rating
SELECT destination_country,
       AVG(trip_rating) AS avg_rating
FROM global_travel
GROUP BY destination_country
ORDER BY avg_rating DESC
LIMIT 5;

#9.Highest Spending Countries
SELECT destination_country,
       ROUND(AVG(total_trip_spend_usd),2) AS avg_spend
FROM global_travel
GROUP BY destination_country
ORDER BY avg_spend DESC
LIMIT 5;

#10.MOST PREFERRED BOOKING CHANNEL
SELECT booking_channel,
       COUNT(*) AS total_bookings
FROM global_travel
GROUP BY booking_channel
ORDER BY total_bookings DESC
LIMIT 1;



SELECT destination_country,
       AVG(
           CASE 
               WHEN safety_perception = 'Safe' THEN 5
               WHEN safety_perception = 'Neutral' THEN 3
               WHEN safety_perception = 'Unsafe' THEN 1
           END
       ) AS avg_safety_score,
       
       DENSE_RANK() OVER (
           ORDER BY AVG(
               CASE 
                   WHEN safety_perception = 'Safe' THEN 5
                   WHEN safety_perception = 'Neutral' THEN 3
                   WHEN safety_perception = 'Unsafe' THEN 1
               END
           ) DESC
       ) AS safety_rank
       
FROM global_travel
GROUP BY destination_country
LIMIT 3;
describe global_travel;
