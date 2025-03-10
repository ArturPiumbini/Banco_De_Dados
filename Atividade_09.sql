create table livro(
cod_livro number(3) constraint pk_livro primary key,
nome_livro varchar2(50)
);

create table usuario(
cod_usuario number(3) constraint pk_usuario primary key,
nome_usuario varchar2(50)
);

create table emprestimo(
cod_emprestimo number(3) constraint pk_emprestimo primary key,
data_emprestimo date,
cod_usuario number(3) constraint fk_usuario_emprestimo references usuario(cod_usuario)
);

create table lista_livros(
cod_emprestimo number(3) constraint fk_emprestimo_listaemprestimo references emprestimo(cod_emprestimo),
cod_livro number(3) constraint fk_livro_listaemprestimo references livro(cod_livro),
data_devolucao date,
constraint pk_lista_emprestimo primary key(cod_emprestimo, cod_livro)
);

select * from livro;
select * from usuario;
select * from emprestimo;
select * from lista_livros;

insert into livro values (1 , 'Iracema');
insert into livro values (2 , 'A Moreninha');
insert into livro values (3 , 'O Ateneu');
insert into livro values (4 , 'O Guarani');
insert into livro values (5 , 'Eu');
insert into livro values (6 , 'O Pagador de Promessas');
insert into livro values (7 , 'O Tempo e o Vento');
insert into livro values (8 , 'Os Sertões');
insert into livro values (9 , 'Canaâ');
insert into livro values (10 , 'O Quinze');

insert into usuario values (1 , 'Pooh');
insert into usuario values (2 , 'Tigrão');
insert into usuario values (3 , 'Leitão');
insert into usuario values (4 , 'Abel');
insert into usuario values (5 , 'Christopher');


create or replace trigger tg_emprestimo
before insert or update
on emprestimo
referencing new as new
for each row
declare
verifica_usuario number;
begin
    -- Verificar existencia do usuario na tabela
    select count(cod_usuario) into verifica_usuario
    from usuario
    where cod_usuario = :new.cod_usuario;
    
    if verifica_usuario = 0
    then raise_application_error(-20001, 'Usuario não Cadastrado');
    end if;
end;
/

insert into emprestimo values (1 , sysdate, 8);
update emprestimo set cod_usuario = 8 where cod_usuario = 2;
select * from emprestimo;


create or replace trigger tg_devolucao
before insert or update
on lista_livros
referencing new as new
for each row
declare
begin
    -- Verificar a data da devolução
    if :new.data_devolucao != sysdate
    then raise_application_error(-20002, 'Data de devolução invalida, deve ser a data de hoje: '||sysdate||:new.data_devolucao);
    end if;
end;
/

insert into lista_livros values (1 , 1, sysdate);
update lista_livros set data_devolucao = sysdate-1 where cod_emprestimo = 1 and cod_livro = 1;
select * from lista_livros;


create or replace trigger tg_emp_livro
before insert
on lista_livros
referencing new as new
for each row
declare
verifica_existencia_livro number;
verifica_emprestimo_livro number;
begin
    -- Verificar a existencia dos livros
    select count(cod_livro) into verifica_existencia_livro
    from livro
    where cod_livro = :new.cod_livro;
    
    -- Verificar o emprestimo dos livros
    select count(cod_livro) into verifica_emprestimo_livro
    from lista_livros
    where cod_livro = :new.cod_livro
    and data_devolucao is null;
    
    if verifica_existencia_livro = 0
        then raise_application_error(-20003, 'Livro não existe');
    elsif verifica_emprestimo_livro = 1
        then raise_application_error(-20004, 'Livro emprestado');
    end if;
end;
/


insert into lista_livros values (3 , 1, '');
update lista_livros set cod_livro = 1, data_devolucao = sysdate where cod_emprestimo = 1 and cod_livro = 1;
select * from lista_livros;

delete from lista_livros;









