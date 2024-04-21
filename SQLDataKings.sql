
create database MedicalCenter;
use MedicalCenter;

create table PERSON(
gov_id int(8) NOT NULL primary key, 
f_name varchar(20) not null, 
l_name varchar(20) not null, 
age int(3), 
dob varchar(12), 
gender varchar(1));

create table EMPLOYEE(
emp_id int(6) not null primary key auto_increment,
gov_id int(8) not null,
payHourly int(6),
hours int(4),
salary int(10),
constraint fk_person_id foreign key(gov_id) references PERSON(gov_id));

create table PATIENT(
p_id int(6) not null primary key auto_increment,
gov_id int(8) not null,
constraint patientGov_ID_fk foreign key(gov_id) references PERSON (gov_id));

create table ADMINISTRATOR(
emp_id int(6) not null,
gov_id int(8) not null,
constraint adminGov_id foreign key(emp_id) references EMPLOYEE(emp_id),
constraint admin_ID_fk foreign key(gov_id) references PERSON (gov_id));

ALTER TABLE ADMINISTRATOR RENAME COLUMN emp_id TO admin_id;

create table RECEPTIONIST(
emp_id int(6) not null,
constraint recep_id foreign key(emp_id) references EMPLOYEE(emp_id),
gov_id int(8) not null,
constraint recepGov_ID_fk foreign key(gov_id) references PERSON (gov_id));
ALTER TABLE RECEPTIONIST RENAME COLUMN emp_id TO recep_id;

create table NURSE(
emp_id int(6) not null,
constraint nurse_id foreign key(emp_id) references EMPLOYEE(emp_id),
gov_id int(8) not null,
constraint nurseGovb_ID_fk foreign key(gov_id) references PERSON (gov_id));
ALTER TABLE NURSE RENAME COLUMN emp_id TO nurse_id;

create table DOCTOR(
emp_id int(6) not null,
constraint doc_id foreign key(emp_id) references EMPLOYEE(emp_id),
gov_id int(8) not null,
constraint DocGovID_fk foreign key(gov_id) references PERSON (gov_id),
specialization varchar(20),
qualifications varchar(20));
ALTER TABLE DOCTOR RENAME COLUMN emp_id TO doc_id;

create table APPOINTMENTS(
app_id int(6) not null primary key auto_increment,
app_date varchar(9),
app_time varchar(9));

create table MEDICAL_RECORDS(
mr_id int(7) not null primary key auto_increment,
p_id int(6),
constraint p_id foreign key(p_id) references PATIENT(p_id),
p_treatment varchar(100),
p_discharge varchar(10),
p_admission varchar(10),
p_cost int(10));

create table FILL_IN(
doc_id int(6),
nurse_id int(6),
mr_id int(6),
constraint doc_id_filled foreign key(doc_id) references DOCTOR(doc_id),
constraint nurse_id_filled foreign key(nurse_id) references NURSE(nurse_id),
constraint mr_id_filled foreign key(mr_id) references MEDICAL_RECORDS(mr_id));

create table SET_UP(
recep_id int(6),
app_id int(6),
constraint recep_id_setUp foreign key(recep_id) references RECEPTIONIST(recep_id),
constraint app_id_setUp foreign key(app_id) references APPOINTMENTS(app_id));

create table GO_TO(
doc_id int(6),
nurse_id int(6),
app_id int(6),
constraint doc_id_goTo foreign key(doc_id) references DOCTOR(doc_id),
constraint nurse_id_goTo foreign key(nurse_id) references NURSE(nurse_id),
constraint app_id_goTo foreign key(app_id) references APPOINTMENTS(app_id),
diagnosis varchar(200));

select * from employee;

--INSERT STATEMENTS--

INSERT INTO PERSON 
VALUES ('845632190', 'John', 'Smith', '32', '04/21/92', 'M');
INSERT INTO PERSON 
VALUES ('306518742', 'Amelia', 'King', '33', '06/14/90', 'F');
INSERT INTO PERSON 
VALUES ('729064815', 'Chris', 'Jones', '37', '07/19/86', 'M');
INSERT INTO PERSON 
VALUES ('513970624', 'Alyssa', 'Graham', '28', '03/10/96', 'F');
INSERT INTO PERSON 
VALUES ('208746931', 'Jack', 'Willson', '43', '08/15/80', 'M');
INSERT INTO PERSON 
VALUES ('583917246', 'Warren', 'Willis', '33', '08/15/90', 'M');
INSERT INTO PERSON 
VALUES ('102835479', 'Sara', 'Jackson', '35', '10/11/88', 'F');
INSERT INTO PERSON 
VALUES ('726591038', 'Daniel', 'Jones', '47', '11/18/76', 'M');
INSERT INTO PERSON 
VALUES ('349802615', 'Emma', 'Johnson', '26', '02/08/94', 'F');
INSERT INTO PERSON 
VALUES ('914267583', 'Michael', 'Brown', '49', '03/02/75', 'M');

INSERT INTO EMPLOYEE
VALUES ('485612', '845632190', '48.00', '40', NULL);
INSERT INTO EMPLOYEE
VALUES ('846274', '306518742', '52.00', '41', NULL);
INSERT INTO EMPLOYEE
VALUES ('956426', '729064815', NULL, '40', '110000');
INSERT INTO EMPLOYEE
VALUES ('414212', '513970624', NULL, '39', '115000');
INSERT INTO EMPLOYEE
VALUES ('475214', '208746931', '51.00', '39', NULL);

INSERT INTO PATIENT
VALUES ('983526', '583917246');
INSERT INTO PATIENT
VALUES ('534847', '102835479');
INSERT INTO PATIENT
VALUES ('874635', '726591038');
INSERT INTO PATIENT
VALUES ('344879', '349802615');
INSERT INTO PATIENT
VALUES ('425433', '914267583');

INSERT INTO ADMINISTRATOR
VALUES ('485612', '845632190');


INSERT INTO RECEPTIONIST
VALUES ('846274', '306518742');

INSERT INTO NURSE
VALUES ('414212', '513970624');


INSERT INTO DOCTOR
VALUES ('956426', '729064815', 'Knee', 'Doctorate');


INSERT INTO APPOINTMENTS
VALUES ('647521', '02/17/23', '13:00');

-- NINTH TABLE--
INSERT INTO MEDICAL_RECORDS
VALUES('342678', '983526', 'Knee Surgery', '03/26/23', '03/25/23', '5000');

-- TENTH TABLE
INSERT INTO FILL_IN
VALUES ('956426','414212','342678');

-- 11TH TABLE
INSERT INTO SET_UP
VALUES ('846274','647521');

-- 12TH TABLE--
INSERT INTO GO_TO
VALUES ('956426','414212','647521','ACL Tear');

