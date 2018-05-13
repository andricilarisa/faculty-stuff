--select object_name from user_objects where object_type='VIEW';

declare
cursor_general number;
nume varchar(200);
de_executat varchar(1000);
prod number;
cursor dropTable is select object_name from user_objects where object_type = 'TABLE';
cursor dropView is select object_name from user_objects where object_type='VIEW';
cursor dropProd is select object_name from user_objects where object_type= 'PROCEDURE';
cursor dropFunct is select object_name from user_objects where object_type= 'FUNCTION';
cursor dropTrig is select object_name from user_objects where object_type = 'TRIGGER';

begin

for indice in dropTable
loop
execute immediate 
 
 'drop table ' || indice.object_name ;
 
end loop;

for indice in dropProd
loop
execute immediate 
 
 'drop procedure ' || indice.object_name ;
 
end loop;

for indice in dropFunct
loop
execute immediate 
 
 'drop function ' || indice.object_name ;
 
end loop;

for indice in dropTrig
loop
execute immediate 
 
 'drop trigger ' || indice.object_name ;
 
end loop;

for indice in dropView
loop 
execute immediate 
 
 'drop view ' || indice.object_name ;
 
end loop;
end; 
