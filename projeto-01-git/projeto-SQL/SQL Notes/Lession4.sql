/*Usando o vídeo anterior de Derek como exemplo, crie outro total corrido. 
Desta vez, crie um total de execução de standard_amt_usd(na orders tabela) ao longo do tempo do pedido sem truncamento de data. 
Sua tabela final deve ter duas colunas: uma com o valor adicionado para cada nova linha e a segunda com o total corrente.*/

SELECT standard_amt_usd,
       SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders


/*Agora, modifique sua consulta do questionário anterior para incluir partições. 
Ainda crie um total de execução de standard_amt_usd(na orderstabela) ao longo do tempo do pedido, mas, desta vez, 
a data é truncada occurred_atpor ano e particionada pela mesma occurred_atvariável truncada por ano . 
Sua tabela final deve ter três colunas: uma com o valor adicionado para cada linha, u
ma para a data truncada e uma coluna final com o total corrente em cada ano.
*/

SELECT standard_amt_usd,
       DATE_TRUNC('year', occurred_at) as year,
       SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders

/*Seleccionar o id, account_id, e totalvariável da ordersmesa, então,
criar uma coluna chamada total_rankque classifica esta quantidade total de papel ordenadas (da mais alta para a mais baixa) 
para cada conta utilizando uma partição. Sua tabela final deve ter essas quatro colunas.*/


SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders 
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))

/*No vídeo anterior, Derek descreve como comparar uma linha com uma linha anterior ou subsequente. 
Essa técnica pode ser útil ao analisar eventos baseados em tempo. 
Imagine que você é um analista da Parch & Posey e deseja determinar como a receita total do 
pedido atual (significado "total" das vendas de todos os tipos de papel) se compara à receita total do próximo pedido.

Modifique a consulta de Derek do vídeo anterior no SQL Explorer abaixo para realizar esta análise. 
Você precisará usar occurred_ate total_amt_usdna orderstabela junto com LEADpara fazer isso. 
Nos resultados da consulta, deve haver quatro colunas: occurred_at, total_amt_usd, lead, e lead_difference.*/

SELECT occurred_at,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_amt_usd) AS total_amt_usd
  FROM orders 
 GROUP BY 1
) sub


/*Use a NTILEfuncionalidade de dividir as contas em 4 níveis de acordo com o valor de standard_qtyseus pedidos. 
A tabela resultante deve ter o account_id, o occurred_attempo para cada pedido, 
a quantidade total de standard_qtypapel comprado e um dos quatro níveis em uma standard_quartilecoluna.


Use a NTILEfuncionalidade de dividir as contas em dois níveis de acordo com o valor de gloss_qtyseus pedidos. 
A tabela resultante deve ter o account_id, o occurred_attempo para cada pedido, 
a quantidade total de gloss_qtypapel comprado e um dos dois níveis em uma gloss_halfcoluna.


Use a NTILEfuncionalidade para dividir os pedidos de cada conta em 100 níveis de acordo com o valor de total_amt_usdseus pedidos. 
A tabela resultante deve ter o account_id, o occurred_attempo para cada pedido, 
a quantidade total de total_amt_usdpapel comprado e um dos 100 níveis em uma total_percentilecoluna.*/


SELECT
       account_id,
       occurred_at,
       standard_qty,
       NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
    FROM orders 
    ORDER BY account_id DESC



SELECT
       account_id,
       occurred_at,
       gloss_qty,
       NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_half
  FROM orders 
 ORDER BY account_id DESC

SELECT
       account_id,
       occurred_at,
       total_amt_usd,
       NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
  FROM orders 
 ORDER BY account_id DESC


SELECT we1.id AS we_id,
       we1.account_id AS we1_account_id,
       we1.occurred_at AS we1_occurred_at,
       we1.channel AS we1_channel,
       we2.id AS we2_id,
       we2.account_id AS we2_account_id,
       we2.occurred_at AS we2_occurred_at,
       we2.channel AS we2_channel
  FROM web_events we1 
 LEFT JOIN web_events we2
   ON we1.account_id = we2.account_id
  AND we1.occurred_at > we2.occurred_at
  AND we1.occurred_at <= we2.occurred_at + INTERVAL '1 day'
ORDER BY we1.account_id, we2.occurred_at