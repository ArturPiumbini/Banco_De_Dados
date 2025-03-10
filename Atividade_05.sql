SET SERVEROUTPUT ON;

select * from tb_distancia;
select * from tb_capital;
select * from tb_custo_frete;

create or replace procedure pr_frete(cd_origem number, cd_destino number, volume number, p_peso number)
as
origem varchar2(100);
destino varchar2(100);
distancia number;
peso number(10,3);
valor_kg number(10,3);
valor_m3 number(10,3);
valor_km number(10,3);
frete number(10,3);
begin
    -- Pega a origem e a distancia
    select nome_capital, distancia into origem, distancia
    from tb_distancia d
    join tb_capital c on (cod_origem = c.cod_capital)
    where cod_origem = cd_origem
    and cod_destino = cd_destino;
    
    -- Pega o destino
    select nome_capital into destino
    from tb_capital
    where cod_capital = cd_destino;
    
    -- Pega os custos do frete
    select valor_custo into valor_m3
    from tb_custo_frete
    where upper(nome_custo) = 'M3';
    select valor_custo into valor_kg
    from tb_custo_frete
    where upper(nome_custo) = 'KG';
    select valor_custo into valor_km
    from tb_custo_frete
    where upper(nome_custo) = 'KM';
    
    -- Calculo frete
    if (volume/6) > p_peso
        then peso := volume/6;
        dbms_output.put_line('Adoção do peso cubico: '||peso);
    else 
        peso := p_peso;
    end if;
    frete := (peso * valor_kg) + (volume * valor_m3) + (distancia * valor_km);
    
    dbms_output.put_line('Origem: '||origem);
    dbms_output.put_line('Destino: '||destino);
    dbms_output.put_line('Distancia: '||distancia||' km');
    dbms_output.put_line('Volume: '||volume||' m^3');
    dbms_output.put_line('Peso: '||peso||' kg');
    dbms_output.put_line('Frete: R$ '||frete);
end;
/

clear screen;
call pr_frete(1, 2, 1, 8);
call pr_frete(20, 8, 14, 2);


