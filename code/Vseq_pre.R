

##       ###   ##   ###        ##
##     #    # #  #  #       ##
##    ###  ###  #  #      ##
##     #  #    #  #     ##
##  ###  ###   ###   ##
##              #  ##
##            # ##
##           ##
##       ##
##  ##
##

starttime <- Sys.time()

##########  instalacion de Biostrings   @#########################
# source("https://bioconductor.org/biocLite.R")
# biocLite("Biostrings")

# begin: jmrc
.libPaths("D:/R/win-library/3.5")
# end: jmrc

library(Maeswrap)
library(data.table)
library(ggplot2)
library(plotrix)
library(reshape)
library(MASS)
library(gridExtra)
library(grid)
library(rJava)
library(xlsx)
library(sqldf)
library(tcltk)
library(dplyr)
library(oce)
library(qpcR)
library(gdata)
library(tcR)
#library(Biostrings)



##monoisotopic masses aa###
A=71.03711
R=156.10111
# begin: jmrc
U=156.10111 + 0.984016
# end: jmrc
N=114.04293
D=115.02694
C=103.00919
C=103.00919 + 57.021  ####CarbamidomethylCys
E=129.04259
Q=128.05858
G=57.02146
H=137.05891
I=113.08406
#i=I+iTRAQ8
L=113.08406
K=128.09496
M=131.04049
# begin: jmrc
# O=M+15.996  ### oxidized Met
O=N+0.984016  ### deamidation
# end: jmrc
F=147.06841
P=97.05276
S=87.03203
T=101.04768
W=186.07931
Y=163.06333
V=99.06841
Sp=S+ 79.966331  
Tp=T+ 79.966331 
Yp=Y+ 79.966331  

# begin: jmrc
mod = 15.9955   #oxidation
mod2 =31.9895   #Dioxidation
mod3 =185.1155  #unknown???
mod4 =45.04     #Nitration
mod5= 79.966331  #phospho
mod6= 153.023  #??????

# U= M + mod
B= W + mod2
J= K + 8.014199
# O= R + 10.008269
# Ñ= Y + mod4
# end: jmrc
AAS <- c(A,R,N,D,C,E,G,H,L,K,M,F,P,S,T,W,Y,V,B, Sp, Tp, Yp)
AASch <- c("A","R","N","D","C","E","G","H","L","K","M","F",
           "P","S","T","W","Y","V","B", "Sp","Tp", "Yp")

A2=71.03711/2
R2=156.10111/2
N2=114.04293/2
D2=115.02694/2
C2=(103.00919 + 57.021)/2  ####CarbamidomethylCys
E2=129.04259/2
Q2=128.05858/2
G2=57.02146/2
H2=137.05891/2
I2=113.08406/2

L2=113.08406/2
K2=128.09496/2
M2=131.04049/2
#B=M+mod  ### /2oxidized Met
F2=147.06841/2
P2=97.05276/2
S2=87.03203/2
T2=101.04768/2
W2=186.07931/2
Y2=163.06333/2
V2=99.06841/2

AAS2 <- c(A2,R2,N2,D2,C2,E2,G2,H2,L2,K2,M2,F2,P2,S2,T2,W2,Y2,V2)

immA=44.05003 
immR=129.114 
immN=87.05584 
immD=88.03986 
immC=133.0436   ####CarbamidomethylCys
immE=102.0555 
immQ=101.0715 
immG=30.03438 
immH=110.0718 
immI=86.09698 
immL=86.09698 
immK=101.1079 
immM=104.0534 
#B=M+mod  ### oxidized Met
immF=120.0813 
immP=70.06568 
immS=60.04494 
immT=74.06059 
immW=159.0922 
immY=136.0762 
immV=72.08133
y1K=147.1128
y1R=175.1190

IMM <- c(immA,immR,immN,immD,immC,immE,immG,immH,immL,immK,immM,immF,immP,immS,immT,immW,immY,immV, y1K, y1R)


