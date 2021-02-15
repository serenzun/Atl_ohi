
x <- file.path(dir_w, "CatchInd1950_1954.rds")

## Read in the catch data
## Create a total Landings column
## Join with master and spatial cells file
df <- readRDS(x) %>%
  dplyr::mutate(Landings = Reported+IUU) %>% 
  dplyr::left_join(master, by = "ID") %>% 
 # dplyr::left_join(spatialCells, by = "Cell") %>% 
  dplyr::inner_join(cell_atl, by = "Cell")
   #dplyr::inner_join(geometry!="POINT EMPTY")

  df_atl<-df



head(df)
length(df)

cells_atl

df_atl <- readRDS(df) %>%
  dplyr::left_join(cell_atl, by = "Cell")
