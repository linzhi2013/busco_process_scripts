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


for f in `cat single_copy_busco_dirlist`;
do
    sample=`echo $f | awk -F'/' '{print $10}'`

    mkdir $sample
    cd $sample

    cat $f/*.fna | perl -ne 'chomp; if(/^>/){my @a=split /\:/; print "$a[0]\n";}else {print "$_\n";} ' > $sample.fna

    cd ../
   
done
