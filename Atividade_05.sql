-- 1
-- a) Quais tarefas distintas a funcionária Charlene Silvassauro executou novembro?
select distinct nome_tarefa from tarefa t
join atendimento a on(t.cod_tarefa = a.cod_tarefa)
join funcionario f on(a.cod_funcionario = f.cod_funcionario)
where lower(nome_funcionario) = 'charlene silvassauro'
and to_char(data_atendimento, 'MM') = '11';

-- b) A tarefa ‘Coletar sangue’ já foi realizada quantas vezes?
select count(cod_atendimento) from atendimento a
join tarefa t on(a.cod_tarefa = t.cod_tarefa)
where lower(nome_tarefa) = 'coletar sangue';

-- c) Qual(is) funcionário(s) realizaram a tarefa ‘Medicar’ e não realizaram a tarefa ‘Consultar Paciente’?
select distinct nome_funcionario from funcionario f
join atendimento a on(f.cod_funcionario = a.cod_funcionario)
join tarefa t on(a.cod_tarefa = t.cod_tarefa)
where lower(nome_tarefa) = 'medicar'
and a.cod_funcionario not in (select distinct cod_funcionario from atendimento a
join tarefa t on(a.cod_tarefa = t.cod_tarefa)
where lower(nome_tarefa) = 'consultar paciente');

-- d) Qual(is) paciente(s) tem a letra ‘u’ e ‘o’ no nome?
select nome_paciente from paciente
where lower(nome_paciente) like '%u%'
and lower(nome_paciente) like '%o%';

-- e) Qual(is) enfermeiro(s) tem a letra ‘P’ MAIÚSCULA no nome?
select nome_funcionario from funcionario f
join departamento d on(f.cod_departamento = d.cod_departamento)
where nome_funcionario like '%P%'
and lower(nome_departamento) = 'enfermagem';

-- f) Qual(is) funcionários(s) realizaram tarefas no dia 02/10/2010 e NÃO realizaram no dia 03/10/2010?
select distinct nome_funcionario from funcionario f
join atendimento a on(f.cod_funcionario = a.cod_funcionario)
where to_char(data_atendimento, 'DD/MM/YYYY') = '02/10/2010'
and cod_tarefa is not null
and nome_funcionario not in(select distinct nome_funcionario from funcionario f
join atendimento a on(f.cod_funcionario = a.cod_funcionario)
and cod_tarefa is not null
where to_char(data_atendimento, 'DD/MM/YYYY') = '03/10/2010');
select * from atendimento;

-- g) Qual(is) funcionário(s) atendeu(ram) EXCLUSIVAMENTE a paciente ‘Chiquinha’?
select distinct nome_funcionario from funcionario f
join atendimento a on(f.cod_funcionario = a.cod_funcionario)
join paciente p on(a.cod_paciente = p.cod_paciente)
where lower(nome_paciente) = 'chiquinha'
and a.cod_funcionario not in(select distinct cod_funcionario from atendimento a
join paciente t on(a.cod_paciente = t.cod_paciente)
where lower(nome_paciente) <> 'chiquinha');

-- h) Quais pacientes passaram pelas tarefas Coletar Urina , mas NÃO passaram pela tarefa Coletar Sangue?
select distinct nome_paciente from paciente p
join atendimento a on(p.cod_paciente = a.cod_paciente)
join tarefa t on(a.cod_tarefa = t.cod_tarefa)
where lower(nome_tarefa) = 'coletar urina'
and a.cod_paciente not in (select distinct cod_paciente from atendimento a
join tarefa t on(a.cod_tarefa = t.cod_tarefa)
where lower(nome_tarefa) = 'coletar sangue');

-- i) Quantos pacientes distintos fizeram o procedimento ‘Realizar Ultrassom’?
select count(distinct cod_paciente) from  atendimento a
join tarefa t on(a.cod_tarefa = t.cod_tarefa)
where lower(nome_tarefa) = 'realizar ultrassom';

-- j) Quantos pacientes NUNCA passou por atendimentos?
select count(cod_paciente) from paciente p
where cod_paciente not in (select distinct cod_paciente from atendimento);


-- 2 - letra e)

-- 3 - letra e)