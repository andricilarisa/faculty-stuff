-- ex 4

create or replace procedure CopiazaTabela (tabelaInitiala varchar, tabelaNoua varchar ) is

begin

execute immediate

'create table ' || tabelaNoua || ' as select * from ' || tabelaInitiala;

end;


begin

CopiazaTabela('users', 'usersc');
 
end;