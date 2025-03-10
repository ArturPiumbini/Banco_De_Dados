SET SERVEROUTPUT ON;

-- 1
create or replace procedure pr_apura_peso(txt_peso varchar2)
as
peso_total number(10,2) := 0;
aux varchar2(100);
aux2 varchar2(100);
ctrl number := 0;
begin
    for x in 1 .. length(txt_peso) loop
        if substr(txt_peso, x, 1) = '*'
            then aux := substr(txt_peso, x, length(txt_peso));
            ctrl := 0;
            for y in 1 .. length(aux) loop
                ctrl := ctrl+1;
                if substr(aux, y, 2) = 'KG'
                    then aux := substr(aux, 2, ctrl-2);
                    peso_total := peso_total + aux;
                end if;
            end loop;
        end if;
    end loop;
    dbms_output.put_line(peso_total);
end;
/

clear screen;
call pr_apura_peso('*2.3KG *40KG *125.87KG');

-- 2 Letra a)

-- 3
drop table curso;
drop table candidato;
drop table inscricao;

create table curso(
cod_curso number,
nome_curso varchar2(30),
vagas number,
nivel_escolar varchar2(30));

insert into curso values (1, 'Biologia', 5, 'MEDIO');
insert into curso values (2, 'Matem√°tica', 3, 'SUPERIOR');
insert into curso values (3, 'Banco de Dados', 5, 'SUPERIOR');

create table candidato(
cod_candidato number,
nome_candidato varchar2(30),
escolaridade varchar2(30));

insert into candidato values (1, 'Florzinha', 'MEDIO');
insert into candidato values (2, 'Lindinha', 'SUPERIOR');
insert into candidato values (3, 'Docinho', 'FUNDAMENTAL');
insert into candidato values (4, 'Macaco Louco', 'MEDIO');
insert into candidato values (5, 'Jorel', 'SUPERIOR');
insert into candidato values (6, 'Vov√≥ Juju', 'SUPERIOR');
insert into candidato values (7, 'Clar√™ncio', 'MEDIO');
insert into candidato values (8, 'Minie', 'SUPERIOR');

create table inscricao(
cod_inscricao number,
cod_curso number,
cod_candidato number);

commit;

create or replace trigger tg_inscricao
before insert
on inscricao
referencing new as new
for each row
declare
nivel_escolar_curso varchar2(30);
escolaridade_candidato varchar2(30);
begin
    --Pega o nivel escolar do curso
    select nivel_escolar into nivel_escolar_curso
    from curso
    where cod_curso = :new.cod_curso;
    
     --Pega a escolaridade do candidato
    select escolaridade into escolaridade_candidato
    from candidato
    where cod_candidato = :new.cod_candidato;
    
    if nivel_escolar_curso != escolaridade_candidato
        then raise_application_error(-20001, 'Nivel de escolaridade n„o compativel!');
    end if;
end;
/

insert into inscricao values (1, 1, 1);
insert into inscricao values (2, 1, 4);
select * from inscricao;


-- 4

create or replace procedure pr_conta_luz(p_cod_cliente number, mes varchar2)
as
boleto number(10,2);
calculo varchar2(100);
cliente varchar2(100);
cl_consumo number(10,2);
tarifa_mes number(10,3);
begin
    select nome_cliente, consumo, valor into cliente, cl_consumo, tarifa_mes
    from tb_cliente cl
    join tb_conta_luz cz on (cl.cod_cliente = cz.cod_cliente)
    join tb_tarifa_luz on(mes_fechamento = mes_referencia)
    where cz.cod_cliente = p_cod_cliente
    and mes_fechamento = mes;
    
    if cl_consumo < 120
        then boleto := (cl_consumo*tarifa_mes)*0.9;
        calculo := '('||cl_consumo||'*'||tarifa_mes||')*0.9 = '||boleto;
    elsif cl_consumo <= 130
        then boleto := cl_consumo*tarifa_mes;
        calculo := cl_consumo||'*'||tarifa_mes||' = '||boleto;
    elsif cl_consumo <= 200
        then boleto := (cl_consumo*tarifa_mes)*(1+((200-cl_consumo)/100));
        calculo := '('||cl_consumo||'*'||tarifa_mes||')*(1+((200-'||cl_consumo||')/100)) = '||boleto;
    else
        boleto := 2*(cl_consumo*tarifa_mes);
        calculo := '('||cl_consumo||'*'||tarifa_mes||')*2 = '||boleto;
    end if;
    
    dbms_output.put_line('Cliente: '||cliente);
    dbms_output.put_line('MÍs: '||mes);
    dbms_output.put_line('Consumo: '||cl_consumo);
    dbms_output.put_line('Calculo: '||calculo);
end;
/

clear screen;
call pr_conta_luz(2, '09/2024');

select * from tb_cliente;
select * from tb_conta_luz;
select * from tb_tarifa_luz;


