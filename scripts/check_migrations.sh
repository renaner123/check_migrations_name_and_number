#!/bin/bash

SQL_DIRS=("./migrations/oracle" "./migrations/mssql" "./migrations/postgres")

# Verifica os arquivos presentes na branch main
git fetch origin main

for DIR in "${SQL_DIRS[@]}"
do
    echo "Verificando duplicidade na pasta: $DIR"
  
    # Verifica os arquivos presentes na branch main
    arquivos_main=$(git ls-tree -r --name-only origin/main $DIR | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$')

    echo -e "Arquivos na branch main:\n$arquivos_main"

    # Verifica os arquivos presentes na branch atual
    arquivos_atual=$(git ls-tree -r --name-only HEAD $DIR | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$')

    echo -e "Arquivos na branch atual:\n$arquivos_atual \n"

    # Extrai os prefixos numéricos dos arquivos
    numeros_main=$(echo "$arquivos_main" | sed -E 's/^([0-9]+)-.*/\1/' | sort -u)
    numeros_atual=$(echo "$arquivos_atual" | sed -E 's/^([0-9]+)-.*/\1/' | sort -u)

    # Verifica se há duplicatas
    duplicados=$(echo "$numeros_atual" | grep -Fxf <(echo "$numeros_main"))

    if [ -n "$duplicados" ]; then
        echo "Erro: Arquivos com numeração duplicada encontrados na pasta $DIR!"
        echo "Números duplicados: $duplicados"

        # Listar os arquivos que causaram a duplicação
        for numero in $duplicados; do
            echo "Arquivos duplicados para o número $numero:"
            echo "$arquivos_atual" | grep "^$numero-"
        done

        exit 1
    else
        echo "Nenhuma duplicidade encontrada na pasta $DIR."
    fi
done

echo "Verificação concluída com sucesso. Pronto para enviar."
