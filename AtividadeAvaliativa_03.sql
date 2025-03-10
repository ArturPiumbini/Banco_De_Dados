-- 1
-- a)
select distinct nome_programador from programador pr
join lista_acao la on(pr.cod_programador = la.cod_programador)
join acao ac on(la.cod_acao = ac.cod_acao)
where upper(nome_acao) = 'LIBERAÇÃO'
and pr.cod_programador not in (select cod_programador from lista_acao la
                                join acao ac on(la.cod_acao = ac.cod_acao)
                                where upper(nome_acao) = 'TRANSFERÊNCIA');

-- b)
select nome_acao, count(distinct cod_programador) from acao ac
left join lista_acao la on(ac.cod_acao = la.cod_acao)
group by nome_acao;

-- c)
select nome_programador from programador pr --left join?
join lista_acao la on(pr.cod_programador = la.cod_programador)
join acao ac on(la.cod_acao = ac.cod_acao)
where upper(nome_acao) = 'MIGRAÇÃO HML'
group by nome_programador
having count(la.cod_programador) = (select min(count(cod_programador)) from lista_acao la
                                    join acao ac on(la.cod_acao = ac.cod_acao)
                                    where upper(nome_acao) = 'MIGRAÇÃO HML'
                                    group by cod_programador);

-- d)
select nome_acao from acao ac
join lista_acao la on(ac.cod_acao = la.cod_acao)
join ambiente am on(la.cod_ambiente = am.cod_ambiente)
where upper(nome_ambiente) = 'HOMOLOGAÇÃO'
group by nome_acao
having count(la.cod_acao) = (select max(count(cod_acao)) from lista_acao la
                            join ambiente am on(la.cod_ambiente = am.cod_ambiente)
                            where upper(nome_ambiente) = 'HOMOLOGAÇÃO'
                            group by cod_acao);
                            
-- e)
select to_char(data_lista_acao, 'MM'), count(cod_lista_acao) from lista_acao
group by to_char(data_lista_acao, 'MM');

-- f)
select to_char(data_lista_acao, 'D'), count(cod_lista_acao) from lista_acao
group by to_char(data_lista_acao, 'D')
having count(cod_lista_acao) = (select max(count(cod_lista_acao)) from lista_acao
                                group by to_char(data_lista_acao, 'D'));

-- g)
select distinct nome_programador from programador pr
join lista_acao la on(pr.cod_programador = la.cod_programador)
where to_char(data_lista_acao, 'D') = '2'
and pr.cod_programador not in (select cod_programador from lista_acao la
                                where to_char(data_lista_acao, 'D') = '7');

-- 2 Letra: d)

-- 3 Letra: d)

-- 4
-- a)
select to_char(data_mov, 'DD/MM/YYYY'), sum(valor) from movimentacao
group by to_char(data_mov, 'DD/MM/YYYY');

-- b)
select distinct nome_tipo_mov from tipo_movimento tm
join movimentacao mv on(tm.cod_tipo_mov = mv.cod_tipo_mov)
where to_char(data_mov, 'D') = '3'
and tm.cod_tipo_mov not in(select cod_tipo_mov from movimentacao
                        where to_char(data_mov, 'D') = '2');

-- c)
select distinct nome_tipo_mov from tipo_movimento tm
join movimentacao mv on(tm.cod_tipo_mov = mv.cod_tipo_mov)
where to_char(data_mov, 'HH24') < '12';

-- d)
select nome_cliente from cliente_banco cb
left join conta ct on(cb.cod_cliente = ct.cod_cliente)
group by nome_cliente
having count(ct.cod_cliente) = (select min(count(ct.cod_cliente)) from cliente_banco cb
                                left join conta ct on(cb.cod_cliente = ct.cod_cliente)
                                group by nome_cliente);

-- e)
select distinct nome_cliente from cliente_banco cb
join conta ct on(cb.cod_cliente = ct.cod_cliente)
join movimentacao mv on(ct.cod_conta = mv.cod_conta)
join tipo_movimento tm on(mv.cod_tipo_mov = tm.cod_tipo_mov)
where upper(nome_tipo_mov) = 'TED'
and cb.cod_cliente not in(select distinct cod_cliente from conta ct
                        join movimentacao mv on(ct.cod_conta = mv.cod_conta)
                        join tipo_movimento tm on(mv.cod_tipo_mov = tm.cod_tipo_mov)
                        where upper(nome_tipo_mov) = 'PAGAMENTO DE BOLETO');

-- f)
select nome_tipo_conta from tipo_conta tp
join conta ct on(tp.cod_tipo_conta = ct.cod_tipo_conta)
group by nome_tipo_conta
having sum(saldo) = (select max(sum(saldo)) from tipo_conta tp
                    join conta ct on(tp.cod_tipo_conta = ct.cod_tipo_conta)
                    group by nome_tipo_conta);

-- 5 Letra: d)

-- 6
-- a)
create table professor
(cod_professor number(3) constraint pk_professor primary key,
nome_professor varchar2(30));

create table prova
(cod_prova number(3) constraint pk_prova primary key,
data_prova date,
valor_prova number(4,2),
cod_professor number(3) constraint fk_professor_prova references professor(cod_professor));

-- b)
alter table professor modify nome_professor varchar2(30) constraint un_local unique;