# load packages 
library(tidyverse)
library(knitr)
library(gridExtra)

# Plots

variant_plots <- function(snp_filepath, indel_filepath){
VCF <- read.csv(snp_filepath, header = T, na.strings=c("","NA"), sep = "\t") %>% 
  add_column(Variant = "SNPs")  %>% 
  rbind(
    read.csv(indel_filepath, header = T, na.strings=c("","NA"), sep = "\t") %>% 
      add_column(Variant = "Indels") 
  )

QD <- ggplot(VCF, aes(x=QD, fill=Variant)) + 
  geom_density(alpha=.3) +
  geom_vline(xintercept=20, size=0.7) + 
  coord_cartesian(xlim = c(10,45))

FS <- ggplot(VCF, aes(x=FS, fill=Variant)) + 
  geom_density(alpha=.3) +
  geom_vline(xintercept=2, size=0.7)  

MQ <- ggplot(VCF, aes(x=MQ, fill=Variant)) + 
  geom_density(alpha=.3) +
  geom_vline(xintercept=59, size=0.7) + 
  coord_cartesian(xlim = c(58,70)) 

grid.arrange(QD, FS, MQ)
}

variant_plots <- variant_plots("quality/GVCFall_SNPs.table", "quality/GVCFall_INDELs.table")

ggsave("quality/Variant_quality_distribution.png", dpi = 600, variant_plots)