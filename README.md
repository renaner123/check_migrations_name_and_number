# Verificação de nomes e números de Migrações SQL

Este repositório contém scripts para verificar duplicidades em arquivos de migração SQL em diferentes pastas. Os scripts são executados automaticamente em pull requests para a branch `main` do repositório.

## Scripts

### 1. `check_migrations_number.sh`

**Finalidade**: Este script verifica se há duplicidades nos números dos arquivos de migração SQL nas pastas especificadas. Se um número de arquivo já existir na branch principal e houver múltiplas ocorrências na branch atual, o script emitirá um erro.

**Uso**:
- O script é chamado automaticamente quando um pull request é aberto para a branch `main`. 
- Ele busca arquivos nas seguintes pastas:
  - `./migrations/oracle`
  - `./migrations/mssql`
  - `./migrations/postgres`

Exemplo de saída do script:

```
Arquivos na branch main:
001-criar-tabela-sala.sql
002-criar-tabela-aula.sql


Verificando duplicidade na pasta: ./migrations/oracle
Arquivos na branch atual:
001-criar-tabela-sala.sql
002-criar-tabela-aula.sql
002-criar-tabela-pessoa.sql

Erro: Arquivos com numeração duplicada encontrados na pasta ./migrations/oracle!
Arquivos duplicados para o número 002:
002-criar-tabela-aula.sql
002-criar-tabela-pessoa.sql

Verificando duplicidade na pasta: ./migrations/mssql
Arquivos na branch atual:
001-criar-tabela-sala.sql
002-criar-tabela-aula.sql
002-criar-tabela-pessoa.sql

Erro: Arquivos com numeração duplicada encontrados na pasta ./migrations/mssql!
Arquivos duplicados para o número 002:
002-criar-tabela-aula.sql
002-criar-tabela-pessoa.sql

Verificando duplicidade na pasta: ./migrations/postgres
Arquivos na branch atual:
001-criar-tabela-sala.sql
002-criar-tabela-aula.sql
003-criar-tabela-pessoa.sql
004-criar-tabela-janela.sql
005-criar-tabela-endereco.sql

Nenhuma duplicidade encontrada na pasta ./migrations/postgres.
Verificação concluída com sucesso. Pronto para enviar.

Erro: Um ou mais erros de duplicidade foram encontrados.
```

### 2. `check_migrations_name.sh`

**Finalidade**: Este script verifica se há duplicidades nos nomes dos arquivos de migração SQL nas pastas especificadas. Se o nome, independente da numeração, de um arquivo aparecer mais de uma vez na branch atual, o script emitirá um erro.

**Uso**:
- O script também é chamado automaticamente em pull requests para a branch `main`. 
- Ele realiza a mesma verificação de pastas que o script anterior.

Exemplo de saída do script:

```
Verificando duplicidade de nomes na pasta: ./migrations/oracle
Arquivos na branch atual:
001-criar-tabela-sala.sql
002-criar-tabela-aula.sql
003-criar-tabela-pessoa.sql

Nenhuma duplicidade de nomes encontrada na pasta ./migrations/oracle.

Verificando duplicidade de nomes na pasta: ./migrations/mssql
Arquivos na branch atual:
001-criar-tabela-sala.sql
002-criar-tabela-aula.sql
003-criar-tabela-pessoa.sql

Nenhuma duplicidade de nomes encontrada na pasta ./migrations/mssql.

Verificando duplicidade de nomes na pasta: ./migrations/postgres
Arquivos na branch atual:
001-criar-tabela-sala.sql
002-criar-tabela-aula.sql
003-criar-tabela-pessoa.sql
004-criar-tabela-janela.sql
005-criar-tabela-janela.sql

Erro: Arquivos com nomes duplicados encontrados na pasta ./migrations/postgres!
Nomes duplicados: criar-tabela-janela.sql
Erro: Um ou mais erros de duplicidade de nomes foram encontrados.
```

## Como Funciona

1. Ao abrir um pull request para a branch `main`, o GitHub Actions executa o workflow definido.
2. O código é verificado com a ação `checkout`.
3. Os dois scripts são executados na ordem:
   - Primeiro, `check_migrations_number.sh`, que verifica a duplicidade de números.
   - Em seguida, `check_migrations_name.sh`, que verifica a duplicidade de nomes.
4. Se algum dos scripts encontrar erros, o pull request será sinalizado, e o trabalho falhará.

## Estrutura do Repositório

```
└───workflow-tests
    ├───.github
    │   └───workflows
    ├───migrations
    │   ├───mssql
    │   ├───oracle
    │   └───postgres
    └───scripts
```

## Contribuições

Sinta-se à vontade para contribuir com melhorias e correções nos scripts ou na documentação.
