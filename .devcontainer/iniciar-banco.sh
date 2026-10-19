#!/bin/bash
# Cria o banco Sunset e roda os scripts SQL (só na primeira vez).
SQL="/opt/mssql-tools18/bin/sqlcmd -C -S db -U sa -P $MSSQL_SA_PASSWORD -I -f 65001"

$SQL -Q "IF DB_ID('Sunset') IS NULL CREATE DATABASE Sunset" || exit 1

TEM=$($SQL -d Sunset -h -1 -W -Q "SET NOCOUNT ON; SELECT COUNT(*) FROM sys.tables WHERE name = 'Usuario'" | tr -d '[:space:]')
if [ "$TEM" = "1" ]; then
  echo "Banco ja estava pronto."
  exit 0
fi

$SQL -d Sunset -b -i /banco/script_banco.sql || exit 1
$SQL -d Sunset -b -i /banco/dados_exemplo.sql || exit 1
echo "Banco criado com dados de exemplo."
