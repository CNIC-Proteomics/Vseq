import argparse, logging, os
import json, re
import subprocess
from pprint import pprint

__author__ = 'jmrodriguezc'

XCORR_THRESHOLD = 1.11

IDX_RAW = 'FileName'
IDX_SCAN = 'Scan'
IDX_CHARGE = 'Charge'
IDX_EXP_NEUTRAL_MASS = 'Exp.Mh'
IDX_XCOR = 'Xcor'
IDX_SEQUENCE = 'Seq'
IDX_RETENTION_TIME = 'RetentionTIme'
IDX_PROT_DESCRIPTION = 'Protein'

def main(args):
    ''' Main function'''    

    logging.info('init changed comet-ptm file')
    outcont = ('Raw\tFirstScan\tCharge\tMonoisotopicMass\tScoreValue\tScoreID\tSequence\tRetentionTime\tProteinDescriptions\n')

    with open(args.outfile, 'w') as outfile:
        outfile.write(outcont)
    
    low = lambda s: s[:1].lower() + s[1:] if s else ''
    callback = lambda pat: pat.group(1).lower()

    logging.info('read comet-ptm file')
    f = open(args.infile,'r')
    inlines = f.readlines()
    f.close()

    if len(inlines) > 1:
        logging.info('create file for vseq')
        hline = inlines[0]
        hline = re.sub(r"\n*$", "", hline)
        hcols = hline.split("\t")
        hidx = {x:i for i,x in enumerate(hcols)}
        for line in inlines[1:]:
            line = re.sub(r"\n*$", "", line)
            cols = line.split("\t")
            # discard the scans with threshold in the xcorr
            if float( cols[ hidx[IDX_XCOR] ] ) >= XCORR_THRESHOLD:
                # delete suffix in the raw filename
                raw = cols[ hidx[IDX_RAW] ]
                raw = re.sub(r"WO\_duplicate\.txt\s*", "", raw)
                scan = cols[ hidx[IDX_SCAN] ]
                # charge
                charge = cols[ hidx[IDX_CHARGE] ]
                # obtain the MonoisotopicMass: exp_neutral_mass + 1.0078 (six decimals)
                exp_neutral_mass = cols[ hidx[IDX_EXP_NEUTRAL_MASS] ]
                mono_isotopic_mass = format(float(exp_neutral_mass) + 1.0078, '.6f')
                # score value
                xcorr = cols[ hidx[IDX_XCOR] ]
                # (ScoreID -> 9)
                score_id = 9                
                # change pepetide sequence:            
                plain_peptide = cols[ hidx[IDX_SEQUENCE] ]
                plain_peptide = low(plain_peptide) # first char in lowercase
                plain_peptide = re.sub(r'([K])', callback, plain_peptide) # all K -> k
                # retention time
                ret_time = cols[ hidx[IDX_RETENTION_TIME] ]
                # change protein description
                protein_desc = cols[ hidx[IDX_PROT_DESCRIPTION] ]
                # dsc = protein_desc
                # p = re.match('^(sp|tr)\|([^\|]*)\|',dsc).group(2)
                # protein_desc = re.sub(r"^\s*", "", protein_desc)
                # protein_desc = re.sub(r"\s*PE=\d*\s*SV=\d*\s*", "", protein_desc)
                # protein_desc += ' ('+p+')'                
                # join and prints outs
                outs = []
                outcont = ('Raw\tFirstScan\tCharge\tMonoisotopicMass\tScoreValue\tScoreID\tSequence\tRetentionTime\tProteinDescriptions\n')
                outs.append(raw)
                outs.append(scan)
                outs.append(charge)
                outs.append(mono_isotopic_mass)
                outs.append(xcorr)
                outs.append(score_id)
                outs.append(plain_peptide)
                outs.append(ret_time)
                outs.append(protein_desc)                
                s = ",".join(str(x) for x in outs) + "\n"
                with open(args.outfile, 'a') as outfile:
                    outfile.writelines(s)
    else:
        print("empty comet-ptm file")
    
    
if __name__ == "__main__":
    # parse arguments
    parser = argparse.ArgumentParser(
        description='Convert comet-ptm files to be used by Vseq',
        epilog='''
        Example:
            convert_comet-ptm.py -i ~/d/data/Ratones_Heteroplasmicos_HF/muscle/comet_ptm/RH_muscle_TMTHF_FR1.txt -o ~/d/data/Ratones_Heteroplasmicos_HF/muscle/comet_ptm/RH_muscle_TMTHF_FR1.tsv
        ''')
    parser.add_argument('-i',  '--infile', required=True, help='comet-ptm file')
    parser.add_argument('-o',  '--outfile', required=True, help='modified comet-ptm file')
    parser.add_argument('-v', dest='verbose', action='store_true', help="Increase output verbosity")
    args = parser.parse_args()

    # logging debug level. By default, info level
    if args.verbose:
        logging.basicConfig(level=logging.DEBUG,
                            format='%(asctime)s - %(levelname)s - %(message)s',
                            datefmt='%m/%d/%Y %I:%M:%S %p')
    else:
        logging.basicConfig(level=logging.INFO,
                            format='%(asctime)s - %(levelname)s - %(message)s',
                            datefmt='%m/%d/%Y %I:%M:%S %p')

    logging.info('start '+os.path.basename(__file__))
    main(args)
    logging.info('end '+os.path.basename(__file__))
