@echo off
setlocal

for /f "tokens=1,2 delims==" %%i in (.env) do (
	if %%i == COMPOSE_PROJECT_NAME set COMPOSE_PROJECT_NAME=%%j
)

call dock up -d
docker exec -ti %COMPOSE_PROJECT_NAME%_shell_1 /bin/bash
