WITH

#Aqui eu selecionei todas as pessoas que existem no cadastro
pessoas AS (SELECT id
FROM `dito-data-scientist-challenge.tracking.dito`
WHERE properties.action = 'buy'
GROUP BY id),

#Aqui eu olho a diferença em dias da primeira compra com a ultima
diferencaDatas AS (SELECT DISTINCT(t1.id), TIMESTAMP_DIFF(MAX(timestamp), MIN(timestamp), day) diferencaDias
FROM `dito-data-scientist-challenge.tracking.dito` t1
INNER JOIN pessoas ON t1.id = pessoas.id
WHERE properties.action = 'buy'
GROUP BY id),

#Aqui eu realizo a conversão do timestamp para data
diasDeCompra AS (SELECT CAST(timestamp AS DATE) data
FROM `dito-data-scientist-challenge.tracking.dito` t1
JOIN pessoas ON t1.id = pessoas.id
WHERE properties.action = 'buy'
GROUP BY data),

#Realizo aqui o count de quantos dias ele comprou
contadorDias AS (SELECT COUNT(data) contador
FROM diasdeCompra),

#Calculando a média de cada pessoa por quantas compras ela faz em um intervalo de tempo (Considerando mais de uma compra por dia)
mediaTotal2 AS (SELECT DISTINCT(t1.id), (diferencaDatas.diferencaDias/contadorDias.contador) media, contadorDias.contador, diferencaDatas.diferencaDias
FROM `dito-data-scientist-challenge.tracking.dito` t1
JOIN contadorDias ON t1.id = contadorDias.id
JOIN diferencaDatas ON t1.id = diferencaDatas.id
ORDER BY media)

SELECT * FROM mediaTotal2

--SELECT APPROX_QUANTILES(media,1000)[OFFSET(500)] mediana
--FROM mediaTotal1

