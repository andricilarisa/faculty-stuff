--exercitiul 1--
set serveroutput on;

declare

    TYPE line IS TABLE OF NUMBER INDEX BY pls_INTEGER;
    TYPE Matrix IS TABLE OF line INDEX BY pls_INTEGER;
    
    matrix1 Matrix;
    matrix2 Matrix;
    matrix_final Matrix;
    
    line_m1 number:=0;
    comun_val number:=0;
    column_m2 number:=0;
    index1 number:=0;
    index2 number:=0;
    index3 number:=0;
    
    begin
    --generare random a dimensunilor
    line_m1 := trunc(dbms_random.value(2,5));
    comun_val := trunc(dbms_random.value(2,5));
    column_m2 :=  trunc(dbms_random.value(2,5));

  SYS.DBMS_OUTPUT.PUT_LINE('Dimensiunea matricilor'||line_m1 || ' ' ||comun_val||' '||column_m2);
    
    --inserarea valorilor in matrici
    for index1 in 1..line_m1 loop
       for index2 in 1..comun_val loop
      --select trunc(dbms_random.value(1,31)) num into matrix1(index1)(index2) from dual;
       matrix1(index1)(index2) := trunc(dbms_random.value(1,31));
       end loop;
    end loop;
    
        for index1 in 1..comun_val loop
       for index2 in 1..column_m2 loop
    --  select trunc(dbms_random.value(1,31)) num into matrix2(index1)(index2) from dual;
      matrix2(index1)(index2) := trunc(dbms_random.value(1,31));
       end loop;
    end loop;
   
   --inmultire matrici
   for index1 in 1.. line_m1 loop
      for index2 in 1..column_m2 loop
      matrix_final(index1)(index2) :=0;
         for index3 in 1..comun_val loop
            matrix_final(index1)(index2) :=  matrix_final(index1)(index2) + matrix1(index1)(index3) * matrix2(index3)(index2);
         end loop;
      end loop;
   end loop;
    
    
    --afisare matrici
     SYS.DBMS_OUTPUT.PUT_LINE('Matrix 1');
    
      for index1 in 1.. line_m1 loop 
      for index2 in 1.. comun_val loop
       SYS.DBMS_OUTPUT.PUT(LPAD(to_char(matrix1(index1)(index2)),3)||' ');
      end loop;
     SYS.DBMS_OUTPUT.new_line;
   end loop;
    
     SYS.DBMS_OUTPUT.new_line;
    
    SYS.DBMS_OUTPUT.PUT_LINE('Matrix 2');
    
      for index1 in 1.. comun_val loop 
      for index2 in 1.. column_m2 loop
       SYS.DBMS_OUTPUT.PUT(LPAD(to_char(matrix2(index1)(index2)),3)||' ');
      end loop;
     SYS.DBMS_OUTPUT.new_line;
   end loop;
    
     SYS.DBMS_OUTPUT.new_line;
     SYS.DBMS_OUTPUT.PUT_LINE('Matrix Final');
    
    for index1 in 1.. line_m1 loop 
      for index2 in 1.. column_m2 loop
       SYS.DBMS_OUTPUT.PUT(LPAD(to_char(matrix_final(index1)(index2)),3)||' ');
      end loop;
     SYS.DBMS_OUTPUT.new_line;
   end loop;
   
   end;
