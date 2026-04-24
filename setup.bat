@echo off
REM AIFREE Setup - One-time install

echo.
echo   AIFREE - First-Time Setup
echo.

REM Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Python not found. Install from https://python.org
    pause & exit /b 1
)
echo [OK] Python found

REM Install aider-chat
echo [..] Installing aider-chat...
pip install aider-chat --break-system-packages >nul 2>&1
if %errorlevel% neq 0 pip install aider-chat --user >nul 2>&1
echo [OK] aider-chat installed

REM Ollama
ollama --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Ollama not installed.
    echo     Download: https://ollama.com/download
    pause & exit /b 1
)
echo [OK] Ollama found

REM Detect GPU and pick models
echo.
echo [..] Detecting GPU...
set GPU_MEM=0
for /f "tokens=*" %%i in ('nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits 2^>nul') do set GPU_MEM=%%i

if %GPU_MEM% GEQ 6000 (
    echo [OK] GPU detected (%GPU_MEM% MB) - pulling coding models
    ollama pull deepseek-coder-v2:16b
    ollama pull codellama:7b
) else (
    echo [!!] Low/no GPU. Pulling compact models
    ollama pull codellama:7b
    ollama pull tinyllama
)

REM Config
if not exist "%~dp0config.env" (
    copy "%~dp0config.env.example" "%~dp0config.env" >nul 2>&1
    echo [OK] Created config.env
)

echo.
echo   Setup complete! Run aifree.bat to start.
pause
