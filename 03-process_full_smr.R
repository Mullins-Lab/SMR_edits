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

##subtract -1 for multiple headers: ie if 2258 --> 2257, only if multiple headers have not been removed.
##calculate bonferroni correction
##ie: 0.05/2257 = 2.21533e-05

##filter by adding the correct Bonferronic correction in each case
dat_eqtl <- dat %>% filter(p_eQTL < 5E-08 & p_SMR < 2.21533E-05 & p_HEIDI >= 0.01)

##write a table
write.table(dat_eqtl, 'results_2Mb_sqtl/bd_pgc3_BrainMeta_cis_sQTL_2Mb_full_significant_2.smr',  sep = "\t", row.names = FALSE, quote=FALSE)
