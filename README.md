This repository contains code to run [Summary Data-based Mendelian Randomization analysis](https://yanglab.westlake.edu.cn/software/smr/#SMR&HEIDIanalysis) using fine-mapped SNPs as the QTL instruments.
This code was implemented as part of [PGC3 BD Fine-mapping preprint](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10889003/#SD2) and [PGC4 BD GWAS preprint](https://www.medrxiv.org/content/10.1101/2023.10.07.23296687v1.supplementary-material) (revisions ongoing).

Basic steps include: 
 - prepare the locus file by extracting QTL regions around the fine-mapped SNPs,
 - 'force' these fine-mapped regions to be the QTL instruments in the SMR analysis,
 - run SMR analysis and filter the results accordingly.

Inputs needed:
- GWAS summary statistics in a [GCTA COJO format](https://yanglab.westlake.edu.cn/software/smr/#SMR&HEIDIanalysis).
- List of fine-mapped SNPs (just the rsIDs and chromosome numbers) in a tab-delimited formatted file (.tsv or .txt).
