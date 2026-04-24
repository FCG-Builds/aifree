@echo off
REM AIFREE - Free Local AI Coding Assistant
REM No API keys. No cloud. No cost. Just your GPU.
REM https://github.com/FCG-builds/aifree

REM Load config if exists
if exist "%~dp0config.env" (
    for /f "usebackq tokens=1,2 delims==" %%A in ("%~dp0config.env") do (
        if not "%%A"=="" set "%%A=%%B"
    )
)

REM Defaults
if not defined OLLAMA_HOST set OLLAMA_HOST=http://127.0.0.1:11434
if not defined MODEL set MODEL=deepseek-coder-v2:16b
if not defined SYSTEM_PROMPT set SYSTEM_PROMPT=%~dp0system-prompt.md
if not defined PROJECT_NAME set PROJECT_NAME=AIFREE

echo.
echo   AIFREE - Local AI Coding Assistant
echo   Free as in freedom. Free as in beer.
echo.

REM Check Ollama
echo [%PROJECT_NAME%] Checking Ollama at %OLLAMA_HOST%...
curl -s %OLLAMA_HOST%/api/tags >nul 2>&1
if %errorlevel% neq 0 (
    echo [%PROJECT_NAME%] Ollama not running. Starting...
    start /B ollama serve
    timeout /t 5 /nobreak >nul
    curl -s %OLLAMA_HOST%/api/tags >nul 2>&1
    if %errorlevel% neq 0 (
        echo [%PROJECT_NAME%] ERROR: Ollama not found.
        echo          Install: https://ollama.com/download
        pause
        exit /b 1
    )
)
echo [%PROJECT_NAME%] Ollama connected.

REM Check model
echo [%PROJECT_NAME%] Model: %MODEL%
ollama list 2>nul | findstr /i "%MODEL%" >nul 2>&1
if %errorlevel% neq 0 (
    echo [%PROJECT_NAME%] Pulling %MODEL% (first run only)...
    ollama pull %MODEL%
)

REM GPU info
echo.
nvidia-smi --query-gpu=name,memory.total,memory.free --format=csv,noheader 2>nul
if %errorlevel% neq 0 (
    echo [%PROJECT_NAME%] No NVIDIA GPU detected - running on CPU.
) else (
    echo [%PROJECT_NAME%] GPU acceleration active.
)

REM Launch
echo.
echo [%PROJECT_NAME%] Launching aider...
echo.

if exist "%SYSTEM_PROMPT%" (
    aider --model ollama/%MODEL% --read "%SYSTEM_PROMPT%" --no-auto-commits
) else (
    aider --model ollama/%MODEL% --no-auto-commits
)
