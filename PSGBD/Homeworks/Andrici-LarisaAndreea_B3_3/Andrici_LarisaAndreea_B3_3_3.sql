--exercitiul 3
DROP TABLE zodii;
CREATE TABLE zodii(name varchar2(50), start_date date,end_date date,id number(20)); 

insert into zodii (name, start_date, end_date,id) values ('Berbec',date '1997-03-21',date '1997-04-20','1');
insert into zodii (name, start_date, end_date,id) values ('Taur',date '1997-04-21',date '1997-05-21','2');
insert into zodii (name, start_date, end_date,id) values ('Gemeni',date '1997-05-22',date '1997-06-21','3');
insert into zodii (name, start_date, end_date,id) values ('Rac',date '1997-06-22',date '1997-07-22','4');
insert into zodii (name, start_date, end_date,id) values ('Leu',date '1997-07-23',date '1997-08-22','5');
insert into zodii (name, start_date, end_date,id) values ('Fecioara',date '1997-08-23',date '1997-09-21','6');
insert into zodii (name, start_date, end_date,id) values ('Balanta',date '1997-09-22',date '1997-10-22','7');
insert into zodii (name, start_date, end_date,id) values ('Scorpion',date '1997-10-23',date '1997-11-21','8');
insert into zodii (name, start_date, end_date,id) values ('Sagetator',date '1997-11-22',date '1997-12-21','9');
insert into zodii (name, start_date, end_date,id) values ('Capricorn',date '1997-12-22',date '1997-01-19','10');
insert into zodii (name, start_date, end_date,id) values ('Varsator',date '1997-01-20',date '1997-02-18','11');
insert into zodii (name, start_date, end_date,id) values ('Pesti',date '1997-02-19',date '1997-03-20','12');

select * from tema2;

declare
v_index number:=51;
v_count number:=500;
zodie_nume varchar(30);
u_nume varchar2(30);
u_prenume varchar(30);
v_final varchar (200);
u_born date;
begin
loop
select nume into u_nume from tema2 where id=v_index;
select prenume into u_prenume from tema2 where id=v_index;
select data_nastere into u_born from tema2 where id=v_index;

select name into zodie_nume from zodii 
where (extract(month from u_born)= extract(month from start_date) and extract(day from u_born) >= extract( day from start_date))
and
( extract(month from u_born) = extract(month from end_date) and extract(day from u_born) <= extract(day from end_date));

v_final:= u_nume || ' '|| u_prenume || ' '|| zodie_nume;
sys.dbms_output.put_line(v_final);

v_index:= v_index+1;
exit when v_index = v_count;
end loop;
end;