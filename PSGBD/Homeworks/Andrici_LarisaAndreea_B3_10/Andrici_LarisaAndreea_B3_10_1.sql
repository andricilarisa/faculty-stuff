select namespace, EDITION_NAME, OBJECT_ID, OBJECT_NAME, OBJECT_TYPE, SUBOBJECT_NAME, DATA_OBJECT_ID, CREATED, LAST_DDL_TIME, TIMESTAMP, status from user_objects;
select object_name from user_objects;
select object_name from user_objects where OBJECT_NAME like '%USER%';
select object_name from user_objects where object_type='TABLE';

--rezolvare ex 1
set serveroutput on;

DECLARE
var1 varchar(200);
var2 varchar(200);
cursor cursor_1 is select object_name, OBJECT_TYPE from user_objects where 
object_type = 'TRIGGER' or object_type = 'TABLE' or object_type= 'FUNCTION' 
or object_type='VIEW' or object_type= 'PROCEDURE';

begin
open cursor_1;
loop 
fetch cursor_1 into var1, var2;
  exit when cursor_1%notfound;
  dbms_output.put_line(var1 || ' ' || var2);
  end loop;

close cursor_1;
end;