/*Encontre a quantidade total de papel poster_qty pedido na tabela de pedidos .

Encontre a quantidade total de papel standard_qty pedido na tabela de pedidos .

Encontre o valor total em dólares das vendas usando total_amt_usd na tabela de pedidos .

Encontre o valor total gasto em papel standard_amt_usd e gloss_amt_usd para cada pedido na tabela de pedidos. 
Isso deve resultar em uma quantia em dólares para cada pedido na tabela.

Encontre o standard_amt_usd por unidade de papel standard_qty . Sua solução deve usar uma agregação e um operador matemático.*/


SELECT SUM(poster_qty) AS poster_qty_sum
FROM orders;

SELECT SUM(standard_qty) AS standard_qty_sum
FROM orders;

SELECT SUM(total_amt_usd) AS total_amt_usd_sum
FROM orders;

SELECT standard_amt_usd) + SUM gloss_amt_usd AS total_amount_sum
FROM orders;

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;


/*Quando foi feito o primeiro pedido? Você só precisa devolver a data.

Tente realizar a mesma consulta da pergunta 1 sem usar uma função de agregação.

Quando ocorreu o web_event mais recente (mais recente) ?

Tente executar o resultado da consulta anterior sem usar uma função de agregação.

Encontre o valor médio ( MÉDIO ) gasto por pedido em cada tipo de papel, 
bem como o valor médio de cada tipo de papel adquirido por pedido. 
Sua resposta final deve ter 6 valores - um para cada tipo de papel para o número médio de vendas, bem como o valor médio.

Por meio do vídeo, você pode estar interessado em como calcular a MEDIANA. 
Embora isso seja mais avançado do que o que cobrimos até agora, 
tente descobrir - quanto é o total_usd MEDIAN gasto em todos os pedidos ?*/


SELECT MIN(occurred_at)
FROM orders;

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

SELECT MAX(occurred_at)
FROM web_events;

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
    AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
    AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;


/*Qual conta (por nome) fez o pedido mais antigo? Sua solução deve ter o nome da conta e a data do pedido.

Encontre o total de vendas em usd para cada conta. 
Você deve incluir duas colunas - o total de vendas para os pedidos de cada empresa em usd e o nome da empresa .

Por meio de qual canal ocorreu o web_event mais recente (mais recente) , qual conta foi associada a este web_event ? 
Sua consulta deve retornar apenas três valores - a data , o canal e o nome da conta .

Encontre o número total de vezes que cada tipo de canal do web_events foi usado.
 Sua mesa final deve ter duas colunas - o canal e o número de vezes que o canal foi usado.

Quem foi o contato principal associado ao web_event mais antigo ?

Qual foi o menor pedido feito por cada conta em termos de usd totais . Forneça apenas duas colunas - o nome da conta e o total de usd . 
Faça pedidos dos menores valores em dólares para os maiores.

Encontre o número de representantes de vendas em cada região. 
Sua tabela final deve ter duas colunas - a região e o número de sales_reps . 
Faça o pedido do menor número de repetições para o maior número de repetições.*/


SELECT a.name, o.occurred_at
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1;

SELECT SUM(o.total_amt_usd) AS sales, a.name
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.name;

SELECT w.occurred_at, w.channel, a.name
FROM accounts AS a
JOIN web_events AS w
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

SELECT channel, COUNT(*)
FROM web_events
GROUP BY channel;

SELECT w.occurred_at, a.name
FROM accounts AS a
JOIN web_events AS w
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

SELECT a.name, MIN(o.total_amt_usd) AS total_each_account
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_each_account;

SELECT r.name, COUNT(*) AS rep_qty
FROM sales_reps AS s
JOIN region AS r
ON s.region_id = r.id
GROUP BY r.name
ORDER BY rep_qty;


/*Para cada conta, determine a quantidade média de cada tipo de papel adquirido em seus pedidos. 
Seu resultado deve ter quatro colunas -
 uma para o nome da conta e outra para a quantidade média comprada para cada um dos tipos de papel de cada conta.


Para cada conta, determine o valor médio gasto por pedido em cada tipo de papel. 
Seu resultado deve ter quatro colunas - uma para o nome da conta e outra para o valor médio gasto em cada tipo de papel.


Determine o número de vezes que um determinado canal foi usado na tabela web_events para cada representante de vendas . 
Sua tabela final deve ter três colunas - o nome do representante de vendas , o canal e o número de ocorrências. Ordene primeiro a sua tabela com o maior número de ocorrências.


Determine o número de vezes que um determinado canal foi usado na tabela web_events para cada região . 
Sua tabela final deve ter três colunas - o nome da região , o canal e o número de ocorrências. 
Ordene primeiro a sua tabela com o maior número de ocorrências.*/


SELECT a.name, ROUND(AVG(o.standard_qty), 2) avg_standard, 
    ROUND(AVG(poster_qty), 2) avg_poster, 
    ROUND(AVG(gloss_qty), 2) avg_gloss
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name;

