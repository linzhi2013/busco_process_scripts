#!/usr/bin/env python3
'''
Copyright: Guanliang Meng. All rights reserved.

When you use the software in your project, please cite:
Liu S, Zhou C, Meng G, et al. Evolution and diversification of Mountain voles (Rodentia: Cricetidae)[J]. In prep., 2022.

WHEN YOU ADAPT (PART OF) THE SOFTWARE FOR YOUR USE CASES, THE AUTHOR AND THE SOFTWARE MUST BE EXPLICITLY CREDITED IN YOUR PUBLICATIONS AND SOFTWARE, AND YOU MUST ALSO ASK THE USERS OF YOUR SOFTWARE TO CITE THE SOFTWARE IN THEIR PUBLICATIONS. IN A WORD, 请讲武德.
'''

import sys
import os
import re
from Bio import SeqIO


def remove_dupliates(fna=None, out=None):
    seqid_seq = {}
    seqid_count = {}

    for rec in SeqIO.parse(fna, 'fasta'):
        seqid_seq[rec.id] = str(rec.seq)
        if rec.id not in seqid_count:
            seqid_count[rec.id] = 0
        seqid_count[rec.id] += 1

    with open(out, 'w') as fhout:
        for seqid, seq_count in seqid_count.items():
            if seq_count > 1:
                print(fna, seqid, seq_count, file=sys.stderr)
                continue
            print('>'+seqid, seqid_seq[seqid], sep='\n', file=fhout)



def main():
    usage = '''
Remove sequences with duplicate seqids.

python3 {} <fna_list> <outdir>

'''.format(sys.argv[0])

    if len(sys.argv) != 3:
        sys.exit(usage)

    in_f, out_dir = sys.argv[1:3]

    with open(in_f, 'r') as fh:
        for f in fh:
            f = f.strip()
            if not f:
                continue
            f_base = os.path.basename(f)
            outfile = f_base + '.rmdup'
            outfile = os.path.join(out_dir, outfile)
            remove_dupliates(fna=f, out=outfile)



if __name__ == '__main__':
    main()
