#!/bin/bash
# Sobe o site (porta 5157). Para a Api (porta 5218) use: bash rodar-api.sh
export ASPNETCORE_ENVIRONMENT=Development
# O Codespaces entrega o site por um proxy HTTPS; isto faz o app respeitar o cabecalho X-Forwarded-Proto
export ASPNETCORE_FORWARDEDHEADERS_ENABLED=true
export ASPNETCORE_URLS=http://0.0.0.0:5157
dotnet run --project Sunset.Web --no-launch-profile
