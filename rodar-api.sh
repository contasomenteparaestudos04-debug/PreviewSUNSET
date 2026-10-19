#!/bin/bash
export ASPNETCORE_ENVIRONMENT=Development
export ASPNETCORE_URLS=http://0.0.0.0:5218
dotnet run --project Sunset.Api --no-launch-profile
