create or replace procedure pr_inventario(tabela varchar2)
as
-- Cursor que pega o nome, tipo e tamanho das colunas
cursor cr_columns is select column_name, data_type, data_length from all_tab_columns 
                    where lower(table_name)=lower(tabela) order by column_id;
-- Cursor que pega o nome e o nome da coluna de cada constraint
cursor cr_constraints is select constraint_name, column_name from  user_cons_columns
                    where lower(table_name)=lower(tabela);

-- Variavel que guarda o create table
resp_columns varchar2(300) := 'create table '||lower(tabela)||'('||chr(10);
-- Variavel que guarda a parte inicial dos inserts
inicio_dados varchar2(300) := 'insert into '||lower(tabela)||'(';
-- Variavel que guarda o tipo da constraint
tipo_constraint varchar2(100);
-- Variavel auxiliar usada para impedir que uma coluna seja armazenada 2 vezes
aux number;
-- Variavel para verificar a existencia de constraints na tabela
count_constraint number;
-- Variavel que guarda os dados de cada linha da tabela
resp_dados varchar2(300);

-- Variaveis usadas na montagem do insert
cursor_insert  integer;
column_value_insert varchar2(4000);
status integer;
desc_tab_insert dbms_sql.desc_tab;
column_cnt_insert number;
begin
    -- Seta o formato de data
    execute immediate 'alter session set nls_date_format = ''DD/MM/YYYY HH24:MI:SS''';

    -- Verifica a existencia de constraints na tabela e armazena na variavel
    select count(constraint_name) into count_constraint
    from user_cons_columns where lower(table_name)=lower(tabela);

    -- Loop das colunas
    for x in cr_columns loop
        aux := 0;  
        -- Executa as colunas com consrtraints caso existam
        if count_constraint > 0 then
            -- Loop das consrtraints
            for y in cr_constraints loop
                if x.column_name = y.column_name then
                    aux := 1;
                    -- Pega o tipo da constraint como um unico caracter
                    select constraint_type into tipo_constraint
                    from  USER_CONSTRAINTS
                    where lower(table_name)=lower(tabela)
                    and constraint_name = y.constraint_name;

                    -- Pega o tipo da constraint como o nome completo
                    if lower(tipo_constraint) = 'p'
                        then tipo_constraint := 'primary key';
                    elsif lower(tipo_constraint) = 'r'
                        then tipo_constraint := 'foreing key';
                    elsif lower(tipo_constraint) = 'u'
                        then tipo_constraint := 'unique';
                    elsif lower(tipo_constraint) = 'c'
                        then tipo_constraint := 'not null';
                    end if;

                    -- Insere as colunas com constraint na variavel
                    -- Verifica se é do tipo varchar2
                    if lower(x.data_type) = 'varchar2' then
                        resp_columns := resp_columns||x.column_name||' '||x.data_type||'('||x.data_length||') constraint '||y.constraint_name||' '||tipo_constraint||','||chr(10);
                    else
                        resp_columns := resp_columns||x.column_name||' '||x.data_type||' constraint '||y.constraint_name||' '||tipo_constraint||','||chr(10);
                    end if;
                end if;
            end loop;
        end if;

            -- Verifica se a coluna ja foi inserida e 
            -- insere as colunas sem constraint na variavel
            if aux = 0 then
                if lower(x.data_type) = 'varchar2' then
                    resp_columns := resp_columns||x.column_name||' '||x.data_type||'('||x.data_length||')'||','||chr(10);
                else
                    resp_columns := resp_columns||x.column_name||' '||x.data_type||','||chr(10);
                end if;

            end if;

        -- Insere na variavel a parte inicial dos inserts
        inicio_dados := inicio_dados||x.column_name||', ';
    end loop;

    -- Remove a ultima virgula e finaliza a parte inicial dos inserts
    inicio_dados := SUBSTR(inicio_dados, 1, LENGTH(inicio_dados) - 2)||')'||chr(10)||'values (';
    -- Remove a ultima linha e finaliza o create table
    resp_columns := SUBSTR(resp_columns, 1, LENGTH(resp_columns) - 2)||chr(10)||');';

    -- Exibe as informações
    dbms_output.put_line('Objeto: '||lower(tabela));
    dbms_output.put_line('DDL:');
    dbms_output.put_line(resp_columns);
    dbms_output.put_line(' ');
    dbms_output.put_line('Dados:');

    -- Insert

    cursor_insert := dbms_sql.open_cursor;
    dbms_sql.parse(cursor_insert, 'select * from ' || tabela, dbms_sql.native);

    -- Descrever as colunas da tabela
    dbms_sql.describe_columns(cursor_insert, column_cnt_insert, desc_tab_insert);


    -- Definir as colunas
    for i in 1..column_cnt_insert loop
        dbms_sql.define_column(cursor_insert, i, column_value_insert, 4000);
    end loop;

    -- Executar o cursor
    status := dbms_sql.execute(cursor_insert);

    -- Buscar e exibe os registros
    while (dbms_sql.fetch_rows(cursor_insert) > 0) loop
        resp_dados := '';
        for i in 1..column_cnt_insert loop
            dbms_sql.column_value(cursor_insert, i, column_value_insert);

            -- Verifica o tipo da coluna
            if column_value_insert is null then
                resp_dados := resp_dados || 'null, ';
            elsif desc_tab_insert(i).col_type in(1, 96) then
                -- Tipo varchar2, colocar aspas simples
                resp_dados := resp_dados || '''' || replace(column_value_insert, '''', '''''') || ''', ';
            elsif desc_tab_insert(i).col_type in (12, 180) then
                -- Tipo date, formatar com to_date
                resp_dados := resp_dados || 'TO_DATE(''' || column_value_insert || ''', ''DD/MM/YYYY HH24:MI:SS''), ';
            else
                -- Outros tipos (números, etc.), inserir diretamente
                resp_dados := resp_dados || column_value_insert || ', ';
            end if;
        end loop;
        -- Exibe o insert
        dbms_output.put_line(inicio_dados || SUBSTR(resp_dados, 1, LENGTH(resp_dados) - 2) || ');');
    end loop;

    -- Fechar o cursor
    dbms_sql.close_cursor(cursor_insert);

end;
/