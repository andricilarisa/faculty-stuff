--exercitiul 2--
drop table persoane;
CREATE OR REPLACE TYPE lista_prenume AS TABLE OF VARCHAR2(10);
/
CREATE TABLE persoane (nume varchar2(10), 
prenume lista_prenume)
NESTED TABLE prenume STORE AS lista;
/ 
INSERT INTO persoane VALUES('Popescu', lista_prenume('Ionut', 'Razvan'));
INSERT INTO persoane VALUES('Rizea', lista_prenume('Mircea', 'Catalin'));
INSERT INTO persoane VALUES('Ionescu', lista_prenume('Elena', 'Madalina'));
/



declare

pren_value varchar2(50);
verificare integer := 0;
begin

for i in (select * from persoane) loop
verificare := 0;
pren_value := '';
  for j in (select column_value from table(i.prenume)) loop
      pren_value := concat(pren_value, concat(' ', j.column_value));
      if(j.column_value like '%u%') then verificare := 1;
      end if;
      end loop;
   if(verificare = 1) then SYS.DBMS_OUTPUT.PUT_LINE(i.nume||' '||pren_value);
  end if;
end loop;

end;