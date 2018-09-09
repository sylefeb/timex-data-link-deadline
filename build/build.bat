@ECHO OFF

REM ********************************************************************
REM *
REM * M851 WRISTAPP BUILDER
REM * Timex Corporation 2002 All Rights Reserved
REM * July 2002
REM *
REM * WristApp: deadline
REM *
REM ********************************************************************

rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rem ; Clean up wristapp build directory
rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

cd C:\M851\App\deadline\build

del *.sre
del *.bin
del *.lst
del *.obj
del *.out
del *.err
del *.lnl
del *.cal
del *.bak
del *.ers
del *.elk
del *.elc

rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rem ; Build Common Section
rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

c:\c88\bin\as88.exe common.asm -fascmd.cmd
c:\c88\bin\lk88.exe common.obj -o common.out -flkcmd.cmd
c:\c88\bin\lc88.exe common.out -o common.sre -flccmd.cmd
c:\m851\bin\symgen common.map
c:\m851\bin\makeequ common.sy
copy common.equ comminc.h

rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rem ; Build State Handler Section
rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

rem Build state0 Handler
c:\c88\bin\as88.exe state0.asm -fascmd.cmd
c:\c88\bin\lk88.exe state0.obj -o state0.out -flkcmd.cmd
c:\c88\bin\lc88.exe state0.out -o state0.sre -flccmd.cmd


rem Build state1 Handler
c:\c88\bin\as88.exe state1.asm -fascmd.cmd
c:\c88\bin\lk88.exe state1.obj -o state1.out -flkcmd.cmd
c:\c88\bin\lc88.exe state1.out -o state1.sre -flccmd.cmd


rem Build state2 Handler
c:\c88\bin\as88.exe state2.asm -fascmd.cmd
c:\c88\bin\lk88.exe state2.obj -o state2.out -flkcmd.cmd
c:\c88\bin\lc88.exe state2.out -o state2.sre -flccmd.cmd


rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rem ; Build Parameter File
rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

c:\c88\bin\as88.exe param.asm -fascmd.cmd
c:\c88\bin\lk88.exe param.obj -o param.out -flkcmd.cmd
c:\c88\bin\lc88.exe param.out -o param.sre -flccmd.cmd


rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rem ; Delete temporary files
rem ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

del *.out
del *.sy
del *.tmp
del *.lnl
del *.cal
