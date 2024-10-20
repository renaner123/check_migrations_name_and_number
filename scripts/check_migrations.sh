#!/bin/bash

SQL_DIRS=("./migrations/oracle" "./migrations/mssql" "./migrations/postgres")

git fetch origin main

# Obter arquivos da branch main uma vez
arquivos_main=$(git ls-tree -r --name-only origin/main | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$' | sort -u)
echo -e "Arquivos na branch main:\n$(echo "$arquivos_main" | tail -n 10)\n"

# Extrair números da branch main
numeros_main=$(echo "$arquivos_main" | sed -E 's/^([0-9]+)-.*/\1/' | sort -u)

# Inicializar uma variável para indicar se houve erro
erro_duplicidade=false

for DIR in "${SQL_DIRS[@]}"; do
    echo -e "\nVerificando duplicidade na pasta: $DIR"

    if [ ! -d "$DIR" ]; then
        echo "Erro: O diretório $DIR não existe."
        continue
    fi

    # Listar apenas os nomes dos arquivos sem o caminho
    arquivos_atual=$(git ls-tree -r --name-only HEAD $DIR | sed 's|.*/||' | grep -E '^[0-9]+-.*\.sql$')

    echo -e "Arquivos na branch atual:\n$(echo "$arquivos_atual" | tail -n 10)\n"

    # Extrair números da branch atual
    numeros_atual=$(echo "$arquivos_atual" | sed -E 's/^([0-9]+)-.*/\1/' | sort)

    # Inicializar uma lista para armazenar números duplicados
    duplicados=()

    # Verificar duplicatas apenas nos novos arquivos
    for numero in $numeros_atual; do
        # Contar quantas vezes o número aparece na branch atual
        count_atual=$(echo "$numeros_atual" | grep -o "$numero" | wc -l)

        # Se o número também estiver na branch main e aparece mais de uma vez na branch atual
        if echo "$numeros_main" | grep -q -F "$numero" && [ "$count_atual" -gt 1 ]; then
            duplicados+=("$numero")
        fi
    done

    # Remover duplicados na lista
    duplicados=($(echo "${duplicados[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

    if [ ${#duplicados[@]} -gt 0 ]; then
        echo "Erro: Arquivos com numeração duplicada encontrados na pasta $DIR!"

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

        # Definir a variável de erro
        erro_duplicidade=true
    else
        echo "Nenhuma duplicidade encontrada na pasta $DIR."
    fi
done

# Verificar se houve erro
if [ "$erro_duplicidade" = true ]; then
    echo "Erro: Um ou mais erros de duplicidade foram encontrados."
    exit 1
else
    echo "Verificação concluída com sucesso. Pronto para enviar."
fi