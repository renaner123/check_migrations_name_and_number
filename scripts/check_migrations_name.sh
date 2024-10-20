#!/bin/bash

SQL_DIRS=("./migrations/oracle" "./migrations/mssql" "./migrations/postgres")

# Indicar se houve erro
erro_duplicidade=false

for DIR in "${SQL_DIRS[@]}"; do
    echo -e "\nVerificando duplicidade de nomes na pasta: $DIR"

    if [ ! -d "$DIR" ]; then
        echo "Erro: O diretório $DIR não existe."
        continue
    fi

    # Listar apenas os nomes dos arquivos sem o caminho
    arquivos_atual=$(git ls-tree -r --name-only HEAD $DIR | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$')

    echo -e "Arquivos na branch atual:\n$arquivos_atual\n"

    # Lista para armazenar nomes duplicados
    duplicados=()

    # Verificar duplicidade nos arquivos da branch atual
    for arquivo in $arquivos_atual; do
        # Extrair o nome sem o número
        nome="${arquivo#*-}"

        # Contar quantas vezes o nome aparece na lista
        count_nome=$(echo "$arquivos_atual" | grep -o "$nome" | wc -l)

        # Se o nome aparece mais de uma vez, é considerado duplicado
        if [ "$count_nome" -gt 1 ]; then
            duplicados+=("$nome")
        fi
    done

    # Remover duplicados na lista
    duplicados=($(echo "${duplicados[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

    if [ ${#duplicados[@]} -gt 0 ]; then
        echo "Erro: Arquivos com nomes duplicados encontrados na pasta $DIR!"
        echo "Nomes duplicados: ${duplicados[*]}"
        erro_duplicidade=true
    else
        echo "Nenhuma duplicidade de nomes encontrada na pasta $DIR."
    fi
done

# Verificar se houve erro
if [ "$erro_duplicidade" = true ]; then
    echo "Erro: Um ou mais erros de duplicidade de nomes foram encontrados."
    exit 1
else
    echo "Verificação de nomes concluída com sucesso. Pronto para enviar."
fi
