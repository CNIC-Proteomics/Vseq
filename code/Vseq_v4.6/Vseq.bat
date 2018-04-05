@ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION

REM input parameters
SET /p InDir=Where are the 'mgf', 'dta', and 'comet-ptm' files? 
SET /p OutDir=Where the 'vseq' files will be save? 
REM SET InDir=D:\data\Ratones_Heteroplasmicos_HF\muscle\data_for_vseq
REM SET OutDir=D:\data\Ratones_Heteroplasmicos_HF\muscle\vseq_graphs

REM Execute Vseq for all experiments (scan all mgf files)
FOR /r %InDir% %%f in (*.mgf) do (
    SET INDIR=%InDir%\
    SET DTADIR=%InDir%\%%~nf.dta\
    SET OUTDIR=%OutDir%\%%~nf\

    REM execute Vseq with Rscript
    START "Vseq" CMD /K  R --vanilla --silent -f D:\projects\Vseq\code\tags\Vseq_v4.6\Vseq_pre.R --args %%~nf !INDIR!  !DTADIR!  !OUTDIR!
)
