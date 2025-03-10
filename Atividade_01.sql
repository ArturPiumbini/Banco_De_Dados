SET SERVEROUTPUT ON;

select * from tb_paciente;
select * from tb_exame;
select * from tb_resultado_exame;

create or replace procedure pr_resultado_exame(cd_paciente number, cd_exame number, dt_exame date)
as
r_paciente varchar2(100);
r_exame varchar2(100);
r_resultado varchar2(100);
begin
    -- Coleta os dados da tabela
    select nome_paciente, nome_exame, resultado into r_paciente, r_exame, r_resultado
    from tb_paciente p
    join tb_resultado_exame r on (p.cod_paciente = r.cod_paciente)
    join tb_exame e on (r.cod_exame = e.cod_exame)
    where r.cod_paciente = cd_paciente
    and r.cod_exame = cd_exame
    and to_char(data_exame, 'DD/MM/YYYY') = dt_exame;
    
    -- Exibe as respostas
    dbms_output.put_line('Paciente: '||r_paciente);
    dbms_output.put_line('Exame: '||r_exame);
    dbms_output.put_line('Resultado: '||r_resultado);
    
    -- Tratamento de exceção
    exception
        when no_data_found then
        dbms_output.put_line('Erro: O exame não consta na base de dados');
end;
/

clear screen;
call pr_resultado_exame(3,2,'09/05/2024');