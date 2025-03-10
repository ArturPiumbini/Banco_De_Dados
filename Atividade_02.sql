-- 1 - Liste todos os setores da empresa.
select nome_setor from setor;

-- 2 - Quais s�o os funcion�rios da empresa?
select nome_empregado from empregado;

-- 3 - Liste todos os dados dos dependentes.
select * from dependente;

-- 4 - De quais tipos os dependentes podem ser?
select nome_tipo from tipo;

-- 5 - Quais os setores de produ��o da empresa?
select nome_setor from setor where upper(nome_setor) like '%PRODU��O%';

-- 6 - Liste apenas o nome e a data de nascimento dos dependentes.
select nome_dependente, dt_nascimento from dependente;

-- 7 - Refa�a o exerc�cio anterior ordenando do mais novo para o mais velho.
select nome_dependente, dt_nascimento from dependente order by dt_nascimento;

-- 8 - Qual o dependente de c�digo 5?
select nome_dependente from dependente where cod_dependente = 5;

-- 9 - Quais os dependentes do 'Homer Simpson'?
select nome_dependente from dependente
inner join empregado using(cod_empregado)
where lower(nome_empregado) = 'homer simpson';

-- 10 - De quem o 'Zez� P�ra' � dependente?
select nome_empregado from empregado 
inner join dependente using(cod_empregado) 
where lower(nome_dependente) = 'zez� p�ra';

-- 11 - Quais dependentes t�m o nome come�ado pela letra 'M'?
select nome_dependente from dependente where lower(nome_dependente) like 'm%';

-- 12 - Quais os funcion�rios tem o nome terminado por 'son'?
select nome_empregado from empregado where lower(nome_empregado) like '%son';

-- 13 - Quais funcion�rios N�O t�m o nome iniciado por 'Pat'?
select nome_empregado from empregado
where cod_empregado not in (select cod_empregado from empregado where nome_empregado like 'Pat%');



select distinct nome_setor, nome_tipo from setor 
join empregado using(cod_setor)
join dependente using(cod_empregado)
join tipo using(cod_tipo)
where lower(nome_tipo) = 'agregado';