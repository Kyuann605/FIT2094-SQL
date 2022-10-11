--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-cb-schm.sql

--Student ID: 30881919
--Student Name: Goh Kai Yuan
--Tutorial No: 4

/* Comments for your marker:




*/

/*
Using the model and details supplied, and the supplied T1-cb-schm.sql
file, create an SQL schema file which can be used to create this database in
Oracle.
*/
drop table animal cascade constraints purge;
drop table breeding_event cascade constraints purge;
drop table species cascade constraints purge;
drop table centre cascade constraints purge;

--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW
CREATE TABLE species (
    spec_genus VARCHAR2(20) NOT NULL,
    spec_name VARCHAR2(20) NOT NULL,
    spec_popular_name VARCHAR2(40) NOT NULL,
    spec_family VARCHAR2(20) NOT NULL,
    spec_natural_range VARCHAR2(100) NOT NULL
);
alter table species add constraint species_pk primary key (spec_genus, spec_name);
alter table species add constraint un_spec_popular_name unique (spec_popular_name);

COMMENT ON COLUMN species.spec_genus IS
    'Species genus';
    
COMMENT ON COLUMN species.spec_name IS
    'Species name';

COMMENT ON COLUMN species.spec_popular_name IS
    'Species popular name';

COMMENT ON COLUMN species.spec_family IS
    'Species family name';

COMMENT ON COLUMN species.spec_genus IS
    'Description of the natural range of the species';

CREATE TABLE centre (
    centre_id CHAR(6) NOT NULL,
    centre_name VARCHAR2(40) NOT NULL,
    centre_address VARCHAR2(100) NOT NULL,
    centre_director VARCHAR2(30) NOT NULL,
    centre_phone_no VARCHAR2(20) NOT NULL
);
alter table centre add constraint pk_centre primary key (centre_id);
alter table centre add constraint un_centre_name unique (centre_name);

COMMENT ON COLUMN centre.centre_id IS
    'Identifier for the centre';

COMMENT ON COLUMN centre.centre_name IS
    'Centre name';

COMMENT ON COLUMN centre.centre_address IS
    'Centre address';

COMMENT ON COLUMN centre.centre_director IS
    'Name of the centre director';

COMMENT ON COLUMN centre.centre_phone_no IS
    'Centre phone contact number';
    
CREATE TABLE breeding_event (
    brevent_id NUMERIC(6) NOT NULL,
    brevent_date DATE NOT NULL,
    mother_id NUMERIC(6) NOT NULL,
    father_id NUMERIC(6) NOT NULL
);
alter table breeding_event add constraint pk_breeding_event primary key (brevent_id); 

COMMENT ON COLUMN breeding_event.brevent_id IS
    'Identifier for the breeding event';
    
COMMENT ON COLUMN breeding_event.brevent_date IS
    'Date on breeding event';
    
COMMENT ON COLUMN breeding_event.mother_id IS
    'Animal id of the mother';
    
COMMENT ON COLUMN breeding_event.father_id IS
    'Animal id of the father';

CREATE TABLE animal (
    animal_id NUMERIC(6) NOT NULL,
    animal_sex CHAR(1) NOT NULL,
    brevent_id NUMERIC(6),
    centre_id CHAR(6) NOT NULL,
    spec_genus VARCHAR2(20) NOT NULL,
    spec_name VARCHAR2(20) NOT NULL
);
alter table animal add constraint pk_animal primary key (animal_id);
alter table animal add constraint fk_animal_brevent_id foreign key (brevent_id) REFERENCES breeding_event(brevent_id);
alter table animal add constraint fk_animal_centre_id foreign key (centre_id) REFERENCES centre(centre_id);
alter table animal add constraint fk_animal_spec foreign key (spec_genus, spec_name) REFERENCES species(spec_genus, spec_name);
alter table animal add constraint chk_animal_sex CHECK (animal_sex in ('M', 'F'));
alter table breeding_event add constraint fk_breeding_event_mother foreign key (mother_id) REFERENCES animal(animal_id);
alter table breeding_event add constraint fk_breeding_event_father foreign key (father_id) REFERENCES animal(animal_id);

COMMENT ON COLUMN animal.animal_id IS
    'Identifier for the animal';
    
COMMENT ON COLUMN animal.animal_sex IS
    'Animal sex M or F';
    
COMMENT ON COLUMN animal.brevent_id IS
    'ID of the breeding event';
    
COMMENT ON COLUMN animal.centre_id IS
    'ID of the center that locates the animal';
    
COMMENT ON COLUMN animal.spec_genus IS
    'Species genus for the animal';
    
COMMENT ON COLUMN animal.spec_name IS
    'Species name for the animal';

commit;