diAA= A+A
diAR= A+R
diAN= A+N
diAD= A+D
diAC= A+C
diAE= A+E
diAG= A+G
diAH= A+H
diAL= A+L
diAK= A+K
diAM= A+M
diAF= A+F
diAP= A+P
diAS= A+S
diAT= A+T
diAW= A+W
diAY= A+Y
diAV= A+V
diRR= R+R
diRN= R+N
diRD= R+D
diRC= R+C
diRE= R+E
diRG= R+G
diRH= R+H
diRL= R+L
diRK= R+K
diRM= R+M
diRF= R+F
diRP= R+P
diRS= R+S
diRT= R+T
diRW= R+W
diRY= R+Y
diRV= R+V
diNN= N+N
diND= N+D
diNC= N+C
diNE= N+E
diNG= N+G
diNH= N+H
diNL= N+L
diNK= N+K
diNM= N+M
diNF= N+F
diNP= N+P
diNS= N+S
diNT= N+T
diNW= N+W
diNY= N+Y
diNV= N+V
diDD= D+D
diDC= D+C
diDE= D+E
diDG= D+G
diDH= D+H
diDL= D+L
diDK= D+K
diDM= D+M
diDF= D+F
diDP= D+P
diDS= D+S
diDT= D+T
diDW= D+W
diDY= D+Y
diDV= D+V
diCC= C+C
diCE= C+E
diCG= C+G
diCH= C+H
diCL= C+L
diCK= C+K
diCM= C+M
diCF= C+F
diCP= C+P
diCS= C+S
diCT= C+T
diCW= C+W
diCY= C+Y
diCV= C+V
diEE= E+E
diEG= E+G
diEH= E+H
diEL= E+L
diEK= E+K
diEM= E+M
diEF= E+F
diEP= E+P
diES= E+S
diET= E+T
diEW= E+W
diEY= E+Y
diEV= E+V
diGG= G+G
diGH= G+H
diGL= G+L
diGK= G+K
diGM= G+M
diGF= G+F
diGP= G+P
diGS= G+S
diGT= G+T
diGW= G+W
diGY= G+Y
diGV= G+V
diHH= H+H
diHL= H+L
diHK= H+K
diHM= H+M
diHF= H+F
diHP= H+P
diHS= H+S
diHT= H+T
diHW= H+W
diHY= H+Y
diHV= H+V
diLL= L+L
diLK= L+K
diLM= L+M
diLF= L+F
diLP= L+P
diLS= L+S
diLT= L+T
diLW= L+W
diLY= L+Y
diLV= L+V
diKK= K+K
diKM= K+M
diKF= K+F
diKP= K+P
diKS= K+S
diKT= K+T
diKW= K+W
diKY= K+Y
diKV= K+V
diMM= M+M
diMF= M+F
diMP= M+P
diMS= M+S
diMT= M+T
diMW= M+W
diMY= M+Y
diMV= M+V
diFF= F+F
diFP= F+P
diFS= F+S
diFT= F+T
diFW= F+W
diFY= F+Y
diFV= F+V
diPP= P+P
diPS= P+S
diPT= P+T
diPW= P+W
diPY= P+Y
diPV= P+V
diSS= S+S
diST= S+T
diSW= S+W
diSY= S+Y
diSV= S+V
diTT= T+T
diTW= T+W
diTY= T+Y
diTV= T+V
diWW= W+W
diWY= W+Y
diWV= W+V
diYY= Y+Y
diYV= Y+V
diVV= V+V

dipep <- c(diAA,diAR,diAN,diAD,diAC,diAE,diAG,diAH,diAL,diAK,diAM,diAF,diAP,diAS,diAT,diAW,diAY,diAV,diRR,diRN,diRD,
           diRC,diRE,diRG,diRH,diRL,diRK,diRM,diRF,diRP,diRS,diRT,diRW,diRY,diRV,diNN,diND,diNC,diNE,diNG,diNH,diNL,diNK,
           diNM,diNF,diNP,diNS,diNT,diNW,diNY,diNV,diDD,diDC,diDE,diDG,diDH,diDL,diDK,diDM,diDF,diDP,diDS,diDT,diDW,diDY,
           diDV,diCC,diCE,diCG,diCH,diCL,diCK,diCM,diCF,diCP,diCS,diCT,diCW,diCY,diCV,diEE,diEG,diEH,diEL,diEK,diEM,diEF,
           diEP,diES,diET,diEW,diEY,diEV,diGG,diGH,diGL,diGK,diGM,diGF,diGP,diGS,diGT,diGW,diGY,diGV,diHH,diHL,diHK,diHM,
           diHF,diHP,diHS,diHT,diHW,diHY,diHV,diLL,diLK,diLM,diLF,diLP,diLS,diLT,diLW,diLY,diLV,diKK,diKM,diKF,diKP,diKS,
           diKT,diKW,diKY,diKV,diMM,diMF,diMP,diMS,diMT,diMW,diMY,diMV,diFF,diFP,diFS,diFT,diFW,diFY,diFV,diPP,diPS,diPT,
           diPW,diPY,diPV,diSS,diST,diSW,diSY,diSV,diTT,diTW,diTY,diTV,diWW,diWY,diWV,diYY,diYV,diVV)


