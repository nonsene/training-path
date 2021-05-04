/*Tente usar limitar-se a seguir ao escrever uma consulta que exibe todos os dados no 
occurred_at, account_ide channelcolunas da tabela de web_events, e limita a 
saída apenas para as primeiras 15 linhas.
*/

SELECT occurred_at, account_id, channel 
FROM web_events 
LIMIT 15;

/*Escreva uma consulta para retornar os 10 primeiros pedidos na tabela de pedidos . 
Incluir o id, occurred_at, e total_amt_usd.


Escreva uma consulta para retornar os 5 principais pedidos em termos de maior total_amt_usd. 
Incluir o id, account_id, e total_amt_usd.


Escreva uma consulta para retornar os 20 pedidos mais baixos em termos dos menores total_amt_usd. 
Incluir o id, account_id, e total_amt_usd.
*/

SELECT id, occurred_at, total_amt_usd 
FROM orders
ORDER BY occurred_at
LIMIT 10;

SELECT id, occurred_at, total_amt_usd 
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, occurred_at, total_amt_usd 
FROM orders 
ORDER BY total_amt_usd
LIMIT 20

/*Escreva uma consulta que exiba o ID do pedido, 
o ID da conta e o valor total em dólares para todos os pedidos, classificados primeiro pelo ID da conta (em ordem crescente) e, em seguida, pelo valor total em dólares (em ordem decrescente).

Agora escreva uma consulta que exiba novamente o ID do pedido, 
o ID da conta e o valor total em dólares para cada pedido, mas desta vez classificado primeiro pelo valor total em dólares (em ordem decrescente) e, em seguida, pelo ID da conta (em ordem crescente).

Compare os resultados dessas duas consultas acima. 
Como os resultados são diferentes quando você alterna a coluna que classifica primeiro?
*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

/*account_id é desconsiderado da pesquisa*/



/* Retira as primeiras 5 linhas e todas as colunas da tabela de pedidos que tenham um valor em dólares 
gloss_amt_usdmaior ou igual a 1000.

Extrai as primeiras 10 linhas e todas as colunas da tabela de pedidos com total_amt_usdmenos de 500.*/


SELECT * FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

SELECT * FROM orders
WHERE total_amt_usd < 500
LIMIT 10;


/*Filtre a tabela de contas para incluir a empresa name, websitee o ponto de contato principal ( primary_poc) 
apenas para a empresa Exxon Mobil na tabela de contas .*/

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil'



/*Crie uma coluna que divida o standard_amt_usdpelo standard_qtypara encontrar o preço unitário do papel padrão para cada pedido. 
Limite os resultados aos primeiros 10 pedidos e inclua os campos ide account_id.

Escreva uma consulta que encontre a porcentagem da receita proveniente do papel de pôster para cada pedido. 
Você precisará usar apenas as colunas que terminam com _usd. (Tente fazer isso sem usar a totalcoluna.) 
Exiba os campos ide account_idtambém. NOTA - você receberá um erro com a solução correta para esta questão. 
Isso ocorre porque pelo menos um dos valores nos dados cria uma divisão por zero em sua fórmula. 
Você aprenderá mais tarde no curso como lidar totalmente com esse problema. 
Por enquanto, você pode simplesmente limitar seus cálculos aos primeiros 10 pedidos, como fizemos na pergunta nº 1, 
e você evitará o conjunto de dados que causa o problema.*/



SELECT id,
    account_id,
    standard_amt_usd / standard_qty AS unit_price
FROM orders
LIMIT 10;

SELECT id, account_id, 
   poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;


/*Todas as empresas cujos nomes começam com 'C'.

Todas as empresas cujos nomes contêm a string 'um' em algum lugar do nome.

Todas as empresas cujos nomes terminam com 's'.*/

SELECT name 
FROM accounts
WHERE name LIKE '%C%';

SELECT name 
FROM accounts
WHERE name LIKE '%one%';

SELECT name 
FROM accounts
WHERE name LIKE '%s%';

/*Utilizar a contas tabela para encontrar a conta name, primary_poce sales_rep_idpara o Walmart, Target, e Nordstrom.


Use o web_events tabela para encontrar todas as informações sobre indivíduos 
que foram contactados através do canal de organicou adwords.*/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');



/*Use a tabela de contas para encontrar o nome da conta, ponto de venda principal e id do representante de vendas para todas as lojas, 
exceto Walmart, Target e Nordstrom.

Use a tabela web_events para encontrar todas as informações sobre os indivíduos que foram contatados por qualquer método, 
exceto usando os métodos organicou adwords.

Use a tabela de contas para encontrar:

Todas as empresas cujos nomes não começam com 'C'.

Todas as empresas cujos nomes não contêm a string 'um' em algum lugar do nome.

Todas as empresas cujos nomes não terminam com 's*/


SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Wallmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT name
from accounts
WHERE name NOT LIKE ('%C%')

SELECT name
from accounts
WHERE name NOT LIKE ('%one%')

SELECT name
from accounts
WHERE name NOT LIKE ('%s%')


/*Escreva uma consulta que retorne todos os pedidos em que o standard_qtyseja superior a 1000, o poster_qtyseja 0 e o gloss_qtyseja 0.

Usando a tabela de contas , encontre todas as empresas cujos nomes não começam com 'C' e terminam com 's'.

Quando você usa o operador BETWEEN em SQL, os resultados incluem os valores de seus pontos de extremidade ou não? 
Descubra a resposta a essa pergunta importante escrevendo uma consulta que exibe a data e os gloss_qtydados do pedido 
para todos os pedidos em que gloss_qty está entre 24 e 29. Em seguida, observe sua saída para ver se o operador BETWEEN incluiu os 
valores inicial e final ou não.

Use a tabela web_events para encontrar todas as informações sobre os indivíduos que foram contatados 
por meio dos canais organicou adwordse iniciaram suas contas em qualquer momento em 2016, classificados do mais novo ao mais antigo.
*/


SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

SELECT occurred_at, gloss_qty 
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29 
ORDER BY gloss_qty;

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') 
AND occurred_at 
BETWEEN '2016-01-01' AND '2017-01-01' /*time_stamp*/
ORDER BY occurred_at DESC;


/*Encontre a lista de IDs de pedidos em que gloss_qtyou poster_qtyseja maior que 4000. Inclua apenas o idcampo na tabela resultante.


Escreva uma consulta que retorne uma lista de pedidos em que standard_qtyé zero e gloss_qtyou poster_qtyé maior que 1000.


Encontre todos os nomes de empresas que começam com 'C' ou 'W', e o contato principal contém 'ana' ou 'Ana', mas não contém 'eana'.*/

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT * 
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

SELECT name, primary_poc
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
    AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
    AND primary_poc NOT LIKE '%eana%');