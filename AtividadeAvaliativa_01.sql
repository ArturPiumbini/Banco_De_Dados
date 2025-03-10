SET SERVEROUTPUT ON;

-- 1
create or replace function fn_round(vlr varchar2, decimo number)
return varchar2
as
resp varchar2(999);
begin
    for x in 1 .. length(vlr) loop
        if substr(vlr, x, 1) = ','
            then if substr(vlr, x+decimo+1, 1) >= 5
                    then resp := substr(vlr, 1, x+decimo-1)||(substr(vlr, x+decimo, 1)+1);
            else 
                resp := substr(vlr, 1, x+decimo);
            end if;
        end if;   
    end loop;
    return(resp);
end;
/

select fn_round('9,3148',3) from dual;

--2
create or replace procedure pr_url(url varchar2)
as
protocolo varchar2(999);
tipo varchar2(999);
endereco varchar2(999);
local varchar2(999);
ctrl1 number := 0;
begin
    for x in 1 .. length(url) loop
        if substr(url, x, 1) = ':'
            then protocolo := substr(url, 1, x-1);
        elsif substr(url, x, 2) = '//'
            then tipo := substr(url, x+2, length(url));
                for y in 1 .. length(tipo) loop
                    ctrl1 := ctrl1+1;
                    if substr(tipo, y, 1) = '.'
                        then tipo := substr(tipo, 1, ctrl1-1);
                        exit;
                    end if;
                end loop;
        elsif substr(url, x, length(tipo)+1) = (tipo||'.')
            then endereco := substr(url, x+length(tipo)+1, length(url));
                for y in 1 .. length(endereco) loop
                    ctrl1 := ctrl1+1;
                    if substr(endereco, y, 1) = '.'
                        then endereco := substr(endereco, 1, y-1);
                        exit;
                    end if;
                end loop;
        elsif substr(url, x, length(endereco)+1) = (endereco||'.')
            then local := substr(url, x+length(endereco)+1, length(url));
        end if;
    end loop;
    dbms_output.put_line('Protocolo: '||protocolo);
    dbms_output.put_line('Tipo: '||tipo);
    dbms_output.put_line('Endereco: '||endereco);
    dbms_output.put_line('Local: '||local);
end;
/

clear screen;
call pr_url('http://www.cotemig.com.br');

-- 3

create or replace procedure pr_tamanho(txt varchar2)
as
palavra varchar2(999);
qtd number := 0;
ctrl number := 0;
begin
    for x in 1 .. length(txt) loop
        ctrl := ctrl+1;
        if substr(txt, x, 1) = ' '
            then qtd := length(substr(txt,x-ctrl+1,ctrl-1));
            palavra := palavra||' '||qtd;
            ctrl := 0;
        end if;
        if x = length(txt)   
            then qtd := length(substr(txt,x-ctrl+1,ctrl));
            palavra := palavra||' '||qtd;
        end if;
    end loop;
    dbms_output.put_line(palavra);
end;
/

call pr_tamanho('Banco de Dados 2');