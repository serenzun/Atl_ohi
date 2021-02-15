---
title: "fis"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
library(tidyverse)
library(purrr)
library(here) # install.packages("here")
library(readxl)
setwd(here::here("prep","FIS"))
source(here::here("R", "setup.R"))
dir_B<-file.path("C:/Users/szunino/Documents/big") #virtual machine
rawFolder<-file.path("C:/Users/szunino/Documents/big/fis/watson/raw")#folder with IMAS_GLobalFisheriesLandings
rastFolder <- paste0(rawFolder,"/raster/")
```

```{r}
#read in on eof the catch data
catch <- readRDS(file.path(dir_B,"FIS/watson/raw/int/annual_catch/CatchNInd_2015.rds"))
head(catch)

```

```{r}
#create a raster of Cell numbers
##This Codes.xlsx was downloaded from the same place as the raw Watson data
cells <- read_excel(file.path(rawFolder, "Codes.xlsx"), sheet = "Cell")%>%
  dplyr::rename(x = LonCentre,  y = LatCentre, z = Cell) %>% #I renamed these xyz to use in the rasterFromXYZ() function below
  dplyr::select(x,y,z)
#turn the lat/long points into a raster
cells_raster <- rasterFromXYZ(cells)

crs(cells_raster) <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0" 
crs(cells_raster)
#check out the cells raster to make sure it looks good
plot(cells_raster)
```


```{r}

file <- file.path(dir_M,'git-annex/globalprep/fis/v2019/int/stock_catch_by_rgn_taxa.csv')

catch <- read_csv(file) %>%
  rename(common = CommonName, fao_id = fao_rgn, species=TaxonName)

summary(catch)

## calculate total annual catch for each stock
catch <- catch %>%
  dplyr::select(year, rgn_id, fao_id, stock_id, TaxonKey, tons) %>%
  group_by(rgn_id, fao_id, TaxonKey, stock_id, year) %>%
  summarize(catch = sum(tons)) %>%
  ungroup()
```

