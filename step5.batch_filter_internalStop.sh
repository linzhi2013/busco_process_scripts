# Copyright: Guanliang Meng. All rights reserved.
# 
# When you use the software in your project, please cite:
# Liu S, Zhou C, Meng G, et al. Evolution and diversification
# of Mountain voles (Rodentia: Cricetidae)[J]. In prep., 2022.
# 
# WHEN YOU ADAPT (PART OF) THE SOFTWARE FOR YOUR USE CASES,
# THE AUTHOR AND THE SOFTWARE MUST BE EXPLICITLY CREDITED
# IN YOUR PUBLICATIONS AND SOFTWARE, AND YOU MUST ALSO ASK
# THE USERS OF YOUR SOFTWARE TO CITE THE SOFTWARE IN THEIR
# PUBLICATIONS. IN A WORD, 请讲武德.


module load blast+/2.9.0

for f in `cat fna_list`;
do
    a=$(basename $f)

    makeblastdb -in $f -dbtype nucl
    blastn -db $f -query $f -out $a.selfBlastn -outfmt 6 -evalue 1e-5
    awk '$1!=$2'  $a.selfBlastn > $a.selfBlastn.qs
    awk '$3>95 && $4>200'  $a.selfBlastn.qs >  $a.selfBlastn.qs.paralogs
    awk '{print $1"\n"$2}' $a.selfBlastn.qs.paralogs | sort | uniq >  $a.selfBlastn.qs.paralogs.seqids
    rm -rf $f.nsq $f.nin $f.nhr $a.selfBlastn $a.selfBlastn.qs
    
    paralog_num=`wc -l $a.selfBlastn.qs.paralogs.seqids | awk '{print $1}'`
    if [ $paralog_num == 0 ] ; then
         cp $f $a.rmParalog 
    else
        seqkit grep --pattern-file $a.selfBlastn.qs.paralogs.seqids $f --out-file $a.rmParalog --invert-match
    fi
done
