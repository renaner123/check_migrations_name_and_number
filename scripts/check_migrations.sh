#!/bin/bash

SQL_DIRS=("./migrations/oracle" "./migrations/mssql" "./migrations/postgres")

git fetch origin main

for DIR in "${SQL_DIRS[@]}"
do
    echo -e "\nVerificando duplicidade na pasta: $DIR"

    # Listar apenas os nomes dos arquivos sem o caminho
    arquivos_main=$(git ls-tree -r --name-only origin/main $DIR | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$')
    arquivos_atual=$(git ls-tree -r --name-only HEAD $DIR | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$')

    echo -e "Arquivos na branch main:\n$arquivos_main"
    echo -e "Arquivos na branch atual:\n$arquivos_atual"

    # Extrair os números diretamente dos nomes dos arquivos
    numeros_main=$(echo "$arquivos_main" | sed -E 's/^([0-9]+)-.*/\1/' | sort -u)
    numeros_atual=$(echo "$arquivos_atual" | sed -E 's/^([0-9]+)-.*/\1/' | sort -u)

    echo -e "Números main:\n$numeros_main"
    echo -e "Números atual:\n$numeros_atual"

    # Verificar duplicatas apenas nos novos arquivos
    duplicados=$(echo "$numeros_atual" | grep -Fxf <(echo "$numeros_main"))

    if [ -n "$duplicados" ]; then
        echo "Erro: Arquivos com numeração duplicada encontrados na pasta $DIR!"
        echo "Números duplicados: $duplicados"

        # Listar apenas os novos arquivos que causaram a duplicação
        for numero in $duplicados; do
            arquivos_duplicados=$(echo "$arquivos_atual" | grep "^$numero-" | grep -v -F -x -f <(echo "$arquivos_main"))
            if [ -n "$arquivos_duplicados" ]; then
                echo "Arquivos duplicados para o número $numero:"
                echo "$arquivos_duplicados"
            fi
        done

        exit 1
    else
        echo "Nenhuma duplicidade encontrada na pasta $DIR."
    fi
done

echo "Verificação concluída com sucesso. Pronto para enviar."