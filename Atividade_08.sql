SET SERVEROUTPUT ON;

-- 1
create or replace procedure pr_faturamento_filial
as
cursor cr_filial is select nome_filial, cod_filial from tb_filial;
cursor cr_venda is select cod_filial, valor_total from tb_venda;
soma number(10,2) := 0;
begin
    for x in cr_filial loop
        for y in cr_venda loop
            if x.cod_filial = y.cod_filial
                then soma := soma + y.valor_total;
            end if;
        end loop;
        dbms_output.put_line(x.nome_filial||' - R$'||soma);
        soma := 0;
    end loop;
end;
/

call pr_faturamento_filial();

select nome_filial, cod_filial from tb_filial;
select cod_filial, valor_total from tb_venda;


-- 2
create or replace procedure pr_filial_maior
as
cursor cr_filial is select nome_filial, cod_filial from tb_filial;
cursor cr_venda is select cod_filial, valor_total from tb_venda;
soma number(10,2) := 0;
ctrl number(10,2) := 0;
filial varchar2(100);
begin
    for x in cr_filial loop
        for y in cr_venda loop
            if x.cod_filial = y.cod_filial
                then soma := soma + y.valor_total;
            end if;
        end loop;
        if soma > ctrl
            then ctrl := soma;
            filial := x.nome_filial;
        end if;
        soma := 0;
    end loop;
    dbms_output.put_line(filial||' - R$'||ctrl);
end;
/

call pr_filial_maior();

select nome_filial, cod_filial from tb_filial;
select cod_filial, valor_total from tb_venda;


-- 3
create or replace procedure pr_filial_mes(mes number, filial varchar2)
as
cursor cr_filial is select dt_venda, sum(valor_total) total from tb_filial
                join tb_venda using(cod_filial)
                where lower(nome_filial) = 'filial a'
                group by dt_venda order by dt_venda;
begin
    for x in cr_filial loop
        if to_char(x.dt_venda, 'MM') = mes
            then dbms_output.put_line(x.dt_venda||' - R$'||x.total);
        end if;
    end loop;
end;
/

call pr_filial_mes('03', 'filial a');

select dt_venda, sum(valor_total) from tb_filial
join tb_venda using(cod_filial)
where lower(nome_filial) = 'filial a'
group by dt_venda;


-- 5
create or replace procedure pr_qde_mes(mes number)
as
cursor cr_estado is select nome_estado, cod_estado from tb_estado;
cursor cr_venda is select cod_estado, nome_filial, dt_venda from tb_estado
                join tb_filial using(cod_estado)
                join tb_venda using(cod_filial);
ctrl number(10) := 0;
total number(10) := 0;
begin
    for x in cr_estado loop
        for y in cr_venda loop
            if mes = to_char(y.dt_venda, 'MM') and x.cod_estado = y.cod_estado
                then ctrl := ctrl + 1;
                total := total + 1;
            end if;
        end loop;
        dbms_output.put_line(x.nome_estado||' - '||ctrl);
        ctrl := 0;
    end loop;
    dbms_output.put_line('');
    dbms_output.put_line('Total Geral - '||total);
end;
/

call pr_qde_mes('03');

select nome_estado, cod_estado from tb_estado;

select nome_estado, nome_filial, dt_venda from tb_estado
join tb_filial using(cod_estado)
join tb_venda using(cod_filial);


-- 6



select * from tb_venda;
select * from tb_filial;
select * from tb_estado;