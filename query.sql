use db_ticketfest;

-- CONSULTA 1: Listagem de locais cadastrados no estado de SP
-- OBJETIVO: Identificar recintos disponíveis em São Paulo por capacidade
SELECT nome_espaco, cidade, uf, capacidade_maxima 
FROM locais 
WHERE uf = 'SP' 
ORDER BY capacidade_maxima DESC;

-- CONSULTA 2: Busca de clientes por padrão de texto no nome
-- OBJETIVO: Localizar cadastros que contenham o termo "Silva"
SELECT id_cliente, nome, email, telefone 
FROM clientes 
WHERE nome LIKE '%Silva%';

-- CONSULTA 3: Eventos no último bimestre de 2026
-- OBJETIVO: Filtrar a pauta de shows entre novembro e dezembro de 2026
SELECT nome_evento, data_evento, status 
FROM eventos 
WHERE data_evento BETWEEN '2026-11-01 00:00:00' AND '2026-12-31 23:59:59'
ORDER BY data_evento ASC;

-- CONSULTA 4: Junção de eventos e locais
-- OBJETIVO: Relacionar cada show ao seu recinto físico
SELECT e.nome_evento, e.data_evento, l.nome_espaco, l.cidade, l.uf
FROM eventos e
INNER JOIN locais l ON e.id_local = l.id_local;

-- CONSULTA 5: Categorias de ingressos com preço superior a R$ 200,00
-- OBJETIVO: Identificar setores de valor elevado e seus eventos
SELECT c.nome_categoria, c.preco, e.nome_evento
FROM categorias_ingressos c
INNER JOIN eventos e ON c.id_evento = e.id_evento
WHERE c.preco > 200.00;

-- CONSULTA 6: Histórico de compras aprovadas
-- OBJETIVO: Relacionar compras pagas ao comprador ordenadas pelas mais recentes
SELECT co.id_compra, cl.nome AS cliente, co.data_compra, co.forma_pagamento, co.valor_total
FROM compras co
INNER JOIN clientes cl ON co.id_cliente = cl.id_cliente
WHERE co.status_pagamento = 'Aprovado'
ORDER BY co.data_compra DESC;

-- CONSULTA 7: Total faturado e quantidade de vendas por forma de pagamento
-- OBJETIVO: Apurar receita e volume de transações aprovadas por canal de pagamento
SELECT forma_pagamento, SUM(valor_total) AS faturamento_total, COUNT(id_compra) AS quantidade_vendas
FROM compras
WHERE status_pagamento = 'Aprovado'
GROUP BY forma_pagamento;

-- CONSULTA 8: Eventos agendados por recinto
-- OBJETIVO: Contar eventos por espaço físico e filtrar locais com pelo menos 1 evento
SELECT l.nome_espaco, COUNT(e.id_evento) AS total_eventos
FROM locais l
INNER JOIN eventos e ON l.id_local = e.id_local
GROUP BY l.id_local, l.nome_espaco
HAVING total_eventos >= 1;

-- CONSULTA 9: Preço médio dos ingressos por evento
-- OBJETIVO: Calcular o ticket médio das categorias ofertadas em cada show
SELECT e.nome_evento, AVG(c.preco) AS preco_medio
FROM eventos e
INNER JOIN categorias_ingressos c ON e.id_evento = c.id_evento
GROUP BY e.id_evento, e.nome_evento;


-- CONSULTA 10: Rastreio completo do ingresso emitido
-- OBJETIVO: Cruzar dados do bilhete, comprador, evento e setor (4 tabelas)
SELECT i.codigo_qr, cl.nome AS cliente, e.nome_evento, cat.nome_categoria, i.status_utilizacao
FROM ingressos_emitidos i
INNER JOIN compras co ON i.id_compra = co.id_compra
INNER JOIN clientes cl ON co.id_cliente = cl.id_cliente
INNER JOIN categorias_ingressos cat ON i.id_categoria = cat.id_categoria
INNER JOIN eventos e ON cat.id_evento = e.id_evento;


-- CONSULTA 11: Compras realizadas via PIX ou Cartão de Crédito
-- OBJETIVO: Filtrar pagamentos efetuados por meios digitais instantâneos
SELECT id_compra, valor_total, forma_pagamento, status_pagamento 
FROM compras 
WHERE forma_pagamento IN ('PIX', 'Cartao credito');


-- CONSULTA 12: Valor garantido por ingressos válidos
-- OBJETIVO: Somar a receita associada a bilhetes ativos no sistema
SELECT SUM(cat.preco) AS receita_ingressos_validos
FROM ingressos_emitidos i
INNER JOIN categorias_ingressos cat ON i.id_categoria = cat.id_categoria
WHERE i.status_utilizacao = 'Valido';


-- CONSULTA 13: Menor e maior preço de ingresso
-- OBJETIVO: Determinar a amplitude de valores das categorias cadastradas
SELECT MIN(preco) AS menor_preco, MAX(preco) AS maior_preco 
FROM categorias_ingressos;


-- CONSULTA 14: Ingressos emitidos por categoria (LEFT JOIN)
-- OBJETIVO: Listar total de emissões por categoria mantendo as sem vendas no relatório
SELECT cat.nome_categoria, e.nome_evento, COUNT(i.id_ingresso) AS total_emitidos
FROM categorias_ingressos cat
INNER JOIN eventos e ON cat.id_evento = e.id_evento
LEFT JOIN ingressos_emitidos i ON cat.id_categoria = i.id_categoria
GROUP BY cat.id_categoria, cat.nome_categoria, e.nome_evento;


-- CONSULTA 15: Ingressos de festivais ou turnês
-- OBJETIVO: Filtrar bilhetes de eventos com "Fest" ou "Tour" no nome ordenados por data
SELECT i.codigo_qr, e.nome_evento, i.status_utilizacao, co.data_compra
FROM ingressos_emitidos i
INNER JOIN categorias_ingressos cat ON i.id_categoria = cat.id_categoria
INNER JOIN eventos e ON cat.id_evento = e.id_evento
INNER JOIN compras co ON i.id_compra = co.id_compra
WHERE e.nome_evento LIKE '%Fest%' OR e.nome_evento LIKE '%Tour%'
ORDER BY co.data_compra ASC;