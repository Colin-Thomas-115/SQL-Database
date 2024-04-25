
create database MedicalCenter;
use MedicalCenter;

create table PERSON(
gov_id int(8) NOT NULL primary key, 
f_name varchar(20) not null, 
l_name varchar(20) not null, 
age int(3), 
dob varchar(12), 
gender varchar(1),
phone varchar(12));

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
p_id int(6),
constraint doc_id_goTo foreign key(doc_id) references DOCTOR(doc_id),
constraint nurse_id_goTo foreign key(nurse_id) references NURSE(nurse_id),
constraint app_id_goTo foreign key(app_id) references APPOINTMENTS(app_id),
constraint p_id_goTo foreign key(p_id) references PATIENT(p_id),
diagnosis varchar(200));
