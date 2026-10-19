#!/bin/bash
# Cria o banco Sunset e roda os scripts SQL (so na primeira vez).
# Tudo que acontece vai para /repo/dbinit.log (na raiz do projeto no Codespace).
# Este script sempre termina com sucesso, para nao impedir o Codespace de abrir;
# se o banco nao estiver pronto, leia o dbinit.log.
exec > /repo/dbinit.log 2>&1
echo "inicio: $(date)"
ls -la /opt/mssql-tools18/bin/ /banco /iniciar-banco.sh

SQL="/opt/mssql-tools18/bin/sqlcmd -C -S db -U sa -P $MSSQL_SA_PASSWORD -I"

# espera o SQL Server aceitar conexao
for i in $(seq 1 30); do
  $SQL -Q "SELECT 1" > /dev/null 2>&1 && break
  echo "aguardando o SQL Server ($i)..."; sleep 2
done

$SQL -Q "IF DB_ID('Sunset') IS NULL CREATE DATABASE Sunset" || { echo "ERRO ao criar o banco"; exit 0; }

TEM=$($SQL -d Sunset -h -1 -W -Q "SET NOCOUNT ON; SELECT COUNT(*) FROM sys.tables WHERE name = 'Usuario'" | tr -d '[:space:]')
echo "tabela Usuario existe? [$TEM]"
if [ "$TEM" = "1" ]; then
  echo "Banco ja estava pronto."
  exit 0
fi

# O script_banco.sql tem CREATE TRIGGER e CREATE PROCEDURE sem GO antes, e o SQL Server
# exige que eles comecem um lote novo. Aqui tiramos o BOM e colocamos o GO que falta
# (so na copia de preview; o arquivo original nao e alterado).
sed '1s/^\xEF\xBB\xBF//' /banco/script_banco.sql \
  | awk '/^CREATE (TRIGGER|PROCEDURE)/ || /^INSERT INTO Usuario/ { print "GO" } { print }' \
  > /tmp/script_banco.sql

$SQL -d Sunset -b -i /tmp/script_banco.sql || { echo "ERRO no script_banco.sql"; exit 0; }
$SQL -d Sunset -b -i /banco/dados_exemplo.sql || { echo "ERRO no dados_exemplo.sql"; exit 0; }
echo "Banco criado com dados de exemplo."
exit 0
