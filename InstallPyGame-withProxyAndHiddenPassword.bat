@echo off

REM Autor: Lucas Rocini
REM Script: InstallPyGame.bat
REM Versão LAR 1.1

::Script para setar user e senha no proxy e instalar o PYGAME

echo .
echo .
echo Versao: LAR 1.0
echo Script para setar user e senha no proxy e instalar o PYGAME
echo .
echo .

::Prompt ao usuário para prosseguir
set /p resp=Deseja continuar? (pressione ENTER para prosseguir, digite N ou n para cancelar)
if /i "%resp%" EQU "N" goto encerra
if /i "%resp%" EQU "n" goto encerra
if /i "%resp%" NEQ "N" goto prossiga
:encerra
echo .
echo  O script sera encerrado.
echo .
pause
exit /b

:prossiga
echo ****** Iniciando Script... ******
echo .
timeout 1 > NUL
echo .
timeout 1 > NUL
echo .

::set Endereco_Proxy=proxylab2.uniararas.br:8080
set Endereco_Proxy=172.22.0.252:8080

set /p RA_Usuario=Insira seu RA (exemplo: 102465): 

::Inserir senha com máscara
   SetLocal DisableDelayedExpansion
   Echo Insira sua senha abaixo: 
   Set "Senha_Usuario="
   Rem Save 0x08 character in BS variable
   For /F %%# In (
   '"Prompt;$H&For %%# in (1) Do Rem"'
   ) Do Set "BS=%%#"
   :HILoop
   Set "Key="
   For /F "delims=" %%# In (
   'Xcopy /W "%~f0" "%~f0" 2^>Nul'
   ) Do If Not Defined Key Set "Key=%%#"
   Set "Key=%Key:~-1%"
   SetLocal EnableDelayedExpansion
   If Not Defined Key Goto :HIEnd
   If %BS%==^%Key% (Set /P "=%BS% %BS%" <Nul
   Set "Key="
   If Defined Senha_Usuario Set "Senha_Usuario=!Senha_Usuario:~0,-1!"
   ) Else Set /P "=*" <Nul
   If Not Defined Senha_Usuario (EndLocal &Set "Senha_Usuario=%Key%"
   ) Else For /F delims^=^ eol^= %%# In (
   "!Senha_Usuario!") Do EndLocal &Set "Senha_Usuario=%%#%Key%" 
   Goto :HILoop

:HIEnd

echo .
::echo RA_Usuario = %RA_Usuario%
::echo Senha_Usuari = %Senha_Usuario%
echo .

::set http_proxy=http://%RA_Usuario%:%Senha_Usuario%@%Endereco_Proxy%
set https_proxy=https://%RA_Usuario%:%Senha_Usuario%@%Endereco_Proxy%
echo .

::echo %http_proxy%
::echo %https_proxy%
echo .

::Instalando o PYGAME...
echo Instalando o PYGAME...
::pip install pygame > nul 2>nul
::pip install --proxy %http_proxy% pygame > nul 2>nul
pip install --proxy %https_proxy% pygame

IF %ERRORLEVEL% EQU 0 (echo 	pygame instalado com SUCESSO!) ELSE (echo 	ATENCAO Ocorreu algum erro !!!)
echo .

::Limpando variaveis
echo Limpando variaveis...
set RA_Usuario=000000
set Senha_Usuario=xxxxxxxxxx
::set http_proxy=http://%RA_Usuario%:%Senha_Usuario%@%Endereco_Proxy%
set https_proxy=https://%RA_Usuario%:%Senha_Usuario%@%Endereco_Proxy%
echo 	Variaveis limpas com SUCESSO!

echo .
::echo RA_Usuario = %RA_Usuario%
::echo Senha_Usuari = %Senha_Usuario%
::echo .
::echo http_proxy = %http_proxy%
::echo https_proxy = %https_proxy%
echo .

echo .
echo .
::Prompt ao usuário para testar
set /p resp2=Deseja testar o PYGAME agora? (pressione ENTER para prosseguir, digite N ou n para cancelar)
if /i "%resp2%" EQU "N" goto encerra2
if /i "%resp2%" EQU "n" goto encerra2
if /i "%resp2%" NEQ "N" goto prossiga2
:encerra2
echo .
echo  O script sera encerrado.
echo .
pause
exit /b

:prossiga2
echo ****** Iniciando teste... ******
echo .
timeout 1 > NUL
echo .
timeout 1 > NUL
echo .

::Iniciando game "aliens"
echo Iniciando game "aliens"
echo .
timeout 1 > NUL
echo .
timeout 1 > NUL
echo .
::python3 -m pygame.examples.aliens
python -m pygame.examples.aliens

echo .
timeout 1 > NUL
echo .
timeout 1 > NUL
echo .
echo ********** Script Finalizado com SUCESSO. **********
echo .
echo .

pause