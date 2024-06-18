library(dplyr)
dat <- read.table('results_2Mb_sqtl/bd_pgc3_BrainMeta_cis_sQTL_2Mb_full.smr', h=T)

##for some reason all cols are 'chr'; convert the ones essential for filtering in 'numeric'
#dat$p_eQTL <- as.numeric(as.character(dat$p_eQTL))
#dat$p_SMR <- as.numeric(as.character(dat$p_SMR))
#dat$p_HEIDI <- as.numeric(as.character(dat$p_HEIDI))

##check all classes
print(sapply(dat,class))

##check unique probes
unique_probes <- unique(dat$probeID)
n_distinct(dat$probeID)

##filter on p_eQTL value (should be GWS)
dat_eqtl <- dat %>% filter(p_eQTL < 5E-08)

##apply bonferroni correction on p_SMR according to the N of remaining snp-probe pairs and the p_HEIDI value
correct_p_SMR = 0.05/nrow(dat_eqtl)
dat_final <- dat_eqtl %>% filter(p_SMR < correct_p_SMR & p_HEIDI >= 0.01)

##write a table
write.table(dat_final, 'results_2Mb_sqtl/bd_pgc3_BrainMeta_cis_sQTL_2Mb_full_significant_2.smr',  sep = "\t", row.names = FALSE, quote=FALSE)