dip <- c("AA","AR","AN","AD","AC","AE","AG","AH","AL","AK","AM","AF","AP","AS","AT","AW","AY","AV","RR","RN","RD",
         "RC","RE","RG","RH","RL","RK","RM","RF","RP","RS","RT","RW","RY","RV","NN","ND","NC","NE","NG","NH","NL","NK",
         "NM","NF","NP","NS","NT","NW","NY","NV","DD","DC","DE","DG","DH","DL","DK","DM","DF","DP","DS","DT","DW","DY",
         "DV","CC","CE","CG","CH","CL","CK","CM","CF","CP","CS","CT","CW","CY","CV","EE","EG","EH","EL","EK","EM","EF",
         "EP","ES","ET","EW","EY","EV","GG","GH","GL","GK","GM","GF","GP","GS","GT","GW","GY","GV","HH","HL","HK","HM",
         "HF","HP","HS","HT","HW","HY","HV","LL","LK","LM","LF","LP","LS","LT","LW","LY","LV","KK","KM","KF","KP","KS",
         "KT","KW","KY","KV","MM","MF","MP","MS","MT","MW","MY","MV","FF","FP","FS","FT","FW","FY","FV","PP","PS","PT",
         "PW","PY","PV","SS","ST","SW","SY","SV","TT","TW","TY","TV","WW","WY","WV","YY","YV","VV")

H2O= 18.010565
NH3= 17.026548
CO= 27.994915
PA= 97.976898
Ph2 = PA/2
Ph3 = PA/3
C13 = 1



NL= c(H2O, NH3, CO, Ph2, Ph3, C13)


# mod = 15.9955   #oxidation
# mod2 =31.9895   #Dioxidation
# mod3 =185.1155  #unknown???
# mod4 =45.04     #Nitration
# mod5= 79.966331  #phospho
# mod6= 153.023  #??????
# 
# U= M + mod
# B= W + mod2
# J= K + 8.014199
# O= R + 10.008269
# ?= Y + mod4

Z= 45.058090


i4 = 144.102
i8 = 304.205
tmt = 229.163

isobLab = tmt  #define isobaric labeling has been used   ####

##monoisotopic masses aa  iTRAQ 4plex###
a=71.03711 + isobLab
r=156.10111 + isobLab
u=U + isobLab
n=114.04293 + isobLab
d=115.02694 + isobLab
c=103.00919 + 57.021+ isobLab
e=129.04259 + isobLab
q=128.05858 + isobLab
g=57.02146 + isobLab
h=137.05891 + isobLab
i=113.08406 + isobLab
l=113.08406 + isobLab
k=128.09496 + isobLab
m=131.04049 + isobLab
#b=m+mod
f=147.06841 + isobLab
p=97.05276 + isobLab
s=87.03203 + isobLab
t=101.04768 + isobLab
w=186.07931 + isobLab
y=163.06333 + isobLab
v=99.06841 + isobLab
o= O + isobLab



#####    input parameters    ###

# test if there is at least one argument: if not, return an error
args = commandArgs(trailingOnly=TRUE)

# example 4
args[1] <- "S:/U_Proteomica/PROYECTOS/PESA_omicas/Comet-PTM-2a-5ta_Cohortes_V1/NoDigPar/CometOnly/3d_analysis-6digitsCorrMassOK/vseq_input_data.csv"

