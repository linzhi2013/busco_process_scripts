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



for f in `cat fna_list`;
do
    perl  /home/gmeng/work/01.arvicoline/02.data_from_BGI/Glires_tree_pipeline_zfmk/genemap/bin/cds2aa.pl --check $f > $f.translation_check
    awk '$4==0'  $f.translation_check > $f.translation_check.internalstop
    awk '{print $1}' $f.translation_check.internalstop > $f.translation_check.internalstop.seqids
done
