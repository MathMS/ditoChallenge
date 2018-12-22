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

#Aqui realizei o count de quantas vezes a pessoa comprou
comprasTotais AS (SELECT COUNT(id) comprasTotal, id
FROM `dito-data-scientist-challenge.tracking.dito` 
WHERE properties.action = 'buy'
GROUP BY id),

#Calculando a média de cada pessoa por quantas compras ela faz em um intervalo de tempo (Considerando mais de uma compra por dia)
mediaTotal1 AS (SELECT DISTINCT(t1.id), (diferencaDatas.diferencaDias/comprasTotais.comprasTotal) media, comprasTotais.comprasTotal, diferencaDatas.diferencaDias
FROM `dito-data-scientist-challenge.tracking.dito` t1
JOIN comprasTotais ON t1.id = comprasTotais.id
JOIN diferencaDatas ON t1.id = diferencaDatas.id
ORDER BY media)

SELECT APPROX_QUANTILES(media,1000)[OFFSET(500)] mediana
FROM mediaTotal1
