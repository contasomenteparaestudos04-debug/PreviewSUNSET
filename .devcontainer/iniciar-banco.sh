#!/bin/bash
# Cria o banco Sunset e roda os scripts SQL (so na primeira vez).
SQL="/opt/mssql-tools18/bin/sqlcmd -C -S db -U sa -P $MSSQL_SA_PASSWORD -I"

$SQL -Q "IF DB_ID('Sunset') IS NULL CREATE DATABASE Sunset" || exit 1

TEM=$($SQL -d Sunset -h -1 -W -Q "SET NOCOUNT ON; SELECT COUNT(*) FROM sys.tables WHERE name = 'Usuario'" | tr -d '[:space:]')
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

$SQL -d Sunset -b -i /tmp/script_banco.sql || { echo "ERRO no script_banco.sql"; exit 1; }
$SQL -d Sunset -b -i /banco/dados_exemplo.sql || { echo "ERRO no dados_exemplo.sql"; exit 1; }
echo "Banco criado com dados de exemplo."
