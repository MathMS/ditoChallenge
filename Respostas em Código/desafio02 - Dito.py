# Realizando importações
import csv
import matplotlib.pyplot as plt
import pandas

# Lendo o arquivo inicialmente
with open('../Arquivos/sto_challenge.csv', "r") as file_read:
    reader = csv.reader(file_read)
    data_list = list(reader)

# Verificando o número de linhas do arquivo
print(f"Número de linhas do arquivo: {len(data_list)}\n")

# Imprimindo o cabeçalho para ver se retorna os dados corretos
print(f"Cabeçalho {data_list[0]}\n")

# Criei uma função para adicionar as colunas de uma lista em outra lista, na mesma ordem
def column_to_list(data, index):
    column_list = [column[index] for column in data]
    return column_list

# Vamos checar com as actions se a função está funcionando (apenas para os primeiros 10)
print("Imprimindo a lista de actions das primeiras 20 amostras apenas para testar a função")
print(column_to_list(data_list, -1)[1:11])

# Contando o número de actions diferentes.
open = 0
unsubscribe = 0
click = 0
spamreport = 0
received = 0


column_list = column_to_list(data_list, -1)

for column in column_list:
    if column == "open":
        open += 1
    elif column == "unsubscribe":
        unsubscribe += 1
    elif column == "click":
        click += 1
    elif column == "spamreport":
        spamreport += 1
    elif column == "received":
        received += 1

# Verificando o resultado
print("\nImprimindo o número de actions diferentes: ")
print("received: ", received)
print("open: ", open)
print("click: ", click)
print("unsubscribe: ", unsubscribe)
print("spamreport: ", spamreport)

#Verificando a taxa de abertura atual
'''Taxa de abertura é o número de pessoas que abriu a mensagem dividido pelo número de
pessoas que recebeu a mensagem.'''
taxa_abertura = open/received

print(f'\nA taxa de abertura hoje gira em torno de {taxa_abertura:.2f}')

