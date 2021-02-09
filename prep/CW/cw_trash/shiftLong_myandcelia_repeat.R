##cancellabile

#this file is used to save the new raster geotiff to read in marine plastic script
mytheme <- rasterTheme(region = rev(colorRampPalette(brewer.pal(11, 'Spectral'))(255)))
library(here)
here()
source(here::here("R","setup.R"))
#set working directory on neptune
data_wd = file.path(dir_B,'R_raster_tmp/trash')
count_density_size3_360<-rotate(raster(file.path(data_wd ,'original_eriksen_data/count_density_size3_360.tif')))
plot(count_density_size3_360)

writeRaster(count_density_size3_360, filename = file.path(data_wd,"count_density_size3_360"), format="GTiff", overwrite=TRUE)


count_density_size4_360<-rotate(raster(file.path(data_wd ,'original_eriksen_data/count_density_size4_360.tif')))
plot(count_density_size3_360)

writeRaster(count_density_size4_360, filename = file.path(data_wd,"count_density_size4_360"), format="GTiff", overwrite=TRUE)


weight_density_size1_360<-rotate(raster(file.path(data_wd ,'original_eriksen_data/weight_density_size1_360.tif')))
plot(count_density_size3_360)

writeRaster(weight_density_size1_360, filename = file.path(data_wd,"weight_density_size1_360"), format="GTiff", overwrite=TRUE)

rotate_raster<-(rotate(r))
plot(rotate_raster)

x1 <- crop(r, extent(0, 180, -90, 90))
plot(x1)
extent(x1)<-extent(0,180,-90,90)
extent(x1) <- c(180, 360, -90, 90)
plot(x1)
x1
res(x1)=res(r)
x2 <- crop(r, extent(180, 360, -90, 90))   
extent(x2)<-extent(180, 360,-90,90)
extent(x2)<-extent(0,180,-90,90)

plot(x2)
x2
res(x2)=res(r)
m <- merge(x1, x2,tolerance=0.5, overlap=TRUE)
plot(m)
rasterOptions(tolerance = 0.1)


#set extent for cropping raster 
ext1 <- c(20, 360, -90, 90)
r1 <- crop(r, ext1)
#for some reason this crops to extent of 20,360.0111,-90,90 which gives a weird line. Need to reassign extent
extent(r1)<-extent(20,360,-90,90)
r1 <- shift(r1, 360-extent(r1)[2]) #this is 0?
plot(r1)
#set extent for piece of original raster that goes from 360-380. this is going to be chopped off, then moved to the correct side of the raster
ext2 <- c(180, 360, -90, 90)
r2 <- crop(r, ext2)
extent(r2)<-extent(180,360,-90,90)
r2 <- shift(r2, -extent(r2)[1])
out <- merge(r1, r2,overlap=FALSE)
plot(out)



trim <- trim(x,values=0.2309009)
#Cut in two pieces, change the extent of the western hemisphere, and merge again.
x1 <- crop(x, extent(180, 360, -90, 90))
plot(x1)

x2 <- crop(x, extent(0, 180, -90, 90))   
plot(x2)

extent(x1) <- c(0, 180, -90, 90)
extent(x2)<- c(181, 361, -90, 90)

x1
x2
plot(x2)
extent(x1) <- c(-150, 0, -90, 90)
extent(x2)<- c(0, 150, -90, 90)
ocean = raster(file.path(dir_B,'prep/spatial/spatial_ohi_supplement/ocean.tif'))

ma <- raster::merge(x1, x2,overlap=FALSE)
latlong=crs("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")
crs(ma)<-"+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
ma <- projectRaster(ma, crs=(ocean))
writeRaster(ma,filename=file.path(data_wd,"sa-marine-debris-count_density_size3_360.tif"), format="GTiff",overwrite=TRUE)
plot(ma)
#writeRaster(ma, 'tmp/ma.tif', format="GTiff")
#merge<-raster("tmp/ma.tif")
#plot(merge)
??col
```

ocean = raster(file.path(dir_B,'prep/spatial/spatial_ohi_supplement/ocean.tif'))
extent(ma)=extent(ocean)
plot(ma)


```{r}
extent(ma)
ocean = raster(file.path(dir_B,'prep/spatial/spatial_ohi_supplement/ocean.tif'))
plot(ocean)
crs(ma)=crs(ocean)
extent(ma)=extent(ocean)
projection(ma) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"  

writeRaster(ma,filename=file.path(data_wd,"sa-marine-debris-count_density_size1_360.tif"), format="GTiff",overwrite=TRUE)
??writeRaster
ma <- projectRaster(ma, crs=(ocean))
plot(ma)+
  plot(ocean, add=TRUE)