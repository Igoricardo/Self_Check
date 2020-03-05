@ECHO OFF

REM Desativação do Windows Update - CRIADO POR GUSTAVO TRINDADE

IF EXIST UPDATE.LOG DEL UPDATE.LOG
ECHO Executado em: %date% %time% >> C:\applications\self_check\UPDATE.LOG
NET STOP "wuauserv" >> C:\applications\self_check\UPDATE.LOG
SC CONFIG "wuauserv" START= DISABLED >> C:\applications\self_check\UPDATE.LOG

REM ------------------------------------------------------------------------

IF EXIST self_check.log DEL self_check.log

ECHO Data da execução: %DATE% %TIME% >> C:\applications\self_check\self_check.log

REM > VERIFICA O TIPO DA MIDIA DE ARMAZENAMENTO PELO POWERSHELL: SSD OU HDD:
powershell.exe -command "& {Get-PhysicalDisk | Select MediaType}" >> C:\applications\self_check\self_check.log

REM > VERIFICA O TIPO DA MIDIA DE ARMAZENAMENTO PELO CMD: SSD OU HDD ### USAR QUANDO O POWERSHELL NAÕ FUNCIONAR ###:
REM wmic diskdrive list brief /format:list | find "Model" >> C:\applications\self_check\self_check.log

REM > VERIFICA QUAL O MODELO DA CPU:
wmic csproduct list /format |find "Name" >> C:\applications\self_check\self_check.log

REM > VERIFICA SE A INSTALACAO DOS BD MYSQL E POSTEGRE E QUAL ESTA ATIVO:
echo. >> C:\applications\self_check\self_check.log
wmic service get displayname,name,state |find "MySQL" >> C:\applications\self_check\self_check.log
wmic service get displayname,name,state |find "postgresql" >> C:\applications\self_check\self_check.log

REM > VERIFICA O ESTADO DO WINDOWS UPDATE:
echo. >> C:\applications\self_check\self_check.log
wmic service get displayname,name,state |find "Windows Update" >> C:\applications\self_check\self_check.log

REM > VERIFICA O N°DA CHAVE DO WINDOWS:
echo. >> C:\applications\self_check\self_check.log
wmic path softwarelicensingservice get oa3xoriginalproductkey >> C:\applications\self_check\self_check.log

REM > VERIFICA O MODELO DO WINDOWS:
echo. >> C:\applications\self_check\self_check.log
wmic os get buildnumber >> C:\applications\self_check\self_check.log
echo. >> C:\applications\self_check\self_check.log
wmic os get caption >> C:\applications\self_check\self_check.log

REM > VERIFICA INFORMAÇÕES DA REDE:
echo. >> C:\applications\self_check\self_check.log
ipconfig /all >> C:\applications\self_check\self_check.log

REM ------------------------------------------------------------------------

exit