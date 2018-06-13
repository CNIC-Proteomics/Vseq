#!/bin/bash

# init vars
indir="$1"
outdir="$2"
scriptdir="D:\projects\Vseq\code\tags\Vseq_v4.6"

run_cmd() {
  cmd="$1"
  echo "** $cmd"
  $cmd
  echo ""
}

# extract all 
for cometptmfile in $(find $indir -type f -name "*.mgf"); do
  s=${cometptmfile##*/}
  outfname=${s%.mgf}

  # get dir for inputs. add unique slash for the dir
  indir=$(echo $indir | sed 's/[\\|\/]$//g')
  dtadir=$indir/$outfname.dta/
  indir=$indir/
  outdir=$(echo $outdir | sed 's/[\\|\/]$//g')
  outdir=$outdir/

  # Vseq program
  run_cmd "R --vanilla --silent -f $scriptdir/Vseq_pre.R --args $outfname $indir $dtadir $outdir "
done

read -n 1 -s -r -p "Press any key to continue"