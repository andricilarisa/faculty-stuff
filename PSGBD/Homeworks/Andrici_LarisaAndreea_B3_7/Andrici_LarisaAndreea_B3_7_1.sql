  set serveroutput on;
  
  --tabela cu date
  drop table INTREBARI_ALESE;
  CREATE TABLE INTREBARI_ALESE (id number, chapter_id number, user_id number, question clob, answer clob, asked number, solved number, reported number, report_resolved number);
  
  --functie de verificare a intrabarilor
  
  create or replace package checking is
   function alege_intrebare(questionId questions.id%type) return varchar2;
   end checking;
   /
   
   create or replace package body checking is
   
   intrebarea_nuExista exception;
   PRAGMA EXCEPTION_INIT(intrebarea_nuExista, -20001);
   
   intrebare_existenta exception;
   PRAGMA EXCEPTION_INIT(intrebare_existenta, -20002);
   
   relevanta_slaba exception;
   PRAGMA EXCEPTION_INIT(relevanta_slaba, -20003);
   
   function alege_intrebare(questionId questions.id%type)
   return varchar2 
   as
   
   mesaj_eroare varchar2(200);
   good_end varchar2(200);
   id_intrebare number;
   id_capitol number;
   id_user number;
   intrebare clob;
   raspuns clob;
   aparitii number;
   rezolvata number;
   raportata number;
   raport_rezolvat number;
   verificare number:=0;
   ok number :=0;
   
   begin
     
     for i in (select id from questions)
     loop
     if (questionId = i.id) then
     ok:= 1;
     end if;
     end loop;
     
     if (ok = 0) then 
     raise intrebarea_nuExista;
     end if;
     
     if(FUNCTIONSPACK.revelance_question(questionId) = 0 )then
     raise relevanta_slaba;
     
     else
      for j in (select id from intrebari_alese)
      loop
      if(questionId = j.id) then 
      verificare:=1;
      end if;
      end loop;
     
        if (verificare = 0) then
           SELECT CHAPTER_ID, id, user_id, question, answer,asked, solved, reported, report_resolved into id_capitol, id_intrebare, id_user,
           intrebare, raspuns, aparitii, rezolvata, raportata, raport_rezolvat from questions where id = questionId;
           insert into INTREBARI_ALESE values (id_intrebare, id_capitol, id_user, intrebare, raspuns, aparitii, rezolvata, raportata, raport_rezolvat);
           good_end:='Good';
           return good_end;
      else 
          raise intrebare_existenta;
        end if;
     end if;
   
   exception 
   when intrebarea_nuExista then
    return 'ORA-20001:Intrebarea pe care o cautati nu exista ';
    when intrebare_existenta then
   return 'ORA-20002:Intrebarea exista deja in tabela';
    when relevanta_slaba then
    return 'ORA-20003:Intrebarea are o relevanta slaba';
   
 end;
 end checking;
/

begin
  dbms_output.put_line(checking.alege_intrebare(873));
end;


--blocul anonim
declare
rows number:=0;
nr_random number:=0;

begin
while (rows != 1000)
loop
nr_random := trunc(dbms_random.value(1, 6416));

if(CHECKING.ALEGE_INTREBARE(nr_random)='Good') then
rows:=rows+1;

end if;
end loop;
end;

