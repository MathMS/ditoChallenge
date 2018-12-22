WITH 

#Aqui eu pego a última data onde o nome estava atualizado
ultimaDataNome AS (SELECT MAX(timestamp) ultimaData, id 
FROM `dito-data-scientist-challenge.tracking.dito` 
WHERE traits.name IS NOT NULL
AND type='identify'
GROUP BY id),

#Aqui eu pego a última data onde o telefone estava atualizado
ultimaDataTelefone AS (SELECT MAX(timestamp) ultimaData, id 
FROM `dito-data-scientist-challenge.tracking.dito` 
WHERE traits.phone IS NOT NULL 
AND type='identify'
GROUP BY id),

#Aqui eu pego a última data onde o email estava atualizado
ultimaDataEmail AS (SELECT MAX(timestamp) ultimaData, id 
FROM `dito-data-scientist-challenge.tracking.dito` 
WHERE traits.email IS NOT NULL
AND type='identify'
GROUP BY id),

#Aqui eu pego os maiores compradores
maioresCompradores AS (SELECT SUM(properties.revenue) totalGasto, id
FROM `dito-data-scientist-challenge.tracking.dito`
GROUP BY id
ORDER BY totalGasto DESC LIMIT 5),

#Aqui realizo o SELECT que busca os nomes atualizados
nomeAtualizado AS (SELECT traits.name nome, t1.id
FROM `dito-data-scientist-challenge.tracking.dito` t1
JOIN ultimaDataNome ON t1.timestamp = ultimaDataNome.ultimaData),

#Aqui realizo o SELECT que busca os emails atualizados
emailAtualizado AS (SELECT traits.email email, t1.id
FROM `dito-data-scientist-challenge.tracking.dito` t1
JOIN ultimaDataEmail ON t1.timestamp = ultimaDataEmail.ultimaData),

#Aqui realizo o SELECT que busca os telefones atualizados
telefoneAtualizado AS (SELECT traits.phone telefone, t1.id
FROM `dito-data-scientist-challenge.tracking.dito` t1
JOIN ultimaDataTelefone ON t1.timestamp = ultimaDataTelefone.ultimaData)

#Query final ordenando pelos maiores compradores
SELECT nomeAtualizado.nome, emailAtualizado.email, telefoneAtualizado.telefone
FROM maioresCompradores
JOIN nomeAtualizado ON maioresCompradores.id = nomeAtualizado.id
JOIN emailAtualizado ON maioresCompradores.id = emailAtualizado.id
JOIN telefoneAtualizado ON maioresCompradores.id = telefoneAtualizado.id
ORDER BY maioresCompradores.totalGasto DESC
