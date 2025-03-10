-- 1
create table musica(
cod_musica number constraint pk_musica primary key,
nome_musica varchar2(30),
dt_lancamento date,
valor number(5,2)
);

-- 2
alter table musica add duracao char(8);

-- 3
alter table musica modify nome_musica constraint nn_nome_musica not null;

-- 4
insert into musica values
(1, 'Eduardo e Mônico', '01-06-1986', 10.00, '00:09:24');

-- 5
update musica set nome_musica = 'Eduardo e Maria'
where lower(nome_musica) = 'eduardo e mônico';

-- 6
delete from musica where to_char(dt_lancamento, 'DD/MM/YYYY') = '01/06/1986';

-- 7
drop table musica;


-- 8
select login_usuario from usuario us
left join conexao cx on (us.cod_usuario = cx.cod_usuario)
group by login_usuario
having count(cod_cnx) = (select max(count(cod_cnx)) from conexao
                        group by cod_usuario);

-- 9
select * from usuario;
select * from conexao;
select * from comandos;

select cx.cod_cnx from conexao cx
left join comandos cm on (cx.cod_cnx = cm.cod_cnx)
group by cx.cod_cnx
having count(cod_cmd) = (select min(count(cod_cmd)) from comandos
                        group by cod_cnx);

-- 10
select login_usuario from usuario us
left join conexao cx on (us.cod_usuario = cx.cod_usuario)
group by login_usuario
having count(cod_cnx) = (select min(count(cod_cnx)) from conexao
                        group by cod_usuario);

-- 11
select * from

-- 12


select * from musica;