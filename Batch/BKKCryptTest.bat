@ECHO OFF
REM If you want to run this test than save the scripts in the same directory and call this script from the CMD (or PowerShell)
SET ORIG=%RANDOM%
ECHO Original password:
call BKKCrypt.bat %ORIG%
REM The following IF statement determines whether the complex encryption was successful
IF %ORIG% == %MYPASS% ( 
ECHO The password is succesfully encrypted:
ECHO %MYPASS%
) ELSE (
ECHO The password encryption is failed
)
PAUSE