SELECT a.name, ROUND(AVG(o.standard_amt_usd), 2) avg_standard, 
    ROUND(AVG(poster_amt_usd), 2) avg_poster, 
    ROUND(AVG(gloss_amt_usd), 2) avg_gloss
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name;

SELECT COUNT(*) AS channel_occurr, s.name, w.channel
FROM sales_reps AS s
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN web_events AS w
ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY channel_occurr, s.name;

SELECT COUNT(*) AS channel_occurr, r.name, w.channel
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN web_events AS w
ON a.id = w.account_id
GROUP BY r.name, w.channel
ORDER BY channel_occurr;


/*Quantos representantes de vendas gerenciam mais de 5 contas?


Quantas contas têm mais de 20 pedidos?


Qual conta tem mais pedidos?


Quais contas gastaram mais de 30.000 usd no total em todos os pedidos?


Quais contas gastaram menos de 1.000 usd no total em todos os pedidos?


Qual conta gastou mais conosco?


Qual conta gastou menos conosco?


Que as contas utilizadas facebookcomo um canal para os clientes contato mais de 6 vezes?


Qual conta é facebookmais usada como canal ?


Qual canal foi usado com mais frequência pela maioria das contas?*/

SELECT s.id, s.name, COUNT (*) numb_acc
FROM sales_reps AS s
JOIN accounts AS a
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5;

SELECT a.id, a.name, COUNT(*) numb_orders
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY numb_orders;

SELECT a.id, a.name, COUNT(*) numb_orders
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY numb_orders DESC
LIMIT 1;

SELECT a.id, a.name, SUM(total_amt_usd) AS sum_total_orders
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(total_amt_usd) >= 30000
ORDER BY sum_total_orders;

SELECT a.id, a.name, SUM(total_amt_usd) AS sum_total_orders
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(total_amt_usd) <= 1000
ORDER BY sum_total_orders;

SELECT a.id, a.name, SUM(total_amt_usd) AS sum_total_orders
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY sum_total_orders DESC
LIMIT 1;

SELECT a.id, a.name, SUM(total_amt_usd) AS sum_total_orders
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY sum_total_orders
LIMIT 1;

SELECT a.name, w.channel, COUNT(*) channel_times_used
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE w.channel IN ('facebook')
GROUP BY a.name, w.channel
HAVING COUNT(*) > 6
ORDER BY channel_times_used;

SELECT a.name, w.channel, COUNT(*) channel_times_used
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE w.channel IN ('facebook')
GROUP BY a.name, w.channel
ORDER BY channel_times_used DESC
LIMIT 1;

SELECT a.name, w.channel, COUNT(*) channel_times_used
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY channel_times_used DESC
LIMIT 10;


SELECT DATE_PART('year', occurred_at) ord_year,  SUM(total_amt_usd) total_spent
FROM orders
GROUP BY ord_year
ORDER BY total_spent DESC;

SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;


/*Escreva uma consulta para exibir para cada pedido, o ID da conta, o valor total do pedido e o nível do pedido 
- 'Grande' ou 'Pequeno' - dependendo se o pedido é $ 3.000 ou mais, ou menor que $ 3.000.


Escreva uma consulta para exibir o número de pedidos em cada uma das três categorias, com base no totalnúmero de itens em cada pedido. 
As três categorias são: 'Pelo menos 2000', 'Entre 1000 e 2000' e 'Menos de 1000'.


Gostaríamos de entender 3 níveis diferentes de clientes com base no valor associado às suas compras. 
O nível superior inclui qualquer pessoa com valor vitalício (vendas totais de todos os pedidos) greater than 200,000usd. 
O segundo nível está entre 200,000 and 100,000usd. O nível mais baixo é qualquer pessoa under 100,000usd. 
Forneça uma tabela que inclua o nível associado a cada conta . 
Você deve fornecer o nome da conta , o total de vendas de todos os pedidos do cliente e o nível . 
Faça o pedido com os clientes que mais gastam listados primeiro.


Gostaríamos agora de realizar um cálculo semelhante ao primeiro, 
mas queremos obter o valor total gasto pelos clientes apenas em 2016e 2017. 
Mantenha o mesmo nível da pergunta anterior. Faça o pedido com os clientes que mais gastam listados primeiro.


Gostaríamos de identificar os representantes de vendas de melhor desempenho , 
que são representantes de vendas associados a mais de 200 pedidos. 
Crie uma tabela com o nome do representante de vendas , 
o número total de pedidos e uma coluna com topou notdependendo se eles têm mais de 200 pedidos. 
Coloque os melhores vendedores em primeiro lugar na sua mesa final.


O anterior não contabilizava o meio, nem o valor em dólares associado às vendas. 
A administração decide que deseja ver essas características representadas também. 
Gostaríamos de identificar os representantes de vendas de melhor desempenho , 
que são representantes de vendas associados a mais do que 200pedidos ou a mais do que o 750000total de vendas. 
O middlegrupo tem qualquer representante com mais de 150 pedidos ou 500000em vendas. 
Criar uma tabela com o nome de representante de vendas , o número total de encomendas, as vendas totais em todas as ordens, 
e uma coluna com top, middleou lowdependendo este critério. 
Coloque os melhores vendedores com base no valor em dólares das vendas em primeiro lugar na sua mesa final. 
Você pode ver alguns vendedores chateados por este critério!*/


