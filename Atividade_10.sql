SET SERVEROUTPUT ON;
-- 1
-- A)
create table venda(
cod_venda number,
data_venda date,
cod_filme number,
assento number,
cod_tipo_ingresso number,
valor_cobrado number(5,2));

create table filme(
cod_filme number,
nome_filme varchar2(50),
valor_ingresso number(5,2),
total_ingressos number);

create table tipo_ingresso(
cod_tipo number,
nome_tipo varchar2(50),
descricao varchar2(100),
percentual number(5,2));

-- B)
create sequence sq_venda;

create or replace trigger tg_pk_venda
before insert
on venda
referencing new as new
for each row
begin
    :new.cod_venda := sq_venda.nextval;
end;
/

create sequence sq_filme;

create or replace trigger tg_pk_filme
before insert
on filme
referencing new as new
for each row
begin
    :new.cod_filme := sq_filme.nextval;
end;
/

create sequence sq_tipo_ingresso;

create or replace trigger tg_pk_tipo_ingresso
before insert
on tipo_ingresso
referencing new as new
for each row
begin
    :new.cod_tipo := sq_tipo_ingresso.nextval;
end;
/

-- C)
insert into filme (nome_filme, valor_ingresso, total_ingressos) values
('Mogli', 12, 10);
insert into filme (nome_filme, valor_ingresso, total_ingressos) values
('Star War', 30, 15);
insert into filme (nome_filme, valor_ingresso, total_ingressos) values
('Zootopia', 25, 5);
insert into filme (nome_filme, valor_ingresso, total_ingressos) values
('Luna', 20, 10);
insert into filme (nome_filme, valor_ingresso, total_ingressos) values
('Peixonauta', 20, 12);
insert into tipo_ingresso (nome_tipo, descricao, percentual) values
('Inteira', 'o valor cobrado será de 100% do valor do ingresso', 100);
insert into tipo_ingresso (nome_tipo, descricao, percentual) values (
'Meiaentrada','o valor cobrado será de 50% do valor do ingresso', 50);
insert into tipo_ingresso (nome_tipo, descricao, percentual) values (
'3aIdade', 'o valor cobrado será de 80% do valor do ingresso', 80);
insert into tipo_ingresso (nome_tipo, descricao, percentual) values
('Professor', 'o valor cobrado será de 120% do valor do ingresso', 120);

select * from venda;
select * from filme;
select * from tipo_ingresso;
delete from tipo_ingresso;

-- D)
create or replace trigger tg_percent
before insert
on venda
referencing new as new
for each row
declare
tipo number;
valor number(5,2);
begin
    -- Pega o percentual de desconto
    select percentual into tipo
    from tipo_ingresso
    where cod_tipo = :new.cod_tipo_ingresso;
    
     -- Pega o valor do ingresso
    select valor_ingresso into valor
    from filme
    where cod_filme = :new.cod_filme;
    
    :new.valor_cobrado := valor * (tipo/100);
end;
/

insert into venda (data_venda, cod_filme, assento, cod_tipo_ingresso) values
(sysdate, 1, 10, 10);
select * from venda;
delete from venda;

-- E)
create or replace trigger tg_ingresso
before insert
on venda
referencing new as new
for each row
declare
total number;
qtd number;
tipo number;
begin
    
    select total_ingressos into total
    from filme
    where cod_filme = :new.cod_filme;
    
    select count(cod_tipo) into tipo
    from tipo_ingresso
    where lower(nome_tipo) = 'meiaentrada';
    
    select count(cod_venda) into qtd
    from venda
    join 
    where cod_tipo_ingresso = ;
    
    if tipo = 1
        then 
            if qtd >= (total*0,3)
                then raise_application_error(-20001, 'Limite de meia entrada atingido');
            end if;
    end if;
end;
/
insert into venda (data_venda, cod_filme, assento, cod_tipo_ingresso) values
(sysdate, 1, 10, 22);
select * from venda;
delete from venda;

select count(cod_venda) from venda
join tipo_ingresso on(cod_tipo = cod_tipo_ingresso)
where nome_tipo = 'meiaentrada';



