@echo off

REM Ensure Intel environment is loaded
call "%ONEAPI_ROOT%\setvars.bat"

REM Verify compiler
ifort --version

ifort /dll /libs:static DISCON.F90 /Fe:DISCON.dll

REM Compile DISCON
ifort ^
  /dll ^
   /libs:static ^
  /threads ^
  DISCON.F90 ^
  /Fe:DISCON.dll
