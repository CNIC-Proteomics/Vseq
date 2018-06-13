


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

sql_x = unique(sql$FirstScan)
sql_x = c(sql_x[1], sql_x) # fix a bug from the code. Add the first value twices
# end: jmrc

   
dtapar <- data.frame()
for (x in sql_x) {
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
   params[[x]] <-  data.frame(x, seq,mim, Charge, Xcorr, Escore, rt, DeltaMass, prot, matched_ions, out_of, massspec)
   dtapar <- rbind(dtapar, params[[x]])
  }
  
  # end: jmrc
  
}  

varconc2<- paste0(varNamePath,sql_x[1],"_",sql_x[length(sql_x)],".xls")
write.xlsx(dtapar, varconc2, sheetName = "params")
