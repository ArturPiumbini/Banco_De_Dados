-- 1
create table curso(
cod_curso number(3) constraint pk_curso primary key,
nome_curso varchar2(30)
);

create table aluno(
cod_aluno number(3) constraint pk_aluno primary key,
nome_aluno varchar2(30),
telefone_aluno varchar2(12),
cod_curso number(3) constraint fk_curso_aluno references curso(cod_curso)
);

-- 2
alter table aluno modify telefone_aluno char(12);

-- 3
alter table aluno drop column telefone_aluno;

-- 4 Letra c)

-- 5 Letra a)

-- 6 Letra d)

-- 7
select to_char(data_compra, 'DD/MM/YYYY') from compra_prova_a
where valor_compra = (select max(valor_compra)
                        from compra_prova_a);

-- 8
select nome_produto, sum(qde_produto) from produto_prova_a p
left join lista_compra_prova_a l on(p.cod_produto = l.cod_produto)
group by nome_produto;

-- 9
select distinct nome_cliente from cliente_prova_a cl
left join compra_prova_a cp on(cl.cod_cliente = cp.cod_cliente)
where valor_compra > (select avg(valor_compra)
                        from compra_prova_a);

-- 10
select to_char(data_compra, 'DD/MM/YYYY')
from compra_prova_a
group by to_char(data_compra, 'DD/MM/YYYY')
having count(distinct cod_cliente) = (select max(count(distinct cod_cliente))
                        from compra_prova_a
                        group by to_char(data_compra, 'DD/MM/YYYY'));

-- 11
select nome_produto from produto_prova_a pr
left join lista_compra_prova_a ls on(pr.cod_produto = ls.cod_produto)
left join compra_prova_a cp on(ls.cod_compra = cp.cod_compra)
left join cliente_prova_a cl on(cp.cod_cliente = cl.cod_cliente)
where upper(nome_cliente) = 'TICO'
group by nome_produto
having sum(qde_produto) = (select max(sum(qde_produto)) from produto_prova_a pr
                        left join lista_compra_prova_a ls on(pr.cod_produto = ls.cod_produto)
                        left join compra_prova_a cp on(ls.cod_compra = cp.cod_compra)
                        left join cliente_prova_a cl on(cp.cod_cliente = cl.cod_cliente)
                        where upper(nome_cliente) = 'TICO'
                        group by nome_produto);

-- 12 Letra d)