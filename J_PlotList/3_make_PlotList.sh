# Create a PlotList.BPS data file for Breakpoint Surveyor plots
# 
# This PlotList based on PindelRP data.  

# PlotList is TSV format with the following columns,
#  * barcode
#  * event.name (unique)
#  * chrom.a, (first chromosome of coordinate pair)
#  * event.a.start, event.a.end (indicates region of e.g. SV event)
#  * range.a.start, range.a.end (indicates region to plot; calculated as event.start - context, event.end + context, respectively)
#  * chrom.b, (second chromosome of coordiante pair)
#  * event.b.start, event.b.end, range.b.start, range.b.end 

# A PlotList file lists all SV events which are to be plotted, with one plot per line.
# For SVs, we have the positions of the event on Chrom A and B, as well as the "range" for
# both chromosomes.  The range sets the limits of the plots, and is often +/- 50Kbp around
# the event.

# Processing requires an FAI file, which defines size of each chrom or virus in the reference.
# We assume that it can be found by appending .fai to the reference filename

# We collect all PlotList lines for all samples into one PlotList file.

source ./BPS_Stage.config

BIN="$BPS_CORE/src/util/PlotListMaker.py"

FLANK="50000"  # distance around each integration region to be included in PlotList

OUT="$OUTD/PlotList.dat"
rm -f $OUT

HEADER="-H"

function process {
    BAR=$1
    FAI=$2

    # Choose PindelRP data
    DAT="$OUTD/BPR/${BAR}.PindelRP-prioritized.BPR.dat"

    if [ $FLIPAB == 1 ]; then  # see ../bps.config
        FLIP="-l"
    fi

    $PYTHON $BIN $HEADER -c $FLANK -i $DAT -o stdout -r $FAI -n $BAR -N A -p chr $FLIP >> $OUT  
    HEADER=""

}

while read l; do  # iterate over all barcodes
    # barcode bam_path    CTX_path
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    # when looping around multiple barcodes, combine them all into one output file
    BAR=`echo $l | awk '{print $1}'`
    # We assume that appending .fai to reference file gives name of corresponding .fai file
    FAI=`echo $l | awk '{print $4}'`
    FAI="$FAI.fai"

    process $BAR $FAI

done < $SAMPLE_LIST  # iterate over all barcodes

echo Written to $OUT
