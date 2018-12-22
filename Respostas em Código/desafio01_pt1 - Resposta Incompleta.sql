WITH 

#Aqui eu pego a última data tem os dados identify
ultimaDataDados AS (SELECT MAX(timestamp) ultimaData, id 
FROM `dito-data-scientist-challenge.tracking.dito` 
WHERE type='identify'
GROUP BY id),

#Aqui eu pego os dados da ultima atualização
ultimosDados AS (SELECT traits.name nome, traits.email email, traits.phone telefone, t1.id
FROM `dito-data-scientist-challenge.tracking.dito` t1
JOIN ultimaDataDados ON t1.id = ultimaDataDados.id
WHERE type='identify' AND timestamp = ultimaDataDados.ultimaData),

#Aqui eu pego os maiores compradores
maioresCompradores AS (SELECT SUM(properties.revenue) totalGasto, id
FROM `dito-data-scientist-challenge.tracking.dito`
GROUP BY id
ORDER BY totalGasto DESC LIMIT 5)

#Query Final
SELECT ultimosDados.nome, ultimosDados.email, ultimosDados.telefone
FROM maioresCompradores
JOIN ultimosDados ON maioresCompradores.id = ultimosDados.id
ORDER BY maioresCompradores.totalGasto DESC