select nome_medico, to_char(data_nascimento, 'YYYY')
from medico_si
where to_char(data_nascimento, 'YYYY') < '1980';

select count(*)
from consulta_si
where to_char(data_hora_consulta, 'D') = '1';

select count(*), to_char(data_hora_consulta, 'D')
from consulta_si
group by to_char(data_hora_consulta, 'D')
order by to_char(data_hora_consulta, 'D');

select count(cod_consulta)
from consulta_si
where to_char(data_hora_consulta, 'HH24') between '12' and '18';

--21
select distinct nome_exame
from exame_si e
join lista_exame_si l on(e.cod_exame = l.cod_exame)
join consulta_si c on(l.cod_consulta = c.cod_consulta)
join paciente_si p on(c.cod_paciente = p.cod_paciente)
where lower(nome_paciente) = 'alípio'
and to_char(data_hora_consulta, 'DDMMYYYY') = '07092016';

--22
select distinct nome_paciente
from paciente_si p
join consulta_si c on(p.cod_paciente = c.cod_paciente)
join medico_si m on(c.cod_medico = m.cod_medico)
where lower(nome_medico) = 'pato donald'
and lower(nome_medico) = 'betty rubble';


--23
select distinct nome_paciente
from paciente_si p
join consulta_si c on(p.cod_paciente = c.cod_paciente)
join medico_si m on(c.cod_medico = m.cod_medico)
where lower(nome_medico) = 'pato donald'
or lower(nome_medico) = 'betty rubble';

--24
select nome_medico from medico_si
where tel_medico like '31%';

--25
select nome_paciente from paciente_si
where lower(nome_paciente) like 'ch%';

--26
select nome_paciente from paciente_si
where lower(nome_paciente) like '%n_a';

--27
select nome_paciente from paciente_si
where lower(nome_paciente) like '% ju%';

--28
select nome_paciente from paciente_si
where lower(nome_paciente) like '____' and lower(nome_paciente) like '%ol%';

--29
select nome_paciente from paciente_si
where cod_plano is null;

--30
select p.nome_paciente titular, c.nome_paciente dependente from paciente_si p
join paciente_si c on(p.cod_paciente = c.cod_titular)
where lower(p.nome_paciente) = 'kiko';