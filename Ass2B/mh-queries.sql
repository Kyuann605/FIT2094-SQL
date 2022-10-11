--****PLEASE ENTER YOUR DETAILS BELOW****
--mh-queries.sql

--Student ID: 30881919
--Student Name: Goh Kai Yuan
--Tutorial No: 4

/* Comments for your marker:




*/


/*
    Q1
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT 
    ht_nbr,
    emp_nbr,
    emp_lname,
    emp_fname,
    to_char(end_last_annual_review, 'DY DD MON YYYY') AS REVIEW_DATE
FROM
    MH.endorsement          
    JOIN MH.helicopter_type using (ht_nbr)
    JOIN MH.employee using (emp_nbr)
WHERE 
    end_last_annual_review > to_date('31-3-2020', 'DD/MM/YYYY')
ORDER BY
    end_last_annual_review;

/*
    Q2
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT
    charter_nbr,
    client_nbr,
    client_lname,
    client_fname,
    charter_special_reqs
FROM
    MH.charter
    JOIN MH.client using (client_nbr)
WHERE
    charter_special_reqs IS NOT NULL
ORDER BY
    charter_nbr;

/*
    Q3
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT
    charter_nbr,
    TRIM(client_fname|| ' ' || client_lname) as FULLNAME,
    charter_cost_per_hour
FROM
    MH.charter
    JOIN MH.client using (client_nbr)
    JOIN MH.charter_leg using (charter_nbr)
    JOIN MH.location ON MH.location.location_nbr = MH.charter_leg.location_nbr_destination
WHERE 
    location_nbr_destination = (SELECT location_nbr FROM MH.location WHERE location_name = 'Mount Doom')
    AND
    (charter_cost_per_hour < 1000
    OR
    charter_special_reqs IS NULL)
ORDER BY
    fullname desc;

/*
    Q4
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT
    ht_nbr,
    ht_name,
    COUNT(ht_nbr) AS "TOTAL_NUMBER_HELICOPTER"
FROM 
    MH.helicopter_type
    JOIN MH.helicopter using (ht_nbr)
GROUP BY
    ht_nbr,
    ht_name
HAVING 
    count(ht_nbr) >= 2
ORDER BY
    "TOTAL_NUMBER_HELICOPTER" desc;

/*
    Q5
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT 
    location_nbr,
    location_name,
    COUNT(location_nbr_origin) AS LOCATION_NBR_ORIGIN_NUMBER
FROM
    MH.charter_leg
    JOIN MH.location ON MH.location.location_nbr = MH.charter_leg.location_nbr_origin
GROUP BY
    location_nbr,
    location_name
ORDER BY
    LOCATION_NBR_ORIGIN_NUMBER;

/*
    Q6
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT
    ht_nbr,
    ht_name,
    nvl(SUM(heli_hrs_flown),0) AS HOURS_FLOWN
FROM
    MH.HELICOPTER_TYPE 
    LEFT JOIN MH.HELICOPTER USING (ht_nbr)
GROUP BY
    ht_nbr,
    ht_name
ORDER BY
    HOURS_FLOWN;

/*
    Q7
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT
    charter_nbr,
    cl_atd
FROM 
    MH.charter 
    JOIN MH.charter_leg using (charter_nbr)
    JOIN MH.employee using (emp_nbr)
WHERE
    emp_nbr = (SELECT emp_nbr FROM MH.employee WHERE emp_fname = 'Frodo'
    AND 
    emp_lname = 'Baggins')
    AND
    cl_atd IS NOT NULL
    AND
    cl_leg_nbr = 1
ORDER BY
    cl_atd desc;

/*
    Q8
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT 
    ch.charter_nbr,
    client_nbr,
    nvl(client_lname,'-') AS client_lname,
    nvl(client_fname,'-') AS client_fname,
    to_char(round(sum((cl_ata-cl_atd)*charter_cost_per_hour)*24,2),'$9,999,999.99') AS TOTAL
FROM
    MH.charter ch 
    JOIN MH.charter_leg cl ON ch.charter_nbr = cl.charter_nbr
    JOIN MH.client using (client_nbr)
WHERE
    cl_atd is not null
    OR
    cl_ata is not null
GROUP BY
    ch.charter_nbr,
    client_nbr,
    client_lname,
    client_fname
HAVING
    sum((cl_ata-cl_atd)*charter_cost_per_hour)*24 < 
    (SELECT 
        avg(sum((cl_ata-cl_atd)*charter_cost_per_hour)*24)
    FROM
        MH.charter ch 
        JOIN MH.charter_leg cl ON ch.charter_nbr = cl.charter_nbr
    GROUP BY
        ch.charter_nbr,
        client_nbr,
        client_lname,
        client_fname)
ORDER BY
    total desc;

/*
    Q9
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT 
    ch.charter_nbr,
    TRIM(emp_fname|| ' ' || emp_lname) as PILOTNAME,
    TRIM(client_fname|| ' ' || client_lname) as CLIENTNAME
FROM
    MH.charter ch 
    JOIN MH.charter_leg cl ON cl.charter_nbr = ch.charter_nbr
    JOIN MH.employee using (emp_nbr)
    JOIN MH.client using (client_nbr)
WHERE
    cl.cl_etd = cl.cl_atd
GROUP BY
    ch.charter_nbr, TRIM(emp_fname|| ' ' || emp_lname), TRIM(client_fname|| ' ' || client_lname)
HAVING
    COUNT(ch.charter_nbr) = 
    (SELECT 
        COUNT(cl.charter_nbr)
    FROM 
        MH.charter ch2 JOIN MH.charter_leg cl ON cl.charter_nbr = ch2.charter_nbr
    WHERE 
        ch2.charter_nbr = ch.charter_nbr
    GROUP BY 
        cl.charter_nbr)
ORDER BY
    ch.charter_nbr;
