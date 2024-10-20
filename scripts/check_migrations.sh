#!/bin/bash

SQL_DIRS=("./migrations/oracle" "./migrations/mssql" "./migrations/postgres")

git fetch origin main

arquivos_main=$(git ls-tree -r --name-only origin/main $DIR | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$')
erro_encontrado=false  # Flag para indicar se houve erro

echo -e "Arquivos na branch main:\n$(echo "$arquivos_main" | tail -n 10)\n"

for DIR in "${SQL_DIRS[@]}"
do
    echo -e "\nVerificando duplicidade na pasta: $DIR"

    # Listar apenas os nomes dos arquivos sem o caminho
    arquivos_atual=$(git ls-tree -r --name-only HEAD $DIR | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$')

    echo -e "Arquivos na branch atual:\n$(echo "$arquivos_atual" | tail -n 10)\n"

    # Extrair os números diretamente dos nomes dos arquivos
    numeros_main=$(echo "$arquivos_main" | sed -E 's/^([0-9]+)-.*/\1/' | sort -u)
    numeros_atual=$(echo "$arquivos_atual" | sed -E 's/^([0-9]+)-.*/\1/' | sort)

    # Inicializar uma lista para armazenar números duplicados
    declare -A duplicados_map

    # Verificar duplicatas apenas nos novos arquivos
    for numero in $numeros_atual; do
        # Contar quantas vezes o número aparece na branch atual
        count_atual=$(echo "$numeros_atual" | grep -o "$numero" | wc -l)

        # Se o número também estiver na branch main e aparece mais de uma vez na branch atual
        if echo "$numeros_main" | grep -q -F "$numero" && [ "$count_atual" -gt 1 ]; then
            duplicados_map["$numero"]=1  # Adiciona o número como chave no array associativo
        fi
    done

    # Converte as chaves do array associativo em uma lista de números duplicados
    duplicados=("${!duplicados_map[@]}")

    if [ ${#duplicados[@]} -gt 0 ]; then
        echo "Erro: Arquivos com numeração duplicada encontrados na pasta $DIR!"
        echo "Números duplicados: ${duplicados[*]}"

        # Listar apenas os novos arquivos que causaram a duplicação
        for numero in "${duplicados[@]}"; do
            # Filtrar apenas os arquivos da branch atual que possuem a numeração duplicada
            arquivos_duplicados=$(echo "$arquivos_atual" | grep "^$numero-")
            if [ -n "$arquivos_duplicados" ]; then
                echo "Arquivos duplicados para o número $numero:"
                echo "$arquivos_duplicados" | sort -u
                echo
            fi
        done

        erro_encontrado=true  # Define o flag como verdadeiro
    else
        echo "Nenhuma duplicidade encontrada na pasta $DIR."
    fi
done

# Verifica se algum erro foi encontrado
if [ "$erro_encontrado" = true ]; then
    echo "Erro: Um ou mais erros de duplicidade foram encontrados."
    exit 1  # Para a execução da pipeline
else
    echo "Verificação concluída com sucesso. Pronto para enviar."
fi