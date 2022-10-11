--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-cb-alter.sql

--Student ID: 30881919
--Student Name: Goh Kai Yuan
--Tutorial No: 4

/* Comments for your marker:




*/

/*
Task 3:

Make the listed changes to the "live" database
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

-- (a)
alter table centre drop column centre_offsprings; 
alter table centre add (centre_offsprings NUMBER(2,0) default 0);

-- (b)
/*
******* Explain here your selected approach and its advantage/s *********
The approach that I have decided to implement is to add a new column which is 
animal_live to indicate whether that particular animal is dead or alive. 'L' 
stands for the animal is still alive while 'D' stands for the animal is dead. 
One of the advantage of using a new column indicating if the animal is still 
alive is that no data is lost when implementing the new column and therefore, 
the data will still be remained even after an animal is dead. Besides, the 
advantage is that it follows the A,C,I,D properties.
*/
alter table animal drop column animal_live; 
alter table animal add (animal_live CHAR(1));
alter table animal add constraint chk_animal_live CHECK (animal_live in ('L', 'D'));

UPDATE animal
SET animal_live = 'L';
commit;

UPDATE animal 
SET animal_live = 'D'
WHERE animal_id = '4' AND centre_id = 'AUS40' AND spec_genus = 'Macrotis' AND spec_name = 'lagotis';
commit;

-- (c)
alter table centre drop column centre_type; 
alter table centre add (centre_type VARCHAR2(25) default 'Other'); 

--Zoo
UPDATE centre
SET centre_type = 'Zoo'
WHERE centre_name LIKE '%Zoo%'; 

--Park 
UPDATE centre
SET centre_type = 'Wildlife Park'
WHERE centre_name LIKE '%Park%'; 

--Sanctuary
UPDATE centre
SET centre_type = 'Sanctuary'
WHERE centre_name LIKE '%Sanctuary%'; 

--Natural Reserve
UPDATE centre
SET centre_type = 'Natural Reserve'
WHERE centre_name LIKE '%Reserve%'; 
commit; 
