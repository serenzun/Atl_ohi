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


library(parallel)
library(foreach)
library(doParallel)
library(rasterVis)
library(seaaroundus)
library(RColorBrewer)
library(cowplot)
library(stringr)
library(colorspace)

##Directories:
#dir_prep<-here::here("prep")
dir_B<-file.path("C:/Users/szunino/Documents/big") #virtual machine

rastFolder <- file.path("C:/Users/szunino/Documents/github/Atl_ohi/prep/FIS/annual_catch/")

atl_gh<-"https://github.com/serenzun/Atl_ohi"
atl_ohi<-file.path("C:/Users/szunino/Documents/github/Atl_ohi/prep/FIS/annual_catch/")

<<<<<<< HEAD
##set the memory size (since I'm working on the virtual machine)
memory.limit(size=56000)
=======
#Spatial files
>>>>>>> 34356ef819cd2f03894c741cae40a1cba0dc658c
