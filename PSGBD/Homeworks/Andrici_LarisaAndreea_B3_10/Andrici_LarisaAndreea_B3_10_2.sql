CREATE OR REPLACE DIRECTORY DIR_CREATE AS 'C:\Users\adria\Desktop\';

declare
random_fisier utl_file.file_type;

CURSOR c1 IS 
    select dbms_metadata.GET_DDL(object_type,object_name)
    from  USER_OBJECTS 
    WHERE OBJECT_TYPE IN ('INSERT','TABLE','FUNCTION','PROCEDURE','VIEW', 'TRIGGER')
    ORDER BY OBJECT_TYPE;

stat clob;

begin
open c1;


random_fisier:= utl_file.fopen ('DIR_CREATE', 'export.sql', 'w', 32767);
loop
fetch c1 into stat;
exit when c1%notfound;
utl_file.put_line(random_fisier,stat);
end loop;

close c1;
utl_file.fclose(random_fisier);

end;