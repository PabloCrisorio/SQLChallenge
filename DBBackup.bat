@echo off
set serverOption=
set DBOption=
set backupOption=
set SERVER=
set DB=
set BACKUPMODE=
set queryN1=
echo Backup script 1.0
echo.
:selectSvr
cls
echo.
echo Select your server/instance
echo.
echo 1- Server1
echo 2- Server2
echo 3- RYZEN5
echo 4- Exit
echo 5- Enter specific instance/server name 
echo.
set /p SERVER="Select: "
if %SERVER%==1 set serverOption=Server1
if %SERVER%==2 set serverOption=Server2
if %SERVER%==3 set serverOption=RYZEN5
if %SERVER%==4 EXIT
if %SERVER%==5 set /p serverOption="Input Server/instance: "
if %SERVER% GTR 5 goto selectSvr
if %SERVER% lss 1 goto selectSvr
cls
:selectDB
cls
echo You have selected the server %serverOption%
echo.
echo.
echo Select your Database
echo.
echo 1- ALL
echo 2- challenge
echo 3- littleStore
echo 4- Exit
echo 5- Enter specific Database name 
echo.
set /p DB="Select: "
if %DB%==1 set DBOption=ALL
if %DB%==2 set DBOption=challenge
if %DB%==3 set DBOption=littleStore
if %DB%==4 EXIT
if %DB%==5 set /p DBOption="Input Database name: "
if %DB% GTR 5 goto selectDB
if %DB% lss 1 goto selectDB

cls
:selectMode
echo You have selected the server %DBOption% and Database %DBOption%
echo.
echo Select Backup mode
echo.
echo 1- FULL
echo 2- DIFF
echo 3- TLOG
echo 4- Exit
echo.
set /p BACKUPMODE="Ingrese su seleccion: "
if %DB%==1 set BackupType=FULL
if %DB%==2 set BackupType=DIFF
if %DB%==3 set BackupType=TLOG
if %BACKUPMODE%==1 if %DBOption%==ALL set backupOption=DatabaseBackup - SYSTEM_DATABASES - FULL
if %BACKUPMODE%==1 if %DBOption%==challenge set backupOption=DatabaseBackup - Challenge - FULL
if %BACKUPMODE%==1 if %DBOption%==littleStore set backupOption=DatabaseBackup - littleStore - FULL
if %BACKUPMODE%==1 if %DB%==5 goto DemoMessage
if %BACKUPMODE%==2 if %DBOption%==ALL set backupOption=DatabaseBackup - SYSTEM_DATABASES - DIFF
if %BACKUPMODE%==2 if %DBOption%==challenge set backupOption=DatabaseBackup - Challenge - DIFF
if %BACKUPMODE%==2 if %DBOption%==littleStore set backupOption=DatabaseBackup - littleStore - DIFF
if %BACKUPMODE%==2 if %DB%==5 goto DemoMessage
if %BACKUPMODE%==3 if %DBOption%==ALL set backupOption=DatabaseBackup - SYSTEM_DATABASES - LOG
if %BACKUPMODE%==3 if %DBOption%==challenge set backupOption=DatabaseBackup - Challenge - LOG
if %BACKUPMODE%==3 if %DBOption%==littleStore set backupOption=DatabaseBackup - littleStore - LOG
if %BACKUPMODE%==3 if %DB%==5 goto DemoMessage
if %BACKUPMODE%==4 Exit
if %BACKUPMODE% GTR 4 goto selectMode
if %BACKUPMODE% lss 1 goto selectMode
set queryN1= "use msdb; exec sp_start_job  @job_name = '%backupOption%'"
echo you are about to start a %backupOption% backup for %DBOption% databse on %serverOption% server, Do you want to continue?
echo.
echo 1- Yes
echo 2- No
set /p continue="Select: "
if %continue%==2 goto selectSvr
sqlcmd.exe -s %serverOption% -d msdb -Q %queryN1%
echo Would like to make another backup
echo.
echo 1- Yes
echo 2- No
set /p continue="Select: "
if %continue%==1 goto selectSvr
if %continue%==2 Exit
:DemoMessage
echo.
echo -\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/
echo This is a demo version, at the moment the creation of queryes for specific databases is not available.
echo -\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/
echo.
echo Would like to make another backup
echo.
echo 1- Yes
echo 2- No
set /p continue="Select: "
if %continue%==1 goto selectSvr
if %continue%==2 Exit