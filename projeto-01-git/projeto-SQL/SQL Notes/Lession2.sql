/*Tente extrair todos os dados da tabela de contas e todos os dados da tabela de pedidos .

Tente extrair standard_qty , gloss_qty e poster_qty da tabela de pedidos , e o site e o primary_poc da tabela de contas .*/

SELECT orders.*, accounts.*
FROM orders 
JOIN accounts
ON accounts.id = orders.account_id

SELECT O.standard_qty, O.gloss_qty, O.poster_qty, A.primary_poc, A.website
FROM orders AS O
JOIN accounts AS A
ON A.id = O.account_id

/*Fornece uma tabela para todos os web_events associados ao nome da conta de Walmart. 
Deve haver três colunas. Certifique-se de incluir a primary_pochora do evento e a channelde cada evento. 
Além disso, você pode optar por adicionar uma quarta coluna para garantir que apenas os Walmarteventos sejam escolhidos.

Fornece uma tabela que fornece a região para cada sales_rep junto com suas contas associadas . 
Sua tabela final deve incluir três colunas: o nome da região , o nome do representante de vendas e o nome da conta . 
Classifique as contas em ordem alfabética (AZ) de acordo com o nome da conta.

Forneça o nome de cada região para cada pedido , bem como o nome da conta e o preço unitário pago (total_amt_usd / total) pelo pedido. 
Sua tabela final deve ter 3 colunas: nome da região , nome da conta e preço unitário . 
Algumas contas têm 0 para o total , então divido por (total + 0,01) para garantir que não haja divisão por zero.*/


SELECT a.name AS Nomes, 
    primary_poc AS representantes, 
    occurred_at AS data, 
    channel AS canal
FROM web_events AS w
JOIN accounts AS a 
ON w.account_id = a.id
WHERE name IN ('Walmart')
ORDER BY canal;


SELECT r.name AS nome_regiao, 
    s.name AS nome_vendedor, 
    a.name AS nome_conta
FROM accounts AS a
JOIN sales_reps AS s
ON s.id = a.sales_rep_id
JOIN region AS r
ON s.region_id = r.id
ORDER BY a.name;


SELECT r.name AS region_name, 
    a.name AS account_name, 
    (o.total_amt_usd /(o.total + 0.01)) AS unit_price
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id

/*Fornece uma tabela que fornece a região para cada sales_rep junto com suas contas associadas . 
Desta vez apenas para a Midwestregião. Sua tabela final deve incluir três colunas: o nome da região ,
 o nome do representante de vendas e o nome da conta . Classifique as contas em ordem alfabética (AZ) de acordo com o nome da conta.

Fornece uma tabela que fornece a região para cada sales_rep junto com suas contas associadas . 
Desta vez, apenas para contas em que o representante de vendas tem um nome que começa com Se na Midwestregião. 
Sua tabela final deve incluir três colunas: o nome da região , o nome do representante de vendas e o nome da conta . 
Classifique as contas em ordem alfabética (AZ) de acordo com o nome da conta.

Fornece uma tabela que fornece a região para cada sales_rep junto com suas contas associadas .
 Desta vez, apenas para contas em que o representante de vendas tem um sobrenome que começa com Ke na Midwestregião. 
 Sua tabela final deve incluir três colunas: o nome da região , o nome do representante de vendas e o nome da conta . C
 lassifique as contas em ordem alfabética (AZ) de acordo com o nome da conta.

Forneça o nome de cada região para cada pedido , bem como o nome da conta e o preço unitário pago (total_amt_usd / total) pelo pedido.
 No entanto, você só deve fornecer os resultados se a quantidade padrão do pedido exceder 100. Sua tabela final deve ter 
 3 colunas: nome da região , nome da conta e preço unitário . Para evitar um erro de divisão por zero, 
 adicionar 0,01 ao denominador aqui é útil total_amt_usd / (total + 0,01).

Forneça o nome de cada região para cada pedido , bem como o nome da conta e o preço unitário pago (total_amt_usd / total) pelo pedido. 
No entanto, você só deve fornecer os resultados se a quantidade do pedido padrão for superior 100e a quantidade do pedido 
do pôster for superior 50. Sua tabela final deve ter 3 colunas: nome da região , nome da conta e preço unitário . 
Classifique primeiro pelo menor preço unitário . Para evitar um erro de divisão por zero, 
adicionar 0,01 ao denominador aqui é útil (total_amt_usd / (total + 0,01).

Forneça o nome de cada região para cada pedido , bem como o nome da conta e o preço unitário pago (total_amt_usd / total) pelo pedido.
 No entanto, você só deve fornecer os resultados se a quantidade do pedido padrão for superior 100e a quantidade do pedido do pôster 
 for superior 50. Sua tabela final deve ter 3 colunas: nome da região , nome da conta e preço unitário . 
 Classifique primeiro pelo maior preço unitário . Para evitar um erro de divisão por zero, 
 adicionar 0,01 ao denominador aqui é útil (total_amt_usd / (total + 0,01).

Quais são os diferentes canais usados ​​pelo ID da conta 1001 ? 
Sua tabela final deve ter apenas 2 colunas: nome da conta e os diferentes canais . 
Você pode tentar SELECT DISTINCT para restringir os resultados a apenas os valores exclusivos.

Encontre todos os pedidos ocorridos em 2015. 
Sua tabela final deve ter 4 colunas: ocorrido_at , nome da conta , total do pedido e total_amt_usd do pedido .*/


SELECT a.name AS acc_name, s.name AS rep_name, r.name AS reg_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
WHERE r.name IN ('Midwest')
ORDER BY a.name;

SELECT a.name AS acc_name, s.name AS rep_name, r.name AS reg_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
WHERE r.name IN ('Midwest') AND s.name LIKE ('S%')
ORDER BY a.name;

SELECT a.name AS acc_name, s.name AS rep_name, r.name AS reg_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
WHERE r.name IN ('Midwest') AND s.name LIKE ('%K%') AND s.name NOT LIKE ('K%')
ORDER BY a.name;

SELECT r.name AS reg_name, a.name AS acc_name, o.total_amt_usd/(o.total+0.01) AS unit_price
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN orders as o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty >50
ORDER BY unit_price;

SELECT r.name AS reg_name, a.name AS acc_name, o.total_amt_usd/(o.total+0.01) AS unit_price
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN orders as o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty >50
ORDER BY unit_price DESC;

SELECT DISTINCT channel, name AS acc_name
FROM web_events AS w
JOIN accounts AS a
ON a.id = w.account_id
WHERE a.id IN (1001);

SELECT occurred_at AS data, name AS acc_name, total, total_amt_usd AS total_amount
FROM orders AS o
LEFT JOIN accounts AS a
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY o.occurred_at;