create schema TravelOnTheGo;
use TravelOnTheGo;

DROP TABLE IF EXISTS PRICE;
CREATE TABLE PRICE (

    Bus_Type VARCHAR(100),
    Distance INT,
    Price INT

);
DROP TABLE IF EXISTS PASSENGER;
CREATE TABLE PASSENGER (

    Passenger_name VARCHAR(100),
    Category VARCHAR(100),
    Gender VARCHAR(10),
    Boarding_City VARCHAR(100),
    Destination_City VARCHAR(100),
    Distance INT ,
    Bus_Type VARCHAR(100)


);


insert into Passenger values ('Sejal','AC',' F',' Bengaluru','Chennai', 350,'Sleeper');
insert into Passenger values ('Anmol ','Non-AC ','M ','Mumbai ','Hyderabad ',700 ,'Sitting');
insert into Passenger values ('Pallavi ','AC ','F',' Panaji ','Bengaluru ',600 ,'Sleeper');
insert into Passenger values ('Khusboo ','AC ','F ','Chennai ','Mumbai ',1500, 'Sleeper');
insert into Passenger values ('Udit ','Non-AC ','M ','Trivandrum ','panaji ',1000 ,'Sleeper');
insert into Passenger values ('Ankur ','AC',' M',' Nagpur ','Hyderabad ',500,' Sitting');
insert into Passenger values ('Hemant ','Non-AC',' M', 'panaji ','Mumbai ',700,' Sleeper');
insert into Passenger values ('Manish ','Non-AC ','M ','Hyderabad ','Bengaluru ',500 ,'Sitting');
insert into Passenger values ('Piyush ','AC ','M ','Pune ','Nagpur ',700,' Sitting');


insert into Price values ('Sleeper' ,350,770);
insert into Price values ('Sleeper ',500 ,1100);
insert into Price values ('Sleeper' ,600 ,1320);
insert into Price values ('Sleeper ',700 ,1540);
insert into Price values ('Sleeper ',1000 ,2200);
insert into Price values ('Sleeper ',1200 ,2640);
insert into Price values ('Sleeper ',1500 ,2700);
insert into Price values ('Sitting ',500 ,620);
insert into Price values ('Sitting ',600 ,744);
insert into Price values ('Sitting ',700 ,868);
insert into Price values ('Sitting ',1000 ,1240);
insert into Price values ('Sitting ',1200 ,1488);
insert into Price values ('Sitting ',1500 ,1860);

# 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?

SELECT Gender, COUNT(Gender) as "Total"
FROM
    passenger
WHERE
    Distance >= 600 group by Gender;

SELECT COUNT(CASE WHEN (Gender) like  '%m%' THEN 1 END) Male,
       COUNT(CASE WHEN (Gender) like  '%f%' THEN 1 END) Female
FROM passenger WHERE Distance >=600;


# 4)  Find the minimum ticket price for Sleeper Bus
SELECT
    MIN(price) TicketPrice
FROM
    price
WHERE
    BUS_TYPE = 'Sleeper';

# 5) Select passenger names whose names start with character 'S'
SELECT
    Passenger_name
FROM
    PASSENGER
WHERE
    PASSENGER_NAME LIKE 'S%';


# 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
# 		Destination City, Bus_Type, Price in the output

SELECT
    Passenger_name,
    P.Boarding_City,
    P.Destination_city,
    P.Bus_Type,
    PR.Price
FROM
    passenger P,
    price PR
WHERE
    P.Distance = PR.Distance
        AND P.Bus_type = PR.Bus_type;

# 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
#		for a distance of 1000 KM s

SELECT
    P.Passenger_Name, PR.Price
FROM
    Passenger P,
    Price PR
WHERE
    P.distance = 1000 AND P.BUS_TYPE = 'SITTING';


# 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
   SELECT DISTINCT
    P.PASSENGER_NAME,
    P.Boarding_city AS Destination_city,
    P.DESTINATION_CITY AS BOARDING_CITY,
    P.Bus_Type,
    PR.PRICE
FROM
    PASSENGER P,
    PRICE PR
WHERE
    PASSENGER_NAME = 'PALLAVI'
        AND P.DISTANCE = PR.DISTANCE;


# 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.

SELECT DISTINCT
    DISTANCE
FROM
    PASSENGER
ORDER BY DISTANCE DESC;

# 10) Display the passenger name and percentage of distance travelled by that passenger
#		from the total distance travelled by all passengers without using user variables

SELECT
    Passenger_name,
    Distance * 100.0 / (SELECT
            SUM(Distance) AS Percentage_of_Distance
        FROM
            passenger)
FROM
    passenger
GROUP BY Distance;


# 11) Display the distance, price in three categories in table Price
# 		a) Expensive if the cost is more than 1000
# 		b) Average Cost if the cost is less than 1000 and greater than 500
# 		c) Cheap otherwise


SELECT DISTINCT
    Price.Distance,
    Price,
    CASE
        WHEN Price > 1000 THEN 'EXPENSIVE'
        WHEN Price > 500 AND Price < 1000 THEN 'AVERAGE COST'
        ELSE 'CHEAP'
    END AS VERDICT
FROM
    Price
        INNER JOIN
    Passenger ON Price.Distance = Passenger.Distance;
