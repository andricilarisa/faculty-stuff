set serveroutput on;

create or replace package functionsPack is
 function revelance_question(questionId questions.id%type) return int;
 function revelance_user(user_name users.username%type) return int;
 function lazy_one (userId users.id%type)
 end functionsPack;
 /
 
 create or replace package body functionsPack is
 
 function lazy_one(userId users.id%type)
 return int as
 total_questions int;
 total_answers int;
 begin
 total_questions:=0;
 total_answers:=0;
 
 select count(*) into total_answers from answers where user_id =userId and solved=1;
 select count(*) into total_questions from answers where user_id=userId;
 if total_answers < total_questions/2 then
 return 1;
 else
 return 0;
 end if;
 end lazy_one;
 
 function revelance_question(questionId questions.id%type)
 return int as
 total_asked int;
 total_answers int;
 procent30 int:=0;
 procent90 int:=0;
 begin
 total_asked:=0;
 total_answers:=0;
 
 select asked into total_asked from questions where id = questionId;
 if(total_asked < 20) then
 return 0;
 end if;
 
 procent30:=total_asked*0.3;
 procent90:=total_asked*0.9;
 
 for linie in (select * from answers where question_id = questionId and solved=1) loop
 if lazy_one(linie.user_id)=0 then
 total_answers := total_answers + 1;
 end if;
 end loop;
 
 if(total_answers < procent30 or total_answers > procent90) then
 return 0;
 end if;
 return total_asked;
 end revelance_question;
 
 
function revelance_user(user_name users.username%type)
 return int AS
 userId int;
 question_id int;
 r_maxim int;
 actual_r int;
 begin
 r_maxim:=0;
  select id into userId from users where username=user_name;
  for line1 in (select * from questions where user_id = userId) loop
    if line1.user_id = userId then
      actual_r := revelance_question(line1.id);
       if(r_maxim < actual_r) then
          r_maxim:= actual_r;
       end if;
    end if;
 end loop;
return r_maxim;
end;
end functionsPack;
/
 
 