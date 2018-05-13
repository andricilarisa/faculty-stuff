declare
    v_count NUMBER := 0;
    v_nr_nume NUMBER;
    v_temp1 NUMBER := 0;
    v_temp2 NUMBER := 0;
    v_nume varchar2(255);
    v_prenume varchar2(255);
    v_telefon NUMBER := 0;
    v_email varchar2(255);
begin
    select count (name) into v_nr_nume from USERS;
    loop
        v_temp1 := trunc(dbms_random.value(1, v_nr_nume));
        v_temp2 := trunc(dbms_random.value(1, v_nr_nume));
        select name into v_nume from users where id = v_temp1;
        select name into v_prenume from users where id = v_temp2;
        v_email := v_nume|| '@info.uaic.ro';
        insert into useri(id,name,prenume,email) values 
            (v_count+1, v_nume,v_prenume,v_email);
        v_count := v_count + 1;
        exit when v_count = 15;
    end loop;
end;