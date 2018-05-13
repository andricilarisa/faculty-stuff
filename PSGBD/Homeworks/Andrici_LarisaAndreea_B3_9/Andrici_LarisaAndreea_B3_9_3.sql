create or replace procedure IntrebariCuPromotie (int_id number) as
nume_tabela varchar(200);
nume_user varchar(50);
nr_raspunsuri number;
raspunsuri_corecte number;
data_actualizare timestamp(6);
cursor_intrebari number;
userID number;
de_executat varchar(2000);
de_executat2 varchar(2000);
something number;
begin

  nume_tabela := 'intrebaree_' || int_id;
  select user_id into userID from questions where id= int_id;
  select username into nume_user from users where id= userID;
  select asked into nr_raspunsuri from questions where id = int_id;
  select solved into raspunsuri_corecte from questions where id = int_id;
  select updated_at into data_actualizare from questions where id = int_id;
  
    cursor_intrebari := dbms_sql.open_cursor;
    de_executat := 'create table ' || nume_tabela || ' (nume_user varchar(50),
    nr_raspunsuri number, raspunsuri_corecte number, data_actualizare timestamp(6))';
    dbms_sql.parse(cursor_intrebari, de_executat, dbms_sql.native);
    something := dbms_sql.execute(cursor_intrebari);
    
    cursor_intrebari := dbms_sql.open_cursor;
    de_executat2 := 'insert into '|| nume_tabela || ' values (:user_name, 
    :nr_raspunsuri, :raspunsuri_corecte, :data_actualizare)';
    dbms_sql.parse(cursor_intrebari, de_executat2, dbms_sql.native);
    
    dbms_sql.bind_variable (cursor_intrebari, ':user_name', nume_user);
    dbms_sql.bind_variable (cursor_intrebari, ':nr_raspunsuri',nr_raspunsuri);
    dbms_sql.bind_variable (cursor_intrebari, ':raspunsuri_corecte',raspunsuri_corecte);
    dbms_sql.bind_variable (cursor_intrebari, ':data_actualizare', data_actualizare);
    
    something := dbms_sql.execute (cursor_intrebari);
    dbms_sql.close_cursor(cursor_intrebari);
    
    
end;


declare

cursor intrebari is select id from questions where reported >= 5 and updated_at >= to_timestamp('2017/01/15 00:00:00', 'YYYY/MM/DD HH24:MI:SS');
begin

for indice in intrebari
loop

IntrebariCuPromotie(indice.id);

end loop;


end;


begin
  for i in (select table_name from user_tables where table_name like 'INTREBARE%') loop
    execute immediate 'drop table ' || i.table_name || ' cascade constraints';
  end loop;
end;