if ( length(args) < 1 ) {
  msg = paste0("\n",
               "At least four argument must be supplied.\n",
               "Usage: Vseq description...\n",
               "R --vanilla --silent -f Vseq_pre.R --args test_input.csv")
  stop(msg, call.=FALSE)
}

infile2 <- args[1]

prepare_workspace <- function(experimento, mgfpath, dtapath, outpath){
  # delete slash that are the end
  mgfpath = sub("[\\]*$", "", mgfpath)  
  dtapath = sub("[\\]*$", "", dtapath)
  outpath = sub("[\\]*$", "", outpath)
  dtapath = sub("[/]*$", "", dtapath)
  outpath = sub("[/]*$", "", outpath)
  # add last slash
  mgfpath = paste0(mgfpath, "/")
  dtapath = paste0(dtapath, "/")
  outpath = paste0(outpath, "/")
  # normalize paths
  mgfpath = normalizePath(mgfpath)
  dtapath = normalizePath(dtapath)
  outpath = normalizePath(outpath)
  # get dta path for experiment
  dtapath <- paste0( dtapath, experimento, ".dta/" )
  varNamePath <- paste0( outpath, experimento, "/" )
  # create output dir if does not exist
  dir.create(outpath, showWarnings = FALSE)
  dir.create(varNamePath, showWarnings = FALSE)
  
  print(experimento)
  print(mgfpath)
  print(dtapath)
  print(outpath)
  print(varNamePath)
  
  return( list("mgfpath"=mgfpath, "dtapath"=dtapath, "outpath"=outpath, "varNamePath"=varNamePath) )
}


# set variables from input file
infilter <- read.csv(infile2)
experimentos <- sort( unique(infilter$Raw) )
for(ex in 1:length(experimentos)) {
  experimento <- as.character( experimentos[ex] )
  experimento <- gsub( "WO_duplicate.txt$", "", experimento)
  experimento <- gsub( ".txt$", "", experimento)
  experimento <- gsub( ".raw$", "", experimento)
  sql <- infilter[infilter$Raw == experimento,]
  # extract input parameters
  data_type <- unique( sql[sql$type,c("type")] )
  mgfpath   <- unique( sql[sql$type,c("mgfDir")] )
  dtapath   <- unique( sql[sql$type,c("dtaDir")] )
  outpath   <- unique( sql[sql$type,c("outDir")] )
  # prepare directories
  l <- prepare_workspace( experimento, mgfpath, dtapath, outpath )
  mgfpath     <- l$mgfpath
  dtapath     <- l$dtapath
  outpath     <- l$outpath
  varNamePath <- l$varNamePath
  
  ## datos de las fragmentaciones mgf
  infile = paste0(mgfpath, experimento, ".mgf")
  fr_ns <- fread(infile, sep="\n", header = FALSE)

  #################        obtener la tquery   ##################################

  squery <- filter(fr_ns, grepl("SCANS",  V1))
  hsquery <- as.data.frame(substr(squery[,'V1'], 7, 20))
  mquery <- filter(fr_ns, grepl("PEPMASS", V1))
  cquery <- filter(fr_ns, grepl("CHARGE", V1))
  
  tquery <- cbind(hsquery, mquery, cquery)
  names(tquery)[1] <- "SCAN"
  names(tquery)[2] <- "MASS"
  mssquery <- gsub('PEPMASS=', '', tquery$MASS)
  sssquery <- sub("$", ",", tquery$SCAN)
  
  spl <- colsplit.character(mssquery, split = " ", names(c("MZ", "INT")))
  spl <- as.data.frame(spl)
  ssl <- as.data.frame(sssquery)
  
  
  tquery <- cbind(ssl, spl, cquery)
  names(tquery)[1] <- "SCAN"
  names(tquery)[2] <- "MZ"
  names(tquery)[3] <- "INTENSITY"
  names(tquery)[4] <- "CHARGE"
  
  varcon4 <- paste0(outpath,"tquery_",experimento, ".csv")
  write.csv(tquery, varcon4)
  
  source("Vseq_launcher.R")
}

##########################################################################################################
##########################################################################################################

# end: jmrc

endtime <- Sys.time()

print(paste("from-",starttime,"-","to", "-", endtime))

#########################################################################################################

