--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-cb-dm.sql

--Student ID: 30881919
--Student Name: Goh Kai Yuan
--Tutorial No: 4

/* Comments for your marker:




*/

/*
Task 2 (c):

Complete the listed DML actions
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

-- (i)
drop sequence animal_seq;
drop sequence breeding_event_seq;
create sequence animal_seq start with 500 increment by 1;
create sequence breeding_event_seq start with 500 increment by 1;

-- (ii)
UPDATE animal
SET centre_id = (SELECT centre_id FROM centre WHERE centre_name = 'Kruger National Park')
WHERE centre_id = (SELECT centre_id FROM centre WHERE centre_name = 'SanWild Wildlife Sanctuary');

DELETE FROM centre
WHERE centre_name = (SELECT centre_id FROM centre WHERE centre_name = 'SanWild Wildlife Sanctuary');
--select * from centre;
--select * from animal;
commit; 

-- (iii)
INSERT INTO animal(animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values
    (animal_seq.nextval, 
    'F',
    '',
    (SELECT centre_id FROM centre WHERE centre_name = 'Australia Zoo'),
    (SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'),
    (SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil'));
    
INSERT INTO animal(animal_id,animal_sex,brevent_id,centre_id,spec_genus,spec_name) values
    (animal_seq.nextval, 
    'M',
    '',
    (SELECT centre_id FROM centre WHERE centre_name = 'Werribee Open Range Zoo'),
    (SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'),
    (SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil'));
--SELECT * FROM animal;
commit;

-- (iv)
INSERT INTO BREEDING_EVENT (brevent_id,brevent_date,mother_id,father_id) values 
    (breeding_event_seq.nextval,
    TO_DATE('10-February-2021', 'DD/MON/YY'),
    (SELECT animal_id FROM animal WHERE centre_id = (SELECT centre_id FROM centre WHERE centre_name = 'Australia Zoo')
    AND
    spec_genus = (SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil')
    AND
    spec_name = (SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil')),
    (SELECT animal_id FROM animal WHERE centre_id = (SELECT centre_id FROM centre WHERE centre_name = 'Werribee Open Range Zoo')
    AND
    spec_genus = (SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil')
    AND
    spec_name = (SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil')));
commit;

-- TWO NEW BABIES
Insert into ANIMAL values(
	animal_seq.NEXTVAL,
	'F', 
	breeding_event_seq.CURRVAL, 
	(SELECT centre_id FROM centre WHERE centre_name = 'Australia Zoo'), 
	(SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'), 
	(SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil')		
); 

Insert into ANIMAL values(
	animal_seq.NEXTVAL,
	'M', 
	breeding_event_seq.CURRVAL, 
	(SELECT centre_id FROM centre WHERE centre_name = 'Australia Zoo'), 
	(SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'), 
	(SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil')		
); 
COMMIT;


