--exercitiu 1
drop table tema2 cascade constraints;
create table tema2 (id number, nume varchar2(50), prenume varchar2(50), telefon number, email varchar2(50), data_nastere date);

CREATE SEQUENCE usr_seq START WITH 1;
CREATE OR REPLACE TRIGGER nr_users BEFORE INSERT ON tema2 FOR EACH ROW BEGIN SELECT usr_seq.NEXTVAL INTO :new.id FROM dual; END; 

--SELECT trunc(dbms_random.value(0700000000,0799999999)) as random_num FROM dual WHERE "random_num" NOT IN (SELECT telefon as random_num FROM tema2);

insert into tema2 (nume, prenume,telefon,email,data_nastere) SELECT 
SUBSTR(s.name, INSTR(s.name, ' ')+1),
SUBSTR(s.name, 1, INSTR(s.name, ' ')-1),
(SELECT dbms_random.value(0700000000,0799999999) as random_num FROM dual),
username || '@info.uaic.ro',
(SELECT TO_DATE( TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '1997-01-01','J'),
TO_CHAR(DATE '1997-12-31','J'))),'J') FROM DUAL)
FROM Users s; 

declare
 v_index number:=1;
 v_telefon number;
 v_date date;
begin
loop
 SELECT dbms_random.value(0700000000,0799999999) INTO v_telefon FROM dual;
 SELECT TO_DATE( TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '1997-01-01','J'),TO_CHAR(DATE '1997-12-31','J'))),'J') INTO v_date FROM DUAL;
 update tema2 set telefon= v_telefon where id=v_index;
 update tema2 set data_nastere=v_date where id=v_index;
 v_index := v_index +1;
exit when v_index = 515; 
end loop; 
end;