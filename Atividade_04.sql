SET SERVEROUTPUT ON;

-- Extra

create or replace procedure pr_selecionar_palavra(txt varchar2, n1 number)
as
resp varchar2(999):='';
ctrl number := 0;
ctrl2 number := 0;
begin

    for x in 1 .. length(txt) loop
        ctrl := ctrl + 1;
        if substr(txt, x, 1) = ' '
            then ctrl2 := ctrl2 + 1;
                if ctrl2 = n1
                    then resp := substr(txt,x-ctrl+1,ctrl-1);
                    exit;
                end if;
            ctrl := 0;
        end if;
        
        if x = length(txt)
            then ctrl2 := ctrl2 + 1;
                if ctrl2 = n1
                    then resp := substr(txt,x-ctrl+1,ctrl);
                    exit;
                end if;
        end if;
    end loop;
    if length(resp) > 0
        then dbms_output.put_line(resp);
    else
        dbms_output.put_line('A frase não posui esse numero de palavras');
    end if;
end;
/

clear screen;
call pr_selecionar_palavra('Banco de Dados II', 4);


-- 1 – Crie a função FN_INVERTE_LETRAS() que receba um texto como parâmetro e então mostreo invertido.

create or replace function fn_inverter_letras(txt varchar2)
return varchar2
as
resp varchar2(999):='';
begin
    for x in reverse 1 .. length(txt) loop
        resp:=resp||substr(txt,x,1);
    end loop;
    
    return(resp); 
end;
/

clear screen;
select fn_inverter_letras('Banco de Dados II') from dual;


-- 2 - Crie a função FN_INVERTE_PALAVRAS() que receba um texto como parâmetro e então mostre-o invertido.

create or replace function fn_inverter_palavras(txt varchar2)
return varchar2
as
resp varchar2(999):='';
ctrl number := 0;
begin

    for x in reverse 1 .. length(txt) loop
        ctrl := ctrl + 1;
        if substr(txt, x, 1) = ' '
            then resp:=resp||substr(txt,x+1,ctrl-1)||' ';
            ctrl := 0;
        end if;
        
        if x = 1
            then resp:=resp||substr(txt,x,ctrl);
        end if;
    end loop;
    
    return(resp); 
end;
/

clear screen;
select fn_inverter_palavras('Banco de Dados II') from dual;


-- 3 - Crie a procedure PR_INICIAL() que receba um texto como parâmetro e retorne apenas a primeira letra de cada palavra.

create or replace procedure pr_inicial(txt varchar2)
as
resp varchar2(999):='';
ctrl number := 0;
begin

    for x in 1 .. length(txt) loop
        ctrl := ctrl + 1;
        if substr(txt, x, 1) = ' '
            then resp := resp||substr(txt,x-ctrl+1,1)||' ';
            ctrl := 0;
        end if;
        
        if x = length(txt)
            then resp := resp||substr(txt,x-ctrl+1,1);
        end if;
    end loop;
    dbms_output.put_line(resp);
end;
/

clear screen;
call pr_inicial('Banco de Dados II');


-- 4 - Crie a procedure PR_INSERT() que receba 3 parâmetros: um texto, uma palavra e a uma 
-- posição. Então insira a palavra dentro do texto a partir da posição indicada.

create or replace procedure pr_insert(txt varchar2, inserir varchar2, posi number)
as
resp varchar2(999):='';
ctrl number := 0;
begin
for x in 1 .. length(txt) loop
        ctrl := ctrl + 1;
        if x = posi
            then resp := substr(txt,x-ctrl+1,ctrl-1)||inserir||substr(txt,x,length(txt)-x+1);
        end if;
        
    end loop;
    dbms_output.put_line(resp);
end;
/

clear screen;
call pr_insert('O cruzeiro é meu time de coração.', 'NÃO ', 12);


-- 5 - Crie a função FN_SUBSTITUI() que receba que receba 3 parâmetros: um texto, um valor
-- substituíveis e um valor alvo. Então a função devera substituir todos os valores substituíveis
-- pelo valor alvo.

create or replace function fn_substitui(txt varchar2, remover varchar2, substituir varchar2)
return varchar2
as
resp varchar2(999):='';
ctrl number := 0;
begin
for x in 1 .. length(txt) loop
        ctrl := ctrl + 1;
        if substr(txt,x,length(remover)) = remover
            then resp := substr(txt,x-ctrl+1,ctrl-1)||substituir||substr(txt,x+length(remover),length(txt)-x+1);
        end if;
        
    end loop;
    return(resp);
end;
/

clear screen;
select fn_substitui('O cruzeiro é meu time de coração.', 'cruzeiro', 'GALO') from dual;