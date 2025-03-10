-- 1 a) Qual comando mostra o sexo com maior número de karatecas?
select sexo from karateca
group by sexo
having count(cod_karateca) = (select max(count(cod_karateca)) from karateca
                            group by sexo);
                            
-- b) Qual comando mostra a faixa com menor número de praticantes?
select nome_faixa from faixa f
left join karateca k on(f.cod_faixa = k.cod_faixa)
group by nome_faixa
having count(cod_karateca) = (select min(count(cod_karateca)) from faixa f
                            left join karateca k on(f.cod_faixa = k.cod_faixa)
                            group by nome_faixa);

-- c) Qual comando mostra o nome da academia com o menor número de praticantes?
select nome_academia from academia a
left join karateca k on(a.cod_academia = k.cod_academia)
group by nome_academia
having count(cod_karateca) = (select min(count(cod_karateca)) from academia a
                            left join karateca k on(a.cod_academia = k.cod_academia)
                            group by nome_academia);

-- d) Qual comando mostra a faixa com menor incidência para o sexo feminino (F)?
select nome_faixa from faixa f
left join karateca k on(f.cod_faixa = k.cod_faixa)
where lower(sexo) = 'f'
group by nome_faixa
having count(cod_karateca) = (select min(count(cod_karateca)) from faixa f
                            left join karateca k on(f.cod_faixa = k.cod_faixa)
                            where lower(sexo) = 'f'
                            group by nome_faixa);

-- e) Qual comando mostra o ano em que nasceu a maior quantidade de karatecas?
select to_char(data_nascimento, 'YYYY'), count(cod_karateca) from karateca
group by to_char(data_nascimento, 'YYYY')
having count(cod_karateca) = (select max(count(cod_karateca)) from karateca
                            group by to_char(data_nascimento, 'YYYY'));

--2


-- 3
-- letra D)dez

-- 4 a) Qual comando mostra o login do usuário com maior quantidade de conexões?
select login_usuario from usuario us
left join conexao cx on (us.cod_usuario = cx.cod_usuario)
group by login_usuario
having count(cod_cnx) = (select max(count(cod_cnx)) from conexao
                        group by cod_usuario);

-- b) Qual comando mostra o dia em que ocorreu o menor número de conexões?
select to_char(data_cnx, 'DD/MM/YYYY') from conexao
group by to_char(data_cnx, 'DD/MM/YYYY')
having count(cod_cnx) = (select min(count(cod_cnx))from conexao
                        group by to_char(data_cnx, 'DD/MM/YYYY'));

