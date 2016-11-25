@echo off
setlocal enableDelayedExpansion
set DIR=%~dp0
cd %DIR%

if not defined HOST (
	for /f "tokens=1,2 delims=:" %%i in ("%DIR%") do set HOST=//%%i%%j
	set HOST=!HOST:\=/!
)

docker-compose %*
