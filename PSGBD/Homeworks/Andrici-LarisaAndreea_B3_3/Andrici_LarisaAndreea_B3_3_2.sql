--exercitiul 2

--exercitiu 2
declare 
  cursor c1 is
  select user_id , id
   from questions where reported>=5 and updated_at > to_date('15-JAN-2017');

  cursor c2 is
  select u.name as nume, count(*) as nr_intrebari
  from users u join questions q on q.id = q.user_id 
  where q.reported>=5 and q.updated_at > date '17-01-15' group by u.name;
begin
  for c1_record in c1 loop
    update questions set report_resolved =2;
    end loop;
    
  for c2_record in c2 loop
  
  dbms_output.put_line(c2_record.nume || ' '||c2_record.nr_intrebari);
end loop;
end;
