@echo off
REM ----------------------------------------------------
REM Turn off command echoing to keep output clean
REM ----------------------------------------------------

REM ----------------------------------------------------
REM Load Intel oneAPI environment
REM This sets PATH, LIB, INCLUDE so `ifort` works
REM ----------------------------------------------------
call "%ONEAPI_ROOT%\setvars.bat"

REM ----------------------------------------------------
REM Verify Intel Fortran compiler is available
REM Prints compiler version to the console
REM ----------------------------------------------------
ifort --version

REM ----------------------------------------------------
REM Simple one-line DLL compilation
REM  /dll          -> build a Windows DLL
REM  /libs:static  -> statically link Intel runtime libraries
REM  DISCON.F90    -> Fortran source file
REM  /Fe:DISCON.dll-> output DLL name
REM ----------------------------------------------------
ifort /dll /libs:static DISCON.F90 /Fe:DISCON.dll

REM ----------------------------------------------------
REM Multi-line DLL compilation (same as above, more readable)
REM  ^ character allows line continuation in batch files
REM  /threads enables thread-safe runtime (recommended for OpenFAST)
REM ----------------------------------------------------
ifort ^
  /dll ^            REM Build a dynamic link library
  /libs:static ^    REM Use static Intel runtime libraries
  /threads ^        REM Enable thread-safe runtime
  DISCON.F90 ^      REM Controller source file
  /Fe:DISCON.dll    REM Output DLL file name
