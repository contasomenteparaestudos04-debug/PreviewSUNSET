#!/bin/bash
export ASPNETCORE_ENVIRONMENT=Development
# O Codespaces entrega o site por um proxy HTTPS; isto faz o app respeitar o cabecalho X-Forwarded-Proto
export ASPNETCORE_FORWARDEDHEADERS_ENABLED=true
export ASPNETCORE_URLS=http://0.0.0.0:5218
dotnet run --project Sunset.Api --no-launch-profile
