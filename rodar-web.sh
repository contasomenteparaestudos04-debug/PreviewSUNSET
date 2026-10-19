#!/bin/bash
# Sobe o site (porta 5157). Para a Api (porta 5218) use: bash rodar-api.sh
export ASPNETCORE_ENVIRONMENT=Development
export ASPNETCORE_URLS=http://0.0.0.0:5157
dotnet run --project Sunset.Web --no-launch-profile
