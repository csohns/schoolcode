@echo off
If "%1" == "" goto USAGE
cls
echo �
echo �
echo                    You are about to install "The Scroll Keeper"
echo                     Press 'Ctrl + C' to stop at any time. . .
echo �
echo �
echo                           Files will be copied to %1
echo �
echo �
echo �
echo �
echo �
echo �
echo �
echo �
echo �
echo �
echo �
pause
cls
echo Creating %1. . .
md %1 >nul
echo Copying Beta 5 program files. . .
echo      Copying BETA5.EXE to %1\BETA5.EXE
copy beta5.exe %1 >nul
echo      Copying REGISTER.EXE to %1\REGISTER.EXE
copy register.exe %1 >nul
echo Copying documentation. . .
echo      Copying SCROLL.DOC to %1\SCROLL.DOC
copy scroll.doc %1 >nul
echo Copying demo file. . .
echo      Copying CARDS.DAT to %1/CARDS.DAT
copy cards.dat %1 >nul
echo �
echo �
echo Copying Beta 6 program files. . .
echo      Copying BETA6.EXE to %1\BETA6.EXE
copy beta6.exe %1 >nul
echo      Copying CONVT.EXE to %1\CONVT.EXE
copy convt.exe %1 >nul
cls
echo Instalation finished. . .
echo �
echo Now, type CD %1
echo      Then type BETA5
echo           or type BETA6
echo �
echo �
echo   Enjoy!!
goto END
:USAGE
cls
echo �
echo �
echo To use MAGINST you must use the following syntax:
echo �
echo �
echo �
echo �
echo         MAGINST [directory to install files to]
echo �               (ie:  MAGINST C:\MAGIC)
echo �
echo �
echo �
echo �
echo �
echo �
echo �
:END
