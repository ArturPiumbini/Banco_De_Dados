--35.Qual foi o primeiro (menor data de cadastro) hospital a ser cadastrado?
select nome_hospital from hospital
where data_registro = (select min(data_registro) from hospital);

--36.Quantos hospitais existem por bairros?
select nome_bairro, count(cod_hospital) from bairro b
left join hospital h on (b.cod_bairro = h.cod_bairro)
group by nome_bairro;

--37.Quantos m�dicos existem por especialidade?
select nome_especialidade, count(distinct cod_medico) from especialidade e
left join servico s on (e.cod_especialidade = s.cod_especialidade)
group by nome_especialidade;

--38.Quantas especialidades existem por plano de sa�de?
select nome_plano, count(distinct cod_especialidade) from plano_saude p
left join servico s on (p.cod_plano = s.cod_plano)
group by nome_plano;

--39.Quantos m�dicos existem por especilidade no Hospital de Base?
select nome_especialidade, count(distinct cod_medico) from especialidade e
left join servico s on (e.cod_especialidade = s.cod_especialidade)
left join hospital h on (s.cod_hospital = h.cod_hospital)
where lower(nome_hospital) = 'hospital de base'
group by nome_especialidade;

--40.Quantos m�dicos atendem por plano de sa�de?
select nome_plano, count(distinct cod_medico) from plano_saude p
left join servico s on (p.cod_plano = s.cod_plano)
group by nome_plano;

--41.Qual a quantidade de pediatras por bairros?
select nome_bairro, count(distinct cod_medico) from bairro b
left join hospital h on (b.cod_bairro = h.cod_bairro)
left join servico s on(h.cod_hospital = s.cod_hospital)
left join especialidade e on (s.cod_especialidade = e.cod_especialidade)
--where lower(nome_especialidade) = 'pediatria'
group by nome_bairro;
select count(distinct cod_medico) from servico;

select * from bairro;

select nome_especialidade, count(distinct s.cod_medico) from servico s
left join especialidade e on (s.cod_especialidade = e.cod_especialidade)
group by nome_especialidade;

--42.Qual plano de sa�de tem maior n�mero de m�dicos vinculados?
--43.Qual hospital atende a menor quantidade de especialidades?
--44.Qual bairro tem maior n�mero de hospitais?
--45.Qual m�dico est� vinculado a menor n�mero de hospitais?
--46.Qual plano de sa�de est� vinculado ao maior n�mero de hospitais?
--47.Qual hospital tem menor n�mero de pediatras?
--48.Qual bairro tem quantidade de hospitais acima da m�dia de hospitais por bairro?
--49.Qual especialidade tem o maior n�mero de m�dicos?
--50.Qual pediatra do Hospital Santa Casa atende ao maior n�mero de planos de sa�de?
--51.Qual a especialidade com menor n�mero de profissionais no bairro Bet�nia?
--52.Qual especialidade est� presente no menor n�mero de hospitais?
--53.Quantos m�dicos existem por plano de sa�de atendendo no 'Hospital de Base'?
--54.Qual plano de sa�de tem maior n�mero de m�dicos atendendo no 'Hospital de Base'?
--55.Qual hospital tem maior n�mero de especialidades dispon�veis para o SUS?
--56.Qual especialidade tem o maior n�mero de m�dicos que atendem consultas particulares?
--57.Em qual ano teve o maior n�mero de registros de hospitais?
--58.Em qual hospital o Dr. Paulo de Ortopedia atende ao menor n�mero de planos de sa�de?
--59.Qual plano de sa�de tem o maior n�mero de cardiologistas?
--60.No Hospital de Base qual especialidade tem o maior n�mero de profissionais?