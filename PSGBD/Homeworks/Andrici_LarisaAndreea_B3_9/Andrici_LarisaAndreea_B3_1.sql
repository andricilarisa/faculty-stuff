--ex 1
set serveroutput on;

select id from users where username= 'larisa.andrici';
select count(id) from questions where user_id = 353;

select count(*) as numar, us.id from reports re join users us on us.id = re.user_id where us.user_role <> 'admin'
group by us.id order by 1 desc ;
/

create or replace procedure Top10Rautaciosi (id_user in number) as

    cursor_lenesi number;
    nume_tabela varchar (50);
    nume_user varchar(100);
    IsPuturos integer;
    numar_intrebari integer;
    intrebari_relevante integer;
    numar_raporturi integer;
    raporturi_gresite integer;
    de_executat varchar(2000);
    de_executat2 varchar(2000);
    procesate integer;

begin

    nume_tabela := 'u' || id_user;
    select username into nume_user from users where id = id_user;
    select count(*) into numar_intrebari from questions where user_id = id_user;
    select count(*) into numar_raporturi from reports where user_id = id_user;
    
    select count(*) into raporturi_gresite from reports r join questions q on 
    r.question_id = q.id where q.user_id = id_user and q.report_resolved = 1;
    
    select count(r.question_id) into raporturi_gresite
    from reports r join users u on r.user_id = u.id 
    where r.question_id in (select id from questions where report_resolved = 1 and r.user_id = id_user);
    
    
    IsPuturos := FUNCTIONSPACK.lazy_one(id_user);
    
    for i in (select id from questions where user_id = id_user)
    loop
    if(FUNCTIONSPACK.REVELANCE_QUESTION(i.id) != 0) then
    intrebari_relevante := intrebari_relevante + 1;
    end if;
    end loop;
    
    cursor_lenesi := dbms_sql.open_cursor;
    
    de_executat := 'create table ' || nume_tabela || '(username varchar2(50), 
    IsPuturos number, numar_intrebari number, intrebari_relevante number, 
    numar_raporturi number, raporturi_gresite number)';
    
    de_executat2 := 'insert into ' || nume_tabela || ' values (:user_name, :IsPuturos,
    :nr_intrebari, :intrebari_relevante, :numar_raporturi, :raporturi_gresite )' ;
    
    dbms_sql.parse(cursor_lenesi, de_executat, dbms_sql.native);
    procesate := dbms_sql.execute(cursor_lenesi);
    
    dbms_sql.close_cursor(cursor_lenesi);
    cursor_lenesi := dbms_sql.open_cursor;
    dbms_sql.parse(cursor_lenesi, de_executat2, dbms_sql.native);

    dbms_sql.bind_variable(cursor_lenesi, ':user_name', nume_user);
    dbms_sql.bind_variable(cursor_lenesi, ':IsPuturos', IsPuturos);
    dbms_sql.bind_variable(cursor_lenesi, ':nr_intrebari', numar_intrebari);
    dbms_sql.bind_variable(cursor_lenesi, ':intrebari_relevante', intrebari_relevante);
    dbms_sql.bind_variable(cursor_lenesi, ':numar_raporturi', numar_raporturi);
    dbms_sql.bind_variable(cursor_lenesi, ':raporturi_gresite', raporturi_gresite);
    
    procesate := dbms_sql.execute(cursor_lenesi);
    
    exception
    when others then
    dbms_sql.close_cursor(cursor_lenesi);
    raise;
end;
/

declare
cursor rautaciosi is select * from(select count(*) as numar, us.id from reports re join users us on us.id = re.user_id where us.user_role <> 'admin'
group by us.id order by 1 desc) where rownum <=10;
begin

for indice in rautaciosi
loop
Top10Rautaciosi(indice.id);
end loop;
end;


create or replace procedure DropTop10Rautaciosi (id_user in number) as

    cursor_lenesi number;
    nume_tabela varchar (50);
    nume_user varchar(100);
    IsPuturos integer;
    numar_intrebari integer;
    intrebari_relevante integer;
    numar_raporturi integer;
    raporturi_gresite integer;
    de_executat varchar(2000);
    de_executat2 varchar(2000);
    procesate integer;

begin

    nume_tabela := 'u' || id_user;
    
    
    
    for i in (select id from questions where user_id = id_user)
    loop
    if(FUNCTIONSPACK.REVELANCE_QUESTION(i.id) != 0) then
    intrebari_relevante := intrebari_relevante + 1;
    end if;
    end loop;
    
    cursor_lenesi := dbms_sql.open_cursor;
    
    de_executat := 'drop table ' || nume_tabela;
    
    
    dbms_sql.parse(cursor_lenesi, de_executat, dbms_sql.native);
    procesate := dbms_sql.execute(cursor_lenesi);
    
    dbms_sql.close_cursor(cursor_lenesi);
    
    
    exception
    when others then
    dbms_sql.close_cursor(cursor_lenesi);
    raise;
end;
/

declare
cursor rautaciosi is select * from(select count(*) as numar, us.id from reports re join users us on us.id = re.user_id where us.user_role <> 'admin'
group by us.id order by 1 desc) where rownum <=10;
begin

for indice in rautaciosi
loop
DropTop10Rautaciosi(indice.id);
end loop;
end;