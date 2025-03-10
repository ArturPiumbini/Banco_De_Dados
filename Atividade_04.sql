--1 � Quais m�dicos solicitaram o exame mais caro?
select nome_medico from tb_medico m
join tb_consulta c on(m.cod_medico = c.cod_medico)
join tb_lista_exame l on(c.cod_consulta = l.cod_consulta)
join tb_exame e on(l.cod_exame = e.cod_exame)
where valor_exame = (select max(valor_exame) from tb_exame);
-- ou
select nome_medico
from tb_medico m, tb_consulta c, tb_lista_exame l, tb_exame e
where m.cod_medico = c.cod_medico
and c.cod_consulta = l.cod_consulta
and l.cod_exame = e.cod_exame
and valor_exame = (select max(valor_exame) from tb_exame);
--2 � Para quais clientes foram solicitados os exames mais caros?
select nome_paciente from tb_paciente p
join tb_consulta c on(p.cod_paciente = c.cod_paciente)
join tb_lista_exame l on(c.cod_consulta = l.cod_consulta)
join tb_exame e on(l.cod_exame = e.cod_exame)
where valor_exame = (select max(valor_exame) from tb_exame);
-- ou
select nome_paciente
from tb_paciente p, tb_consulta c, tb_lista_exame l, tb_exame e
where p.cod_paciente = c.cod_paciente
and c.cod_consulta = l.cod_consulta
and l.cod_exame = e.cod_exame
and valor_exame = (select max(valor_exame) from tb_exame);
--3 � Qual a m�dia de pre�o dos exames?
select round(avg(valor_exame),2) from tb_exame;
--4 � Quantos exames s�o mais caros do que a m�dia?
select count(cod_exame) from tb_exame
where valor_exame > (select avg(valor_exame) from tb_exame);
--5 � Qual o n�mero de consultas por cliente?
select nome_paciente, count(cod_consulta) from tb_consulta c
join tb_paciente p on(c.cod_paciente = p.cod_paciente)
group by nome_paciente
order by nome_paciente;
--6 � Qual o n�mero de consultas por m�dico?
select nome_medico, count(cod_consulta) from tb_consulta c
join tb_medico m on(c.cod_medico = m.cod_medico)
group by nome_medico
order by nome_medico;
--7 � Quais m�dicos atenderam no primeiro dia ?
select nome_medico from tb_medico m
join tb_consulta c on(m.cod_medico = c.cod_medico)
where data_consulta = (select min(data_consulta) from tb_consulta);
--8 � Qual a m�dia de consulta por m�dico?

--9 � Quais consultas o m�dico mais novo de casa realizou?
--10 � Quais m�dicos atendem o paciente mais velho?
--11 � Qual o �ltimo exame solicitado?
--12 � Para qual paciente foi solicitado o �ltimo exame?