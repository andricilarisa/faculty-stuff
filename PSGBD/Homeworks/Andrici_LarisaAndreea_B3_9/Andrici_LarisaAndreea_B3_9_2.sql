


create or replace procedure AfisareDate (id_user number) as
ignore1 int;
username varchar2(200);
puturos number;
nr_intrebari number;
intrebari_relevante number;
numar_raporturi number;
raporturi_gresite number;
cursor_afisare number;
begin

   cursor_afisare := dbms_sql.open_cursor;

   dbms_sql.parse(cursor_afisare, 'select username, isputuros, numar_intrebari, intrebari_relevante, numar_raporturi, raporturi_gresite from u' 
   || id_user, dbms_sql.native);

   dbms_sql.define_column(cursor_afisare, 1, username, 200);
   dbms_sql.define_column(cursor_afisare, 2, puturos);
   dbms_sql.define_column(cursor_afisare, 3, nr_intrebari);
   dbms_sql.define_column(cursor_afisare, 4, intrebari_relevante);
   dbms_sql.define_column(cursor_afisare, 5, numar_raporturi);
   dbms_sql.define_column(cursor_afisare, 6, raporturi_gresite);
   
   ignore1 := dbms_sql.execute(cursor_afisare);
   
   loop
       if(dbms_sql.fetch_rows(cursor_afisare)> 0) then
       
           dbms_sql.column_value(cursor_afisare, 1, username);
           dbms_sql.column_value(cursor_afisare, 2, puturos);
           dbms_sql.column_value(cursor_afisare, 3, nr_intrebari);
           dbms_sql.column_value(cursor_afisare, 4, intrebari_relevante);
           dbms_sql.column_value(cursor_afisare, 5, numar_raporturi);
           dbms_sql.column_value(cursor_afisare, 6, raporturi_gresite);
           dbms_output.put_line(username || ' '||puturos|| ' '|| nr_intrebari || ' ' || intrebari_relevante 
           || ' ' ||numar_raporturi || ' ' || raporturi_gresite);
       else 
          exit;
       end if;
   end loop;
  commit;
  dbms_sql.close_cursor(cursor_afisare);

end;

/ 

set serveroutput on;
begin

AfisareDate(62);

end;
/