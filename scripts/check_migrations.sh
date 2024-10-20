#!/bin/bash

SQL_DIRS=("migrations/oracle" "migrations/mssql" "migrations/postgres")

# Verifica os arquivos presentes na branch main
git fetch origin main

for DIR in "${SQL_DIRS[@]}"
do
    echo "Verificando duplicidade na pasta: $DIR"

    # Verifica os arquivos presentes na branch main
    arquivos_main=$(git ls-tree -r --name-only origin/main $DIR | grep -E '^[0-9]+-.*\.sql$')

    # Verifica os arquivos presentes na branch atual
    arquivos_atual=$(git ls-tree -r --name-only HEAD $DIR | grep -E '^[0-9]+-.*\.sql$')

    # Extrai os prefixos numéricos dos arquivos
    numeros_main=$(echo "$arquivos_main" | grep -oE '^[0-9]+')
    numeros_atual=$(echo "$arquivos_atual" | grep -oE '^[0-9]+')

    # Verifica se há duplicatas
    duplicados=$(echo "$numeros_atual" | grep -Fxf <(echo "$numeros_main"))

    if [ -n "$duplicados" ]; then
        echo "Erro: Arquivos com numeração duplicada encontrados na pasta $DIR!"
        echo "Números duplicados: $duplicados"
        exit 1
    else
        echo "Nenhuma duplicidade encontrada na pasta $DIR."
    fi
done

echo "Verificação concluída com sucesso. Pronto para enviar."
