--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-cb-insert.sql

--Student ID: 30881919
--Student Name: Goh Kai Yuan
--Tutorial No: 4

/* Comments for your marker:




*/

/*
Task 2 (b):

Load the ANIMAL and BREEDING_EVENT tables with your own test data using the 
supplied T2-cb-insert.sql file script file, and SQL commands which will  
insert as a minimum, the following sample data -
 - 12 animals, some of which must have been captured from the wild, i.e. 
      are not the offspring from a breeding event, and
- 4 breeding events
Your inserted rows must meet the assignment specification requirements
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW
delete from breeding_event;
delete from animal;

--INSERT INTO ANIMAL
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (1,'F','','AUS30','Sarcophilus','harrisii');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (2,'M','','AUS30','Sarcophilus','harrisii');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (3,'F','','AUS40','Macrotis','lagotis');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (4,'M','','AUS40','Macrotis','lagotis');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (5,'F','','SAF20','Equus','zebra');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (6,'M','','SAF20','Equus','zebra');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (7,'F','','SAF30','Panthera','leo');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (8,'M','','SAF30','Panthera','leo');
commit;

--INSERT INTO BREEDING_EVENT
INSERT INTO BREEDING_EVENT (brevent_id,brevent_date,mother_id,father_id) values (1,TO_DATE('5-June-2020', 'DD/MON/YY'),1,2);
INSERT INTO BREEDING_EVENT (brevent_id,brevent_date,mother_id,father_id) values (2,TO_DATE('19-April-2020', 'DD/MON/YY'),3,4);
INSERT INTO BREEDING_EVENT (brevent_id,brevent_date,mother_id,father_id) values (3,TO_DATE('21-February-2020', 'DD/MON/YY'),5,6);
INSERT INTO BREEDING_EVENT (brevent_id,brevent_date,mother_id,father_id) values (4,TO_DATE('31-August-2020', 'DD/MON/YY'),7,8);
--select * from BREEDING_EVENT;
commit;

--INSERT THE CHILD INTO ANIMAL
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (9,'M',1,'AUS30','Sarcophilus','harrisii');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (10,'F',2,'AUS40','Macrotis','lagotis');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (11,'M',3,'SAF20','Equus','zebra');
INSERT INTO ANIMAL (animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values (12,'F',4,'SAF30','Panthera','leo');
--select * from ANIMAL;
commit;

