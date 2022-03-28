--query 3_24_22
--Drop table patient if already existing
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PATIENT CASCADE CONSTRAINT PURGE';
	EXCEPTION
    WHEN OTHERS THEN
    NULL;
END;
/
--Create table patient
create table patient (
pat_id varchar2(10 CHAR),
pat_name varchar2(60 CHAR),
pat_gender varchar2(2 CHAR),
pat_address varchar2(100 CHAR),
pat_number number(11,0),
pat_doc_code varchar2(10 CHAR),
constraint pk_patient primary key (pat_id),
constraint uq_doc_code unique (pat_doc_code)
);
/

--Drop table patient_diagnosis if already existing
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PATIENT_DIAGNOSIS CASCADE CONSTRAINT PURGE';
	EXCEPTION
    WHEN OTHERS THEN
    NULL;
END;
/
--Create table patient_diagnosis
create table patient_diagnosis(
Diag_ID varchar2(10 CHAR),
diag_details varchar2(200 CHAR),
diag_remarks varchar2(200 CHAR),
diag_date date,
pat_id varchar2(10 CHAR),
constraint pk_patient_diagnosis primary key  (diag_id),
constraint fk_pat_id foreign key (pat_id)
references patient(pat_id)
);
/

--Drop table doctor if already existing
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DOCTOR CASCADE CONSTRAINT PURGE';
	EXCEPTION
    WHEN OTHERS THEN
    NULL;
END;
/
--create table doctor
create table doctor(
doc_code varchar2(10 CHAR),
doc_name varchar2(60 CHAR),
doc_gender varchar2(2 CHAR),
doc_address varchar2(200 CHAR),
doc_designation varchar2(30 CHAR),
doc_number number(11,0),
constraint pk_doctor primary key (doc_code),
constraint fk_doc_code foreign key (doc_code)
references patient(pat_doc_code)
);
/

--Drop table bill if already existing
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BILL CASCADE CONSTRAINT PURGE';
	EXCEPTION
    WHEN OTHERS THEN
    NULL;
END;
/
--create table bill
create table bill(
bill_no integer,
pat_id varchar2(10 CHAR),
pat_name varchar2(60 CHAR),
pat_gender varchar2(2 CHAR),
pat_address varchar2(100 CHAR),
doc_name varchar2(60 CHAR),
amount NUMBER(19,9),
constraint pk_bill primary key (bill_no),
constraint fk_bill_pat_id foreign key (pat_id)
references patient(pat_id)
);
/


--PATIENT ENTRIES:


INSERT INTO PATIENT values ('P001','Tom Kush','M','222 Village rd,Newark , Delaware',5553331111,'D001');
INSERT INTO PATIENT values ('P002','Milka Sod','F','114 Candle Sq, Wake, North Carolina',4022221111,'D004');
INSERT INTO PATIENT values ('P003','Rudd Bok ','M','103 Skid Moore Ct, Symarna, SouthCarolina',4125551212,'D003');
INSERT INTO PATIENT values ('P004','Duke Walter','M','19 Blaster Rd , Brockton, Massachusette',3336561111,'D005');
INSERT INTO PATIENT VALUES ('P005','Colin Chad','M','Queens  New York ',5152325555,'D002');

--PAtient Diagnosis  Entries :


INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG001','Suffering from asthma','Need to use rescue inhalers',sysdate,'P001');
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG002','Suffering from heart diseases','Treatments vary widely and can include lifestyle changes, medication, surgery, stents, pacemakers and ablation.',sysdate,'P002');
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG003','Suffering from Constipation ','Use laxative',sysdate,'P003');
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG004','Suffering from mouth diseases','Need to use pain relievers',sysdate,'P004');
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG005','Suffering from migrane','Avoid stress, improve sleep habit and have a balanced diet',sysdate,'P005');


--DOCTOR Entries:
INSERT INTO DOCTOR VALUES ('D001','Dr P Patel ','M','222, Mass General,Boston, Massachusette','Allergist',5082221111);
INSERT INTO DOCTOR VALUES ('D002','Dr James Stewart','M','94, GNH Hospital, Lowell,  Massachusette','Cardiologist',8800188336);
INSERT INTO DOCTOR VALUES ('D003','Dr Desai Pamithani ','F','1212, Hill Oak Hospital, Harrisburg, Pennyslavinia','Dermatologist',2152795770);
INSERT INTO DOCTOR VALUES ('D004','Dr Tim Johnson','M','14, Bay Health Gen Hosp','Oral Surgeon',3034441111);
INSERT INTO DOCTOR VALUES ('D005','Dr. Praveen Gupta','M','Fortis Memorial Hospt, Baltimore , Maryland','Neurologist',4100761036);



