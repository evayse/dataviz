#### Data visualisation ####

rm(list = ls())
setwd("/Users/admin/Desktop/3A/Semestre 2/Data_viz")
library(dplyr)
library(ggmap)

#### I) Analysis of the catalogue of the datasets ----

catalogue = read.csv2("Raw/data_paris_catalogue.csv")

#### II) Computation of statitics to find Fun facts ----

#### A) Surface (km^2) by district (from http://splaf.free.fr/75des.html) ---- 
arrondissement = c(1, 2, 3, 4, 5,
                   6, 7, 8, 9, 10, 
                   11, 12, 13, 14, 15, 
                   16, 17, 18, 19, 20)
surface = c(1.83,0.99,1.17,1.60,2.54,2.15,4.09,3.88,2.18,2.89,3.67,16.32,7.15,5.64,8.48,16.37,5.67,6.01,6.79,5.98)
surface = as.data.frame(cbind(arrondissement, surface))

rm(arrondissement)


#### B) One euro coffee ----
coffee = read.csv2("Raw/one_euro_coffee.csv")
colnames(coffee) = tolower(colnames(coffee))

coffee = as.data.frame(table(coffee$arrondissement)) %>%
  dplyr::rename(arrondissement = Var1,
                nb_cafe = Freq) %>%
  dplyr::mutate(arrondissement = as.numeric(arrondissement)) %>%
  dplyr::left_join(surface, by  = "arrondissement") %>%
  dplyr::mutate(densite_cafe = nb_cafe/surface) %>%
  as.data.frame()

# Undeniably, the 2nd district is where the density of cheap coffee is the highest (12.12 vs 4.72 for the second best).

#### C) Landform (relief) ----

landform = read.csv2("Raw/landform.csv") %>%
  dplyr::mutate(lat = as.numeric(gsub("\\,.*","",Geometry.X.Y, fixed = F)),
                lon = as.numeric(gsub(".*,", "", Geometry.X.Y))
                ) %>%
  dplyr::select(Libelle, lon, lat)

localisation <- do.call(rbind,
                                 lapply(1:2,
                                        function(i)revgeocode(as.numeric(landform[i,3:2]))))

colnames(landform) = tolower(colnames(landform))




