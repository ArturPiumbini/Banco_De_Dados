SET SERVEROUTPUT ON;

-- 1
create or replace procedure pr_aniversario
as
cursor cr_nasc_dependente is select nome_dependente, dt_nascimento from dependente;
cursor cr_mes is select distinct to_char(dt_nascimento, 'MM') mes, to_char(dt_nascimento, 'Month') nome from dependente order by to_char(dt_nascimento, 'MM');
begin
    for x in cr_mes loop
        dbms_output.put_line(x.nome);
        for y in cr_nasc_dependente loop
            if x.mes = to_char(y.dt_nascimento, 'MM')
                then dbms_output.put_line(to_char(y.dt_nascimento, 'MM/YY')||' '||y.nome_dependente);
            end if;
        end loop;
        dbms_output.put_line('');
    end loop;
end;
/

call pr_aniversario();


-- 2
create or replace procedure pr_pagamento
as
cursor cr_setor is select distinct nome_setor, cod_setor from setor order by nome_setor; 
cursor cr_empregado is select cod_setor, nome_empregado, salario from setor
            join empregado using(cod_setor);
total number(20,2) := 0;
begin
    for x in cr_setor loop
        for y in cr_empregado loop
            if x.cod_setor = y.cod_setor
                then total := total+y.salario;
            end if;
        end loop;
        dbms_output.put_line(x.nome_setor||': R$'||total);
        total := 0;
    end loop;
end;
/

call pr_pagamento();


-- 3
create or replace procedure pr_lista_dep
as
cursor cr_dependente is select nome_dependente, cod_empregado from dependente;
cursor cr_empregado is select distinct nome_empregado, cod_empregado from empregado
    join dependente using(cod_empregado) order by nome_empregado;
begin
    for x in cr_empregado loop
        dbms_output.put_line(x.nome_empregado);
        for y in cr_dependente loop
            if x.cod_empregado = y.cod_empregado
                then dbms_output.put_line('     '||y.nome_dependente);
            end if;
        end loop;
        dbms_output.put_line('');
    end loop;
end;
/

call pr_lista_dep();

select * from empregado;
select * from dependente;
select distinct nome_empregado from empregado
join dependente using(cod_empregado) order by nome_empregado;

