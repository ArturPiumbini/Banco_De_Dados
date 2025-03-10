SET SERVEROUTPUT ON;

-- Lista 2

-- 1
create or replace procedure pr_acumula
as
cursor cr_nome_prato is select distinct nome_prato from avaliacao;
cursor cr_nota_prato is select nome_prato, nota from avaliacao;
sum_nota number;
begin
    for x in cr_nome_prato loop
    sum_nota := 0;
        for y in cr_nota_prato loop
            if x.nome_prato = y.nome_prato
                then sum_nota := sum_nota + y.nota;
            end if;
        end loop;
        dbms_output.put_line(x.nome_prato||' - '||sum_nota);
    end loop;
end;
/

call pr_acumula();

select nome_prato, sum(nota) from avaliacao
group by nome_prato;

-- Lista 3

-- 1
create or replace procedure pr_folha(data varchar2)
as
cursor cr_funcionario is select cod_vendedor, nome_vendedor, salario_vendedor from vendedor_lista3;
cursor cr_venda is select valor_venda, cod_vendedor, valor_produto from venda_lista3
                join produto_lista3 using(cod_produto)
                where to_char(data_venda, 'MM/YYYY') = data;
sum_comissao number(10,2);
begin
    dbms_output.put_line('Mês: '||data);
    for x in cr_funcionario loop
        sum_comissao := 0;
        for y in cr_venda loop
            if x.cod_vendedor = y.cod_vendedor
                then sum_comissao := sum_comissao + (0.3*(y.valor_venda - y.valor_produto));
            end if;
        end loop;
        dbms_output.put_line('');
        dbms_output.put_line('Funcionario: '||x.nome_vendedor);
        dbms_output.put_line('Salário: R$'||x.salario_vendedor);
        dbms_output.put_line('Comissão: R$'||sum_comissao);
        dbms_output.put_line('Total: R$'||(x.salario_vendedor + sum_comissao));
        sum_comissao := 0;
    end loop;
end;
/

call pr_folha('03/2016');

select * from vendedor_lista3;
select * from venda_lista3;
select * from produto_lista3;

select valor_venda, cod_vendedor, valor_produto from venda_lista3
join produto_lista3 using(cod_produto)
where to_char(data_venda, 'MM/YYYY') = '03/2016';






