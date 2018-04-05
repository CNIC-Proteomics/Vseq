


##      ###   ##   ###        ##
 ##     #    # #  #  #       ##
  ##    ###  ###  #  #      ##
   ##     #  #    #  #     ##         ###################################
    ##  ###  ###   ###   ##           ###################################
     ##              #  ##            ########      Vseq      ###########
       ##            # ##             ###################################
        ##           ##               ###################################
          ##       ##
            ##  ##
              ##







         ### Run multiple SCANS %to Vseq  #####
   
   # begin: jmrc
   #x = t(read.table("E:\\NT_scaf1\\forFAIM_scans.csv"))     #####   for multiple scans    #####
   #x = c(229, 470)     #######   for few scans   ########

   x = unique(sql$FirstScan)
   x = c(x[1], x) # fix a bug from the code
   # end: jmrc

   
xx = x
# begin: jmrc
#varNamePath <- "D:\\projects\\Vseq\\test\\R_graphs\\"
# end: jmrc
varconc2<- paste0(varNamePath,x[1],"_",x[length(x)],".xls")

dtapar <- data.frame()
for (x in x)
{
  #################################################################################
  ################################################################################
  ################################################################################
  ################################################################################
  sn <- paste0("SCANS=", x)
  # begin: jmrc
  print(sn)
  # Evalute is scan it is the MGF (tryCatch)
  result <- tryCatch({
    fr <- fread(infile,skip=sn); as.data.frame(fr)
    print('ok')
  }, error = function(err) {
    print(paste0("MY_ERROR:  ",sn, " Scan not found in the mgf: ", err))
    print('error')
  }) # END tryCatch  
  if ( result == 'ok' ) {
   source("Vseq_project.R")
   params[[x]] <-  data.frame(x, seq,mim, Charge, Xcorr, Escore, rt, DeltaMass,
                              prot, matched_ions, out_of, massspec)
   dtapar <- rbind(dtapar, params[[x]])
  }
  
  # end: jmrc
  
}  

 write.xlsx(dtapar, varconc2, sheetName = "params")
  
  ################################################################################
  #################################################################################
  #################################################################################
  ###############################################################################