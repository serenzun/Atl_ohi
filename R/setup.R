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

#for the directories run the appropriate directories file

## color palette
cols = rev(colorRampPalette(brewer.pal(11, 'Spectral'))(255)) # rainbow color scheme
mytheme=rasterTheme(region=cols)
#<<<<<<< HEAD
###set the memory size (since I'm working on the virtual machine)
#memory.limit(size=56000)
#=======
##Spatial files
#>>>>>>> 34356ef819cd2f03894c741cae40a1cba0dc658c
#

insta
