#### base sirene ####
rm(list = ls())
setwd("/Users/admin/Desktop")
library(readxl)
library(dplyr)

naf = read_excel("int_courts_naf_rev_2.xls")
naf <- as.data.frame(as.data.frame(apply(naf,2,tolower))[,c(2,4)])
colnames(naf) = c("code","secteur")

naf = as.data.frame(naf[!grepl("fabrication", naf$secteur), ]) %>% unique() %>% na.omit()
colnames(naf) = c("code","secteur")

sports = as.data.frame(naf[grepl("sport|physique", naf$secteur) , ]) 
colnames(sports) = c("code","secteur")
sports = as.data.frame(sports[!grepl("transport", sports$secteur), ]) %>%
  unique()


enfants = as.data.frame(naf[grepl("enseignement|pédia|crèches", naf$secteur) , ]) %>% unique()
colnames(enfants) = c("code","secteur")

politique = as.data.frame(naf[grepl("politique", naf$secteur) , ])
religieux = as.data.frame(naf[grepl("religi", naf$secteur) , ])

colnames(politique) = c("code","secteur")
colnames(religieux) = c("code","secteur")