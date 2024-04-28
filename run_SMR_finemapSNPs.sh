#!/bin/bash
while read -r snp chr; do
/sc/arion/projects/psychgen/bipolar/fine-mapping/smr/smr_Linux \
--bfile /sc/arion/projects/psychgen/resources/genotype_ref_panel/HRC_fromBroad/chr1_22c/pop_EUR/HRC.r1-1.EGA.GRCh37.chr"$chr".impute.plink.EUR \
--gwas-summary /sc/arion/projects/psychgen/bipolar/fine-mapping/files/gcta_cojo/daner_bip_pgc3.ma \
--extract-target-snp-probe /sc/arion/projects/psychgen/bipolar/fine-mapping/smr/data/output_"$snp".txt \
--beqtl-summary /sc/arion/projects/psychgen/bipolar/fine-mapping/smr/BrainMeta_cis_eqtl_summary/BrainMeta_cis_eQTL_chr"$chr" \
--out /sc/arion/projects/psychgen/bipolar/fine-mapping/smr/results/bd_pgc3_BrainMeta_cis_eQTL_"$snp"_chr"$chr"
done < /sc/arion/projects/psychgen/bipolar/fine-mapping/smr/data/finemapped_snps_tableS4_chr.txt
