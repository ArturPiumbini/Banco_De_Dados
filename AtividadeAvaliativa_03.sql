SET SERVEROUTPUT ON;

-- 1
create or replace procedure pr_pfquestao1
as
cursor cr_clientes is select nome_cliente, cod_cliente from tb_cliente;
cursor cr_pedidos is select cod_cliente, cod_comanda, valor_produto, qde_produto from tb_comanda
                    join tb_lista_produto using(cod_comanda);
soma number(10,2);
begin
    for x in cr_clientes loop
        soma := 0;
        for y in cr_pedidos loop
            if x.cod_cliente = y.cod_cliente then
                soma := soma+(y.valor_produto * y.qde_produto);
            end if;
        end loop;
        dbms_output.put_line(x.nome_cliente||' - R$'||soma);
    end loop;
end;
/

call pr_pfquestao1();

select * from tb_cliente;
select * from tb_comanda;
select * from tb_lista_produto;
select cod_cliente, cod_comanda, valor_produto, qde_produto from tb_comanda
join tb_lista_produto using(cod_comanda);


-- 2
create or replace procedure pr_pfquestao2(p_cliente varchar2)
as
cursor cr_comanda is select cod_comanda, cod_cliente, data_comanda, nome_garcom from tb_comanda
                    join tb_garcom using(cod_garcom) order by cod_comanda;
cursor cr_pedidos is select cod_comanda, nome_produto, valor_produto, qde_produto from tb_lista_produto
                    join tb_produto using(cod_produto) order by cod_comanda;
v_cod_cliente number;
begin
    select cod_cliente into v_cod_cliente from tb_cliente where lower(nome_cliente) = lower(p_cliente);
    for x in cr_comanda loop
        if v_cod_cliente = x.cod_cliente then
            dbms_output.put_line('COMANDA: '||x.cod_comanda);
            dbms_output.put_line('DATA: '||x.data_comanda);
            dbms_output.put_line('GARÇOM: '||x.nome_garcom);
            dbms_output.put_line('PEDIDOS: ');
            for y in cr_pedidos loop
                if x.cod_comanda = y.cod_comanda then
                    dbms_output.put_line('      NOME: '||y.nome_produto);
                    dbms_output.put_line('      VALOR: R$'||y.valor_produto||'    QUANTIDADE: '||y.qde_produto);
                    dbms_output.put_line('');
                end if;
            end loop;
            dbms_output.put_line('');
        end if;
    end loop;
end;
/

call pr_pfquestao2('Robin');

select nome_cliente, cod_cliente from tb_cliente where nome_cliente = 'Robin';
select * from tb_comanda;
select * from tb_lista_produto;
select * from tb_produto;
select * from tb_garcom;
select cod_comanda, data_comanda, cod_cliente, nome_garcom from tb_comanda
join tb_garcom using(cod_garcom) order by cod_comanda;

select cod_comanda, nome_produto, valor_produto, qde_produto from tb_lista_produto
join tb_produto using(cod_produto) order by cod_comanda;


-- 3
create or replace procedure pr_pfquestao3(mes_ano varchar2)
as
cursor cr_garcom is select nome_garcom, cod_garcom from tb_garcom;
cursor cr_pedidos is select cod_garcom, cod_comanda, data_comanda, valor_produto, qde_produto from tb_comanda
                    join tb_lista_produto using(cod_comanda);
soma number(10,2);
begin
    for x in cr_garcom loop
        soma := 0;
        for y in cr_pedidos loop
            if x.cod_garcom = y.cod_garcom and mes_ano = to_char(y.data_comanda, 'MM/YYYY') then
                soma := soma+(y.valor_produto * y.qde_produto);
            end if;
        end loop;
        dbms_output.put_line(x.nome_garcom||' - R$'||soma*0.1);
    end loop;
end;
/

call pr_pfquestao3('03/2015');

select * from tb_comanda;
select * from tb_lista_produto;
select * from tb_garcom;
select cod_garcom, cod_comanda, data_comanda, valor_produto, qde_produto from tb_comanda
join tb_lista_produto using(cod_comanda);


-- 4
select * from gilberto.arquivo;

create table financiamento 
(cod_financiamento number primary key,
valor_financimento number,
saldo_devedor number);

create table pagamento
(cod_pagamento number,
data_pagamento date,
valor_pagamento number,
cod_financiamento number);

insert into financiamento values (1, 1000, 1000);
insert into financiamento values (2, 1200, 1200);
insert into financiamento values (3, 1300, 1300);

create or replace trigger tg_questao4
before insert
on pagamento
referencing new as new
for each row
declare
v_cod_pagamento number;
v_saldo_devedor number(10,2);
begin
    select count(cod_pagamento) into v_cod_pagamento
    from pagamento where to_char(data_pagamento, 'MM/YYYY') = to_char(:new.data_pagamento, 'MM/YYYY');
    
    select saldo_devedor into v_saldo_devedor
    from financiamento where cod_financiamento = :new.cod_financiamento;
    
    if v_cod_pagamento > 0 then
        raise_application_error(-20001, 'Já foi realizado um pagamento esse mes '||to_char(:new.data_pagamento, 'MM/YYYY'));
    elsif :new.valor_pagamento > v_saldo_devedor then
        raise_application_error(-20002, 'Pagamento maior que o saldo devedor! Saldo restante: R$'||v_saldo_devedor);
    else
        update financiamento
        set saldo_devedor = (v_saldo_devedor - :new.valor_pagamento)
        where cod_financiamento = :new.cod_financiamento;
    end if;
end;
/

insert into pagamento values (1, sysdate, 100, 1);
insert into pagamento values (2, '10/12/2024', 100, 1);
insert into pagamento values (3, '10/08/2024', 1000, 1);
insert into pagamento values (4, '10/09/2024', 800, 1);

select * from financiamento;
select * from pagamento;

select * from pagamento where to_char(data_pagamento, 'MM/YYYY') = '05/2024';

select saldo_devedor from financiamento where cod_financiamento = 2;

update financiamento
    set saldo_devedor = 1100
    where cod_financiamento = 2;