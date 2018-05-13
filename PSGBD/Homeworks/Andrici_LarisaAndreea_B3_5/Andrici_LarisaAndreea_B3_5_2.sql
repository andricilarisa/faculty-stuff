set serveroutput on;

drop index id1;
create index id1 on answers(user_id, solved);

declare
question_id int;
r_max int;
actual_r int;
u_name USERS.NAME%type;

begin
r_max :=0;
for line in (select * from questions ) loop
actual_r := functionsPack.revelance_question(line.id);

dbms_output.put_line('Intrebarea cu id-ul: ' || line.id || ' are ca si relevanta '|| actual_r );

if line.user_id !=2 and line.user_id!=1 and line.user_id!=4 and line.user_id!=247
then
if actual_r > r_max then
r_max:=actual_r;
question_id:=line.id;

select name into u_name from users where id = line.user_id;
end if;
end if;
end loop;
dbms_output.put_line('Intrebarea cu cea mai mare relevanta este pusa de '|| u_name || ' si are relevanta egala cu: '||r_max);
end;