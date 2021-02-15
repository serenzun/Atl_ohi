library(here)
source(here("R", "setup.R"))



regions <- read_sf(dsn = file.path(dir_B, "prep/spatial/spatial_ohi_supplement/regions"), layer = "regions_gcs") %>%   filter(rgn_typ %in% c("eez","fao")) 

rgns<-as(regions, "Spatial")


#non funziona
#rgns_atl<-raster::crop(rgns,reg_atl_FAO_sp)



#Read Atlantic mask
atl_mask <- raster(file.path(dir_B, 'prep/spatial/output/atl_mask.tif'))
plot(atl_mask)


#Read shapefile of FAO Atlantic
regions_atl_FAO <- st_read("~/big/prep/spatial/output/Regions_atl_FAO.shp", quiet = TRUE)
plot(regions_atl_FAO[1])


rgns_lng_atl<-read_sf(dsn=file.path(dir_B,"prep/spatial/output/atl_ohi_longhurst.shp"),layer="atl_ohi_longhurst")
regions <- read_sf(dsn = file.path(dir_B, "prep/spatial/spatial_ohi_supplement/regions"), layer = "regions_gcs") %>% 
  filter(rgn_typ %in% c("eez","fao")) 



lng_fao<-read_csv(file.path("C:/Users/szunino/Documents/big/prep/spatial/output/lng_fao.csv"))

RAM_fao_ohi_rgns_final<-read_csv(file.path("C:/Users/szunino/Documents/big/prep/fis/raw/int/RAM_fao_ohi_rgns_final.csv"))