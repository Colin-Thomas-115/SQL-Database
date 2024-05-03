-- Creates the different roles and they are all given the same password

-- Create the doctor_role user
CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'password';

-- Grant the doctor_role to the doctor_user
GRANT doctor_role TO 'doctor_user'@'localhost';

-- Create the patient_role user
CREATE USER 'patient_user'@'localhost' IDENTIFIED BY 'password';

-- Grant the patient_role to the patient_user
GRANT patient_role TO 'patient_user'@'localhost';

-- Create the receptionist_role user
CREATE USER 'receptionist_user'@'localhost' IDENTIFIED BY 'password';

-- Grant the receptionist_role to the receptionist_user
GRANT receptionist_role TO 'receptionist_user'@'localhost';

use MedicalCenter;
														-- DOCTORS --
                                                        
-- This is what the doctor would see when they logged in and are viewing their upcoming appointments. They can see the patient name,their age, the date and time, and the diagnosis
create view doctors_view as (select concat(p.f_name,' ', p.l_name) as Patient_Name, p.age as Patient_Age, a.app_date as Appointment_Date,
a.app_time as Appointment_Time,g.diagnosis as Diagnosis from GO_TO g 
join PATIENT pa on g.p_id = pa.p_id join PERSON p on pa.gov_id = p.gov_id join APPOINTMENTS a on g.app_id = a.app_id);

-- A view of what the doctor would be able to see when looking up patients medical records. 
create view doctor_MR_view as (select concat (p.f_name,' ', p.l_name) as Patient_Name, 
mr.mr_id as Medical_Record_ID, mr.p_treatment as Treatment, mr.p_admission as Admission_Date, mr.p_discharge as Discharge_Date
from MEDICAL_RECORDS mr join PATIENT pa on mr.p_id = pa.p_id join PERSON p on pa.gov_id = p.gov_id);

-- They can insert,update, view and delete patients medical records
grant view,update,delete,insert on doctor_MR_view to doctor_role;
-- They can view but not update nor delete appointments. Only receptionist can do that
grant view on doctors_view to doctor_role;

															-- PATIENTS --
-- A patient looking up their own medical records 
create view patient_MR_view as (select concat (p.f_name,' ', p.l_name) as Patient_Name, 
 mr.p_treatment as Treatment, mr.p_admission as Admission_Date, mr.p_discharge as Discharge_Date,
mr.p_cost as Cost
from MEDICAL_RECORDS mr join PATIENT pa on mr.p_id = pa.p_id join PERSON p on pa.gov_id = p.gov_id);

-- This is what the patient sees when seeing their upcoming appointments
create view patient_view as (select concat(p.f_name,' ', p.l_name) as Doctors_Name, a.app_date as Appointment_Date,
a.app_time as Appointment_Time from GO_TO g 
join DOCTOR doc on g.doc_id = doc.doc_id join PERSON p on doc.gov_id = p.gov_id join APPOINTMENTS a on g.app_id = a.app_id);

-- A patient can only see their medical records but not modify them in any way
grant select on patient_MR_view to patient_role;
-- A patient can see their upcoming appointments but not delete or update them. They can request a receptionist to be able to cancel an appointment
grant select on patient_view to patient_role;

-- A receptionist looking up
create view recep_appointments as (select concat (p.f_name,' ', p.l_name) as Patient_Name, app_date, app_time
from GO_TO g join APPOINTMENTS a on g.app_id = a.app_id join PATIENT pa on g.p_id = pa.p_id join PERSON p on p.gov_id = pa.gov_id );
-- A receptionist can 
grant select, update, delete,insert on recep_appointments to receptionist_role;
