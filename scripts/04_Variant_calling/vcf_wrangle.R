# Wrangle variant calling data

# Load Packages
library(readr)
library(dplyr)
library(tidyr)

Names <- c("X1") # X1 is the first columns
for (i in 1:200){
  Names <- append(Names, print(paste0("Sample_", i)))
}

read_tsv("/g/data/pq84/malaria/outputs/04_Variant_calling/consensus/GATK_query.tsv", col_names =  Names) %>% 
  select(X1) %>% 
  inner_join(read_tsv("/g/data/pq84/malaria/outputs/04_Variant_calling/consensus/bcftools_query.tsv", col_names =  Names) %>% 
               select(X1)) %>% 
  separate(X1, sep =" ", c("Contig", "Base", "ID", "Ref", "Alt")) %>% 
  write_tsv("/g/data/pq84/malaria/outputs/04_Variant_calling/consensus/vcf_variant_names.tsv")