# Realign contigs generated by Tigra-SV to reference

# Support provided for cluster queuing system (bsub)
# Turn queuing on/off with USE_BSUB=1/0

USE_BSUB=0

source ./BPS_Stage.config

mkdir -p $OUTD/BWA

if [ $USE_BSUB == 1 ]; then    
# using bsub
mkdir -p bsub
fi  

function process {
    BAR=$1
    FASTA=$2

    DAT="$OUTD/contig/$BAR.contig"
    OUT="$OUTD/BWA/$BAR.sam"

    CMD="$BWA mem $FASTA $DAT" 

    if [ $USE_BSUB == 1 ]; then    
        bsub -e bsub/$BAR.3.bsub -o $OUT $CMD   # this appends bsub output to SAM file.  For now, clean manually
    else
        echo Executing: $CMD
        echo Writing to $OUT
        $CMD > $OUT
    fi  
}



while read l; do  # iterate over all rows of samples.dat 

# Skip comments and header
[[ $l = \#* ]] && continue
[[ $l = barcode* ]] && continue

# assume RP file exists for all samples.  Can create test to make sure this is true, skip if not.
BAR=`echo $l | awk '{print $1}'`
FASTA=`echo $l | awk '{print $4}'`

process $BAR $FASTA

done < $SAMPLE_LIST
