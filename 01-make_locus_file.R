#load essential libraries
library(vroom)
library(tidyverse)
library(dplyr)

#read the files, esi, epi and my snp lists and rename columns as fit
finemap <- read.table('/sc/arion/projects/psychgen/bipolar/fine-mapping/smr/data/finemapped_snps_tableS4_chr.txt', h=F)
probes <- vroom('/sc/arion/projects/psychgen/bipolar/fine-mapping/smr/BrainMeta_cis_eqtl_summary/BrainMeta_cis_eQTL_full.epi', col_names=FALSE)
snps_esi <- vroom('/sc/arion/projects/psychgen/bipolar/fine-mapping/smr/BrainMeta_cis_eqtl_summary/BrainMeta_cis_eQTL_full.esi', col_names=FALSE)

colnames(finemap)[1]="SNP"
colnames(snps_esi)[2]="SNP"
colnames(probes)[4]= "POS"
colnames(probes)[2]= "ProbeID"
colnames(snps_esi)[4]= "POS"
colnames(probes)[1]="CHR"
colnames(snps_esi)[1]="CHR"

#merge the snp list with the esi file
merge_snps <- merge(snps_esi, finemap, by="SNP")
dim(merge_snps)  #25 from the list found in there
colnames(merge_snps)[4]="POS"

#add half 2 Mb to the POS column on each end in the merge_snps df
merge_snps$start = merge_snps$POS - 2000000
merge_snps$end = merge_snps$POS + 2000000

#convert negative entries to 0 in the merge_snps df
merge_snps_new <- merge_snps %>% mutate(start = if_else(start < 0 , 0 , start))

#merge the merge_snps_new dataframe with the probes df
merge_novel <- merge(merge_snps_new, probes, by="CHR")
colnames(merge_novel)[4]="POS_SNP"
colnames(merge_novel)[12]="POS_Probe"

#filter this df based on the POS_Probe being between the start and end cols
filtered_df <- merge_novel[merge_novel$POS_Probe >= merge_novel$start & merge_novel$POS_Probe <= merge_novel$end, ]

#loop through unique SNPs and save separate files
unique_snps <- unique(filtered_df$SNP)

for(snp in unique_snps) {
  snp_df <- subset(filtered_df, SNP == snp, select = c("SNP", "ProbeID"))
  output_file <- paste0("output_2Mb_eQTL_", snp, ".txt")
  write.table(snp_df, file = output_file, sep = "\t", col.names= FALSE, row.names = FALSE, quote=FALSE)
}
