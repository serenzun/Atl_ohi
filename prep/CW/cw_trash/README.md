# README



steps to assess marine plastic layer

1)Eriksen data are not available from OHI-science git-hub. I am waiting for a response by the OHI team.
Meanwhile, I have found the count data of Eriksen 2014 on the australian geoserver. 
I have download the data that are to reproject since the raster is centered over the Pacific ocean

https://www.cmar.csiro.au/geoserver/web/wicket/bookmarkable/org.geoserver.web.demo.MapPreviewPage?0&filter=false

I have used the OHi team script with many corrections to shift the lingitudes 
(Celia Laurent provided me reprojection made by python:
    here I described the process made by Celia that I have not used but may be useful 
  in the future
  
  Come primo step ho utilizzato QGIS per convertire il raster in xyz , come nella stampa di schermo un allegato :
    - raster->convertion->translate
  - poi indicare un nome di un file con formato .xyz (nell esempio : test.xyz)
Come secondo step, devi girare il file python serena.py (modificanto eventualmente i nomi dei file di input e di output)
                new_Lon = ( old_Lon + 180 )%360 -180      
                
2) The raster layer are converted one by one (it was the only way to make them run in the next script)
   shiftLOng_repeat
   Basically, these are the steps:
   x <- raster(file.path(data_wd ,'geotiff_geoserver_debris/ebsa-marine-debris-count_density_size3_360.tif'))
  
   #Cut in two pieces, change the extent of the western hemisphere, and merge again.
   x1<-x
   x1 <- crop(x, extent(180, 360, -90, 90))
   x2 <- crop(x, extent(0, 180, -90, 90))   
   extent(x1) <- c(-150, 0, -90, 90)
   extent(x2)<- c(0, 150, -90, 90)
   ocean = raster(file.path(dir_B,'prep/spatial/spatial_ohi_supplement/ocean.tif'))
   
   ma <- merge(x1, x2,overlap=FALSE)
   latlong=crs("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
   crs(ma)<-"+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
   ma <- projectRaster(ma, crs=(ocean))
   writeRaster(ma,filename=file.path(data_wd,"sa-marine-debris-count_density_size3_360.tif"), format="GTiff",overwrite=TRUE)
   
3)I have run the marine plastic script:

>  c_log = calc(count_mask,fun=function(x){log(x+1)},filename=file.path(data_wd,'/tmp/count_sum_    moll_1km_clip_log.tif'),overwrite=T)
>    c_log = raster(file.path(data_wd,'/tmp/count_sum_moll_1km_clip_log.tif'))
    
>    plot(c_log,col=cols,main='Count density\nlog(pieces/km2)')
  
  ![alt text](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0111913)
  
  