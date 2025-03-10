-- 1
create table usuario
(cod_usuario integer constraint pk_usuario primary key,
nome_usuario varchar(50)constraint un_nome_usuario unique,
saldo number(5,2)
);

create table compra
(cod_compra integer constraint pk_compra primary key,
data_compra date,
valor_compra number(5,2),
cod_professor integer constraint fk_usuario_compra references usuario(cod_usuario)
);

-- 2
-- a)
select nome_programador from programador pr
join lista_acao la on(pr.cod_programador = la.cod_programador)
join acao ac on (la.cod_acao = ac.cod_acao)
where lower(nome_acao) = 'liberação'
group by nome_programador, nome_acao
having count(cod_lista_acao) = (select max(count(cod_lista_acao)) from programador pr
                                join lista_acao la on(pr.cod_programador = la.cod_programador)
                                join acao ac on (la.cod_acao = ac.cod_acao)
                                where lower(nome_acao) = 'liberação'
                                group by nome_programador, nome_acao);

-- b)
select nome_ambiente, count(cod_lista_acao) from ambiente ab
left join lista_acao la on(ab.cod_ambiente = la.cod_ambiente)
group by nome_ambiente;

-- c)
select nome_programador from programador pr
join lista_acao la on(pr.cod_programador = la.cod_programador)
join ambiente ab on(la.cod_ambiente = ab.cod_ambiente)
where lower(nome_ambiente) = 'produção'
group by nome_programador, nome_ambiente
having count(cod_lista_acao) = (select min(count(cod_lista_acao)) from programador pr
                                join lista_acao la on(pr.cod_programador = la.cod_programador)
                                join ambiente ab on(la.cod_ambiente = ab.cod_ambiente)
                                where lower(nome_ambiente) = 'produção'
                                group by nome_programador, nome_ambiente);

-- d)
select nome_programador from programador pr
join lista_acao la on(pr.cod_programador = la.cod_programador)
where to_char(data_lista_acao, 'YYYY') = '2018'
group by nome_programador, to_char(data_lista_acao, 'YYYY')
having count(cod_lista_acao) = (select min(count(cod_lista_acao)) from programador pr
                                join lista_acao la on(pr.cod_programador = la.cod_programador)
                                where to_char(data_lista_acao, 'YYYY') = '2018'
                                group by nome_programador, to_char(data_lista_acao, 'YYYY'));

-- e)
select to_char(data_lista_acao, 'MM/YYYY'), count(cod_lista_acao) from lista_acao
group by to_char(data_lista_acao, 'MM/YYYY');

-- f)
select nome_programador, count(distinct cod_acao)from programador pr
left join lista_acao la on(pr.cod_programador = la.cod_programador)
group by nome_programador;

-- g)
select nome_acao from acao ac
join lista_acao la on(ac.cod_acao = la.cod_acao)
join ambiente ab on(la.cod_ambiente = ab.cod_ambiente)
where lower(nome_ambiente) = 'homologação'
group by nome_acao, nome_ambiente
having count(cod_lista_acao) = (select max(count(cod_lista_acao)) from acao ac
                                join lista_acao la on(ac.cod_acao = la.cod_acao)
                                join ambiente ab on(la.cod_ambiente = ab.cod_ambiente)
                                where lower(nome_ambiente) = 'homologação'
                                group by nome_acao, nome_ambiente);

-- h)
select nome_programador, count(cod_lista_acao) from programador pr
left join lista_acao la on(pr.cod_programador = la.cod_programador)
group by nome_programador;

-- i)
select nome_acao from acao ac
join lista_acao la on(ac.cod_acao = la.cod_acao)
where to_char(data_lista_acao, 'YYYY') = '2017'
group by nome_acao, to_char(data_lista_acao, 'YYYY')
having count(cod_lista_acao) = (select max(count(cod_lista_acao)) from acao ac
                                join lista_acao la on(ac.cod_acao = la.cod_acao)
                                where to_char(data_lista_acao, 'YYYY') = '2017'
                                group by nome_acao, to_char(data_lista_acao, 'YYYY'));

-- j)
select nome_acao from acao ac
join lista_acao la on(ac.cod_acao = la.cod_acao)
join programador pr on(la.cod_programador = pr.cod_programador)
where lower(nome_programador) = 'seya'
group by nome_acao, nome_programador
having count(cod_lista_acao) = (select max(count(cod_lista_acao)) from acao ac
                                join lista_acao la on(ac.cod_acao = la.cod_acao)
                                join programador pr on(la.cod_programador = pr.cod_programador)
                                where lower(nome_programador) = 'seya'
                                group by nome_acao, nome_programador);

-- 3 letra a)

-- 4 letra a)