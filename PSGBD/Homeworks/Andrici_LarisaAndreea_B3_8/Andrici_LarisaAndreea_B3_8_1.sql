--ex 1


drop  type  Angajat force;
CREATE OR REPLACE TYPE Angajat AS OBJECT ( 
  angNumar INTEGER,
  angNume VARCHAR(20),
  departament varchar(30),
  salariu integer,
  Constructor function Angajat (angNume varchar) return self as result,
  member procedure DisplayAng,
  not final member procedure SetProp,
  map member function CompareObj return integer,
  member procedure SchimbaSal (sal integer),
  member procedure SchimbaSal (ang Angajat) 
) not final;
/

CREATE OR REPLACE TYPE BODY Angajat AS 
    
    Constructor function Angajat (angNume varchar) return self as result as
    begin
    self.angNumar :=1;
    self.angNume := angNume;
    self.departament := 'Dep1';
    self.salariu := 123;
    return;
    end;
    
    member procedure DisplayAng  as
    begin
    dbms_output.put_line(self.angNumar || ' '|| self.angNume || ' ' || self.departament || ' '|| self.salariu);
    end;
    
    member procedure SetProp as
    begin
    self.angNumar := 3;
    self.angNume := 'Mariuca';
    self.departament := 'Soft';
    self.salariu := 20;
    end;
    
    --ex 2
    map member function CompareObj  return integer as
    begin
    return self.salariu;
    end;
    
   member procedure SchimbaSal ( sal integer) as 
   begin
   self.salariu := sal;
   end;
  
  member procedure SchimbaSal (ang Angajat) as
  begin
  self.salariu := ang.salariu;
  end;
    
END;
/



-- ex 3
CREATE OR REPLACE TYPE Manager1 under Angajat (
  nrAng INTEGER,
  CONSTRUCTOR FUNCTION Manager1 RETURN SELF AS RESULT,
  Constructor function Manager1(aNumar integer, aNume varchar, aDep varchar, aSalariu integer) return self as result,
  overriding member procedure SetProp
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY Manager1 AS 
  Constructor function Manager1 return self as result as
    BEGIN
      RETURN;
    END;
    
  Constructor function Manager1(aNumar integer, aNume varchar, aDep varchar, aSalariu integer) return self as result as
  begin
  self.angNumar :=aNumar;
  self.angNume := aNume;
  self.departament := aDep;
  self.salariu := aSalariu;
  return;
  end;
  
  overriding member procedure SetProp as
  begin
  self.angNumar := 3;
  self.angNume := 'Mariuca';
  self.departament := 'Soft';
  self.salariu := 20;
  self.nrAng := 5;
  end;
  
END;
/


--testare 


create table Angajati (nr integer, obiect angajat);

set serveroutput on;
 
declare

ang1 Angajat;
ang2 Angajat;
begin

ang1 := Angajat('Maria');
ang2 :=Angajat('1','Ionel','Soft', '234');
ang1.DisplayAng();
ang2.SetProp();
ang2.DisplayAng();
if (ang1 > ang2) then
 dbms_output.put_line(ang1.angNume || ' are salariul mai mare');
 else 
  dbms_output.put_line(ang2.angNume || ' are salariul mai mare');
end if;
ang1.SchimbaSal(234);
ang2.SchimbaSal(ang1);

dbms_output.put_line(ang1.salariu);
dbms_output.put_line(ang2.salariu);

end;



