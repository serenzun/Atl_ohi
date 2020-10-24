
dir_raster0<-file.path("C:/Users/szunino/Documents/big/R_raster_tmp/")
dir_raster<-paste0(dir_raster0,"/prep_fis/")
here()
source(here::here("prep", "FIS","raster_setup.R"))
## Specify years of data, file locations, raster output location
years = c(1999:2015)

annual_files <- list.files(file.path(rastFolder),  full.names=TRUE) #ho messo io i file in questa cartella

#annual_files <- list.files(file.path(dir_w,"int/annual_catch"), full.names=TRUE) 

## Specify a list of arguments - commercial or artisanal - for reading in data and saving raster file name
raw_suffx <- list(catchind = "CatchInd", catchnind = "CatchNInd")
rast_prefx <- list(comm = "comm", artisanal = "artisanal")

library(magrittr)
#ho spostato i file che mi servono nelal cartella github- possibile problema è il settaggio elle cartelle

## Function for totalling landings/discards and saves raster files 
catch2raster <- function(raw_suffx,rast_prefx){
  
  foreach(yr = years) %dopar% { 
    yr = 2015
    
    ## find file path of the respective year of data
    yr <- as.character(yr)
    ## Select the respective year of industrial catch data
    dataname <- str_subset(annual_files, paste0(raw_suffx,"*.",yr))
    
    
    ## read in raw data
    raw_data <- readRDS(dataname[2])
    
    ## Total Landings per Cell
    landings <- raw_data %>%
      dplyr::mutate(Landings_CR = (Landings * 1000)/OceanAreasqkm) %>% # convert to catch rate (kg/km^2)
      dplyr::group_by(Cell) %>%
      dplyr::summarise(cell_catch = sum(Landings_CR, na.rm=TRUE)) %>% # usually no NAs, but just in case
      dplyr::ungroup() %>%
      data.frame()
    head(landings)
    length(unique(raw_data$Cell))
    
    #test what is occurring with cells in v4.0
    #landings_test <- landings %>%
    #  dplyr::arrange(Cell) %>%
    #  dplyr::mutate(lag = lag(Cell)) %>%
    #  dplyr::mutate(difference = Cell - lag)
    
    ## Total Discards per Cell
    discards <- raw_data %>%
      dplyr::mutate(Discards_CR = (Discards * 1000)/OceanAreasqkm) %>% 
      dplyr::group_by(Cell) %>%
      dplyr::summarise(cell_catch = sum(Discards_CR)) %>% 
      dplyr::ungroup()
    
    ## Rasterize Catch: swapping template cell values with those in dataframe
    
    
    raster::subs(cells_raster, landings, by = "Cell", which = "cell_catch", subsWithNA=TRUE, filename = paste0(dir_raster, "comm", '_landings/annual_catch_', yr ,'.tif'), overwrite=TRUE)
    
    rast_test_comm<- raster::subs(cells_raster, landings, by = "Cell", which = "cell_catch", subsWithNA=TRUE)
    
    writeRaster(rast_test_comm, filename = paste0(dir_raster, "comm", "_landings/annual_catch_", yr, ".tif", overwrite=TRUE))
    plot(rast_test)
    
    raster::subs(cells_raster, discards, by = "Cell", which = "cell_catch", subsWithNA=TRUE, 
                 filename = paste0(dir_raster, rast_prefx, '_discards/annual_catch_', yr ,'.tif'), overwrite=TRUE) 
    
    
    ## Applies catch2raster function on commercial (industrial) then artisanal (non-industrial) files
    create_rast <- map2(raw_suffx, rast_prefx, catch2raster)
    ```
    ```{r}
    
    #try to crop large raster with fao raster atl
    regions_atl_FAO <- st_read("~/big/atl_regions/Regions_atl_FAO.shp", quiet = TRUE)
    reg_atl_FAO_sp <- as(regions_atl_FAO, 'Spatial')
    rast_crop_test<-crop(rast_test,reg_atl_FAO_sp)
    rast_mask_test<-mask(rast_crop_test,reg_atl_FAO_sp)
    
    log_Catch <- raster::calc(rast_mask_test, function(x){log(x+1)},
                              filename = paste0(dir_raster,"comm_landings/commLand_2000_2015_log.tif"), overwrite=TRUE)
    
    
    cols = rev(colorRampPalette(brewer.pal(11, 'Spectral'))(255)) # rainbow color scheme
    plot(log_Catch, col=cols, alpha=1)
    