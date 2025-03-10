--35.Qual foi o primeiro (menor data de cadastro) hospital a ser cadastrado?
select nome_hospital from hospital
where data_registro = (select min(data_registro) from hospital);

--36.Quantos hospitais existem por bairros?
select nome_bairro, count(cod_hospital) from bairro b
left join hospital h on (b.cod_bairro = h.cod_bairro)
group by nome_bairro;

--37.Quantos médicos existem por especialidade?
select nome_especialidade, count(distinct cod_medico) from especialidade e
left join servico s on (e.cod_especialidade = s.cod_especialidade)
group by nome_especialidade;

--38.Quantas especialidades existem por plano de saúde?
select nome_plano, count(distinct cod_especialidade) from plano_saude p
left join servico s on (p.cod_plano = s.cod_plano)
group by nome_plano;

--39.Quantos médicos existem por especilidade no Hospital de Base?
select nome_especialidade, count(distinct cod_medico) from especialidade e
left join servico s on (e.cod_especialidade = s.cod_especialidade)
left join hospital h on (s.cod_hospital = h.cod_hospital)
where lower(nome_hospital) = 'hospital de base'
group by nome_especialidade;

--40.Quantos médicos atendem por plano de saúde?
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

--42.Qual plano de saúde tem maior número de médicos vinculados?
--43.Qual hospital atende a menor quantidade de especialidades?
--44.Qual bairro tem maior número de hospitais?
--45.Qual médico está vinculado a menor número de hospitais?
--46.Qual plano de saúde está vinculado ao maior número de hospitais?
--47.Qual hospital tem menor número de pediatras?
--48.Qual bairro tem quantidade de hospitais acima da média de hospitais por bairro?
--49.Qual especialidade tem o maior número de médicos?
--50.Qual pediatra do Hospital Santa Casa atende ao maior número de planos de saúde?
--51.Qual a especialidade com menor número de profissionais no bairro Betânia?
--52.Qual especialidade está presente no menor número de hospitais?
--53.Quantos médicos existem por plano de saúde atendendo no 'Hospital de Base'?
--54.Qual plano de saúde tem maior número de médicos atendendo no 'Hospital de Base'?
--55.Qual hospital tem maior número de especialidades disponíveis para o SUS?
--56.Qual especialidade tem o maior número de médicos que atendem consultas particulares?
--57.Em qual ano teve o maior número de registros de hospitais?
--58.Em qual hospital o Dr. Paulo de Ortopedia atende ao menor número de planos de saúde?
--59.Qual plano de saúde tem o maior número de cardiologistas?
--60.No Hospital de Base qual especialidade tem o maior número de profissionais?