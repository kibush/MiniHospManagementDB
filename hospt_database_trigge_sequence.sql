BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE BILL_NO_SEQ';
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE!= -2289 THEN
            RAISE;
            END IF;
END;
/

CREATE SEQUENCE BILL_NO_SEQ
  MINVALUE 1
  MAXVALUE 100000
  START WITH 1
  INCREMENT BY 1;
/ 


CREATE OR REPLACE TRIGGER BILL_TRG
BEFORE INSERT ON BILL
FOR EACH ROW
DECLARE
DOC_ID VARCHAR(10 CHAR);
BEGIN
IF :NEW.BILL_NO IS NULL THEN
     SELECT BILL_NO_SEQ.NEXTVAL INTO :NEW.BILL_NO FROM DUAL;
END IF;
IF :NEW.PAT_NAME IS NULL THEN
     SELECT PAT_NAME INTO :NEW.PAT_NAME FROM PATIENT WHERE PAT_ID=:NEW.PAT_ID;
END IF;
IF :NEW.PAT_GENDER IS NULL THEN
     SELECT PAT_GENDER INTO :NEW.PAT_GENDER FROM PATIENT WHERE PAT_ID=:NEW.PAT_ID;
END IF;
IF :NEW.PAT_ADDRESS IS NULL THEN
     SELECT PAT_ADDRESS INTO :NEW.PAT_ADDRESS FROM PATIENT WHERE PAT_ID=:NEW.PAT_ID;
END IF;
IF :NEW.DOC_NAME IS NULL THEN
     SELECT PAT_DOC_CODE INTO DOC_ID FROM PATIENT WHERE PAT_ID=:NEW.PAT_ID;
	 SELECT DOC_NAME INTO :NEW.DOC_NAME FROM DOCTOR WHERE DOC_CODE = DOC_ID;
END IF;
END;
/

select * from bill;


--Bill (To be inserted after trigger creation)
INSERT INTO BILL (PAT_ID,AMOUNT) values ('P001',1000.4);
INSERT INTO BILL (PAT_ID,AMOUNT) values ('P002',5000.5);
INSERT INTO BILL (PAT_ID,AMOUNT) values ('P003',2500.5);
INSERT INTO BILL (PAT_ID,AMOUNT) values ('P004',7600);
INSERT INTO BILL (PAT_ID,AMOUNT) values ('P005',15000.7);