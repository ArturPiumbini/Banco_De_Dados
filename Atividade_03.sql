SET SERVEROUTPUT ON;

-- 3) Crie a função fn_maior_divisor que receba dois números como parâmetro e então retorne o maior divisor comum entre eles.

create or replace function fn_maior_divisor(n1 number, n2 number)
return number 
as
r number;
a number;
b number;
begin
    a := n1;
    b := n2;
    while mod(a, b) > 0 loop
        r := mod(a, b);
        a := b;
        b := r;
    end loop;
    return(b); 
end;
/

clear screen;
select fn_maior_divisor(168956480, 884626160) from dual;

-- 7 - Faça a procedure que receba um número inteiro e positivo, e então indique se ele é um número perfeito
create or replace procedure pr_num_perfeito(n1 number)
as
total number;
begin
    for x in 1 .. n1-1 loop
        if mod(n1, x) = 0
            then total := total + x;
        end if;
    end loop;
    if total = n1
        then dbms_output.put_line(n1 || ' é perfeito');
    else dbms_output.put_line(n1 || ' não é perfeito');
    end if;
end;
/

clear screen;
call pr_num_perfeito(28);