-- 1
-- a)
select distinct nome_tipo_mov from tipo_movimento tm
join movimentacao mv on (tm.cod_tipo_mov = mv.cod_tipo_mov)
join conta co on (mv.cod_conta = co.cod_conta)
join cliente_banco cl on (co.cod_cliente = cl.cod_cliente)
where lower(nome_cliente) = 'florzinha';

-- b)
select distinct nome_tipo_conta from tipo_conta tc
join conta co on (tc.cod_tipo_conta = co.cod_tipo_conta)
join cliente_banco cl on (co.cod_cliente = cl.cod_cliente)
where lower(nome_cliente) = 'moana'
and nome_tipo_conta not in (select distinct nome_tipo_conta from tipo_conta tc
            join conta co on (tc.cod_tipo_conta = co.cod_tipo_conta)
            join cliente_banco cl on (co.cod_cliente = cl.cod_cliente)
            where lower(nome_cliente) = 'tony stark');

-- c)
select nome_cliente from cliente_banco cl
join conta co on (cl.cod_cliente = co.cod_cliente)
join tipo_conta tc on (co.cod_tipo_conta = tc.cod_tipo_conta)
where lower(nome_tipo_conta) = 'poupança'
and saldo = (select min(saldo) from cliente_banco cl
            join conta co on (cl.cod_cliente = co.cod_cliente)
            join tipo_conta tc on (co.cod_tipo_conta = tc.cod_tipo_conta)
            where lower(nome_tipo_conta) = 'poupança');

-- d)
select nome_tipo_conta from tipo_conta
where nome_tipo_conta not in(select distinct nome_tipo_conta from tipo_conta tc
            join conta co on (tc.cod_tipo_conta = co.cod_tipo_conta)
            join cliente_banco cl on (co.cod_cliente = cl.cod_cliente)
            where lower(nome_cliente) = 'tony stark');
            
-- e)
select sum(valor) from movimentacao mv
join tipo_movimento tm on (mv.cod_tipo_mov = tm.cod_tipo_mov)
where lower(nome_tipo_mov) = 'ted';

-- f)
select nome_cliente from cliente_banco cl
join conta co on (cl.cod_cliente = co.cod_cliente)
join movimentacao mv on (co.cod_conta = mv.cod_conta)
join tipo_movimento tm on (mv.cod_tipo_mov = tm.cod_tipo_mov)
where lower(nome_tipo_mov) = 'saque'
and valor = (select max(valor) from cliente_banco cl
            join conta co on (cl.cod_cliente = co.cod_cliente)
            join movimentacao mv on (co.cod_conta = mv.cod_conta)
            join tipo_movimento tm on (mv.cod_tipo_mov = tm.cod_tipo_mov)
            where lower(nome_tipo_mov) = 'saque');
            
-- g)
select max(valor) from movimentacao
where to_char(data_mov, 'DD/MM/YYYY') = '28/03/2018';

-- h)
select nome_cliente from cliente_banco
where lower(nome_cliente) like '_o%'
and lower(nome_cliente) not like '%k';


-- 2 - Letra d)


-- 3 - Letra a)