@ECHO off

:: get current path
SET PWD=%~dp0
SET PWD=%PWD:~0,-1%

:: input parameters
SET InFile=%PWD%/test/vseq_input_data.csv
SET /p InFile="Enter the input file for the Vseq (in CSV format): "

:: execute Vseq
CMD /k "R --vanilla --silent -f %PWD%/Vseq_pre.R --args %InFile% "

SET /P DUMMY=Hit ENTER to continue...