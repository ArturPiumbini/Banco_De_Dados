--1
select nome_reu from reu_2016
where data_nascimento = (select min(data_nascimento) from reu_2016);

--2
select nome_reu from reu_2016 r
join acusacao_2016 a on (r.cod_reu = a.cod_reu)
where pena_anos = (select max(pena_anos) from acusacao_2016);

--3
select max(data_acusacao) from acusacao_2016;

--4
select * from acusacao_2016;
select * from artigo_2016;
select nome_artigo from artigo_2016
where cod_artigo not in (select cod_artigo from acusacao_2016);

--5
--SE CULPADO
select distinct ar.nome_artigo from artigo_2016 ar
join acusacao_2016 ac on (ar.cod_artigo = ac.cod_artigo)
where pena_anos = (select min(pena_anos) from acusacao_2016 where resultado = 'C')
and resultado = 'C';

--SE NÃO NECESSARIAMENTE CULPADO
select distinct ar.nome_artigo from artigo_2016 ar
join acusacao_2016 ac on (ar.cod_artigo = ac.cod_artigo)
where pena_anos = (select min(pena_anos) from acusacao_2016);

--6
select distinct nome_reu from reu_2016 r
join acusacao_2016 a on (r.cod_reu = a.cod_reu)
where pena_anos > (select avg(pena_anos) from acusacao_2016);

--7
select max(pena_anos) from
(select pena_anos from acusacao_2016 a
join reu_2016 r on (a.cod_reu = r.cod_reu)
where data_nascimento = (select min(data_nascimento) from reu_2016));

--ou

select nome_reu, data_nascimento, pena_anos from reu_2016 r
join acusacao_2016 a on (r.cod_reu = a.cod_reu)
where data_nascimento = (select min(data_nascimento) from reu_2016)
and pena_anos = (select max(pena_anos) from
(select pena_anos from acusacao_2016 a
join reu_2016 r on (a.cod_reu = r.cod_reu)
where data_nascimento = (select min(data_nascimento) from reu_2016)));


--1
select * from estado;
select * from funcionario;
select nome_estado from estado
where cod_estado not in (select cod_estado from funcionario);

--2
select * from departamento;
select distinct nome_departamento from departamento d
join funcionario f on (d.cod_departamento = f.cod_departamento)
where idade = (select min(idade) from funcionario);

--3
select nome_estado from estado e
join funcionario f on (e.cod_estado = f.cod_estado)
where idade = (select min(idade) from funcionario);