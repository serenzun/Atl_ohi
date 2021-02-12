#Common workflow
##Libraries:
library(tidyverse)
library(purrr)
library(here) # install.packages("here")
library(readxl)

## spatial libraries

library(sp)
library(rgdal)
library(sf)
library(raster)

#install.packages("rgdal")
library(parallel)
library(foreach)
library(doParallel)
library(rasterVis)
library(seaaroundus)
library(RColorBrewer)
library(cowplot)
library(stringr)
library(colorspace)

#for the directories run the appropriate directories file
##Directories:
#dir_prep<-here::here("prep")
dir_B<-file.path("C:/Users/szunino/Documents/big") #virtual machine
dir_sp<-file.path("C:/USers/szunino/Documents/big/prep/spatial")
#rastFolder <- file.path("C:/Users/szunino/Documents/github/Atl_ohi/prep/FIS/annual_catch/")
rastFolder<-"C:/Users/szunino/Documents/big/prep/fis/watson/raw/raster/"#non ci capisco piu nulla. check readme fis_prs
atl_gh<-"https://github.com/serenzun/Atl_ohi"
atl_ohi<-file.path("C:/Users/szunino/Documents/github/Atl_ohi/prep/FIS/annual_catch/")

##Directories:
#dir_prep<-here::here("prep")
#dir_B<-file.path ("C:/Users/Acer/Documents/big") #virtual machine
#dir_sp<-file.path("C:/USers/Acer/Documents/big/prep/spatial")
##rastFolder <- file.path("C:/Users/szunino/Documents/github/Atl_ohi/prep/FIS/annual_catch/")
#rastFolder<-"C:/Users/Acer/Documents/big/prep/fis/watson/raw/raster/"#non ci capisco piu nulla. check readme fis_prs
#atl_gh<-"https://github.com/serenzun/Atl_ohi"
#atl_ohi<-file.path("C:/Users/Acer/Documents/github/Atl_ohi/prep/FIS/annual_catch/")
#
## color palette
cols = rev(colorRampPalette(brewer.pal(11, 'Spectral'))(255)) # rainbow color scheme
mytheme=rasterTheme(region=cols)
#<<<<<<< HEAD
###set the memory size (since I'm working on the virtual machine)
#memory.limit(size=56000)
#=======
##Spatial files
#>>>>>>> 34356ef819cd2f03894c741cae40a1cba0dc658c
mollCRS <- CRS('+proj=moll')
mollCRS=crs('+proj=moll +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs')