SELECT a.id, o.total_amt_usd, 
    CASE WHEN o.total_amt_usd > 3000 THEN 'Grande' 
    ELSE 'PEQUENO' END AS tabela_legal
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id;

SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
   WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
   ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;

SELECT a.name, SUM(total_amt_usd) AS total, 
    CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'TOP VENDOR' 
    WHEN SUM(o.total_amt_usd) > 100000 THEN 'MIDDLE VENDOR'
    ELSE 'LOWER VENDOR' END AS classificacao_vendedores
    
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name

SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31' 
GROUP BY 1
ORDER BY 2 DESC;

SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'top'
     ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;

SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent, 
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;



SELECT
    channel,
    AVG(event_count) AS media
FROM
(SELECT DATE_TRUNC('day', occurred_at) AS day,
    channel,
    COUNT(*) AS event_count
FROM web_events
GROUP BY 1,2) sub
GROUP BY 1
ORDER BY 2 DESC;

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);


SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1;



/*Forneça o nome do sales_rep em cada região com a maior quantidade de vendas total_amt_usd .
*/
WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY 1,2
   ORDER BY 3 DESC), 
t2 AS (
   SELECT region_name, MAX(total_amt) total_amt
   FROM t1
   GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;
/*Para a região com as maiores vendas total_amt_usd , quantos pedidos totais foram feitos?
*/
WITH t1 AS (
   SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY r.name), 
t2 AS (
   SELECT MAX(total_amt)
   FROM t1)
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);
/*Para a conta que comprou mais (no total durante sua vida como cliente) papel standard_qty , quantas contas ainda tiveram mais no total de compras?
*/
WITH t1 AS (
  SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1), 
t2 AS (
  SELECT a.name
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1
  HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;
/*Para o cliente que gastou mais (no total ao longo de sua vida como cliente) total_amt_usd , quantos web_events eles tiveram para cada canal?
*/
WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;
/*Qual é o valor médio da vida útil gasto em termos de total_amt_usd para as 10 principais contas de gastos totais ?
*/
WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 10)
SELECT AVG(tot_spent)
FROM t1;

/*Qual é o valor médio de vida gasto em termos de total_amt_usd , incluindo apenas as empresas que gastaram mais por pedido, em média, do que a média de todos os pedidos.
*/
WITH t1 AS (
   SELECT AVG(o.total_amt_usd) avg_all
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id),
t2 AS (
   SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
   FROM orders o
   GROUP BY 1
   HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
SELECT AVG(avg_amt)
FROM t2;


/*Existem 350 nomes de empresas que começam com uma letra e 1 que começa com um número. Isso dá uma proporção de 350/351 que são nomes de empresas que começam com uma letra ou 99,7%.
*/
SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 1 ELSE 0 END AS num, 
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;
/*Existem 80 nomes de empresas que começam com uma vogal e 271 que começam com outros caracteres. Portanto, 80/351 são vogais ou 22,8%. Portanto, 77,2% dos nomes das empresas não começam com vogais.
*/
SELECT SUM(vowels) vowels, SUM(other) other
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                        THEN 1 ELSE 0 END AS vowels, 
          CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                       THEN 0 ELSE 1 END AS other
         FROM accounts) t1;

/*Use a accountstabela para criar primeiros e últimos colunas de nomes que seguram os primeiros e últimos nomes para o primary_poc.


Agora veja se você pode fazer a mesma coisa para todos os representantes namena sales_repstabela. 
Novamente fornecer primeiros e últimos colunas de nome.
*/

SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, 
    RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;

SELECT LEFT(name, STRPOS(name, ' ') -1 ) first_name, 
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;

/*Cada empresa da accountstabela deseja criar um endereço de e-mail para cada uma primary_poc. 
O endereço de e-mail deve ser o nome do sobrenome do primary_poc . do nome da empresa primary_poc .@.com


Você deve ter notado que na solução anterior alguns nomes de empresas incluem espaços, 
o que certamente não funcionará em um endereço de e-mail. 
Veja se você pode criar um endereço de e-mail que funcione removendo todos os espaços da conta name, mas caso contrário, 
sua solução deve ser a mesma 1. Alguma documentação útil está aqui .


Gostaríamos também de criar uma senha inicial, que será alterada após o primeiro login. 
A primeira senha será a primeira letra do primary_pocnome de (minúscula), depois a última letra do primeiro nome (minúscula), 
a primeira letra do sobrenome (minúscula), a última letra do sobrenome (minúscula), o número de letras do primeiro nome, 
o número de letras do sobrenome e, em seguida, o nome da empresa em que trabalham com, todas em maiúsculas sem espaços.
*/

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(LOWER(first_name), '.', LOWER(last_name), '@', LOWER(name), '.com')

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(LOWER(first_name), '.', LOWER(last_name), '@', REPLACE(LOWER(name),' ',''), '.com')

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;


SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data;


SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;