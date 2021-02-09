## shifting a rasters longitude
projection(c_sum) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" 





library(raster)

dir_N = c('Windows' = '//neptune.nceas.ucsb.edu/data_edit',
          'Darwin'  = '/Volumes/data_edit',
          'Linux'   = '/var/data/ohi')[[ Sys.info()[['sysname']] ]]

writeRaster(ma,filename=file.path(data_wd,"ebsa-marine-debris-count_density_size1_360.tif",format="GTiff",overwrite=TRUE))
library(raster)

setwd(data_wd)
crs(x1)=crs(ocean)
x1 <-raster(file.path(data_wd ,'original_eriksen_data/count_density_size1_360.tif'))
plot(x1)
trim <- trim(x1,values=0.2309009)
plot(trim)
#set extent for cropping raster 
ext1 <- c(20, 360, -90, 90)
r1 <- crop(x1, ext1)
#for some reason this crops to extent of 20,360.0111,-90,90 which gives a weird line. Need to reassign extent
extent(r1)<-extent(20,360,-90,90)

projection(r1) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" 
reproj <- projectRaster(r1, crs=mollCRS,over=T,progress='text',filename=file.path(data_wd,'tmp/prova.tif'),overwrite=T)
r1<- CRS('+proj=moll') #
r1 <- shift(r1, 360) #this is 0?
plot(r1)
#set extent for piece of original raster that goes from 360-380. this is going to be chopped off, then moved to the correct side of the raster
ext2 <- c(360, 380, -90, 90)
r2 <- crop(x, ext2)
#extent(r2)<-extent(360,380,-90,90)
r2 <- shift(r2, x=-extent(r2)[1])
out <- merge(r1, r2,overlap=FALSE)

out2 <- rotate(out)  #weird line...not sure where that is coming from.



## shifting a rasters longitude


library(raster)

dir_N = c('Windows' = '//neptune.nceas.ucsb.edu/data_edit',
          'Darwin'  = '/Volumes/data_edit',
          'Linux'   = '/var/data/ohi')[[ Sys.info()[['sysname']] ]]

data_wd = file.path(dir_N,'git-annex/globalprep/CW_pressure_trash/v2015')

setwd(data_wd)

x <- raster('ebsa-marine-debris-count_density_size1_360.tif')
plot(x)
extent(x)
res(x)
crs(x)
trim <- trim(x,values=0.2309009)

#set extent for cropping raster 
ext1 <- c(20, 360, -90, 90)
r1 <- crop(x, ext1)
plot(r1)
extent(r1)
res(r1)
crs(r1)
#for some reason this crops to extent of 20,360.0111,-90,90 which gives a weird line. Need to reassign extent
extent(r1)<-extent(20,360,-90,90)
r1 <- shift(r1, dx=(360-extent(r1)[2])) #this is 0?
plot(r1)
#set extent for piece of original raster that goes from 360-380. this is going to be chopped off, then moved to the correct side of the raster
ext2 <- c(360, 380, -90, 90)
r2 <- crop(x, ext2)
extent(r2)<-extent(360,380,-90,90)
r2 <- shift(r2, dx=-extent(r2)[1])
out <- merge(r1, r2,overlap=FALSE)

out2 <- rotate(out)  #weird line...not sure where that is coming from.




### Used the raster "rotate" function as the general framework
### Here is how you can find the code for a function in a package:
> showMethods(rotate)
# Function: rotate (package raster)
# x="Raster"



#Cut in two pieces, change the extent of the western hemisphere, and merge again.
x1<-x
x1 <- crop(x, extent(180, 360, -90, 90))
plot(x1)
x2 <- crop(x, extent(0, 180, -90, 90))   
plot(x2)
extent(x1) <- c(0, 180, -90, 90)
extent(x2)<- c(180, 360, -90, 90)
ma <- merge(x1, x2,overlap=FALSE)
plot(ma)
extent(ma)
plot(ocean)
crs(ma)=crs(ocean)

projection(ma) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"  

ma <- projectRaster(ma, crs=mollCRS,over=T,progress='text',filename=file.path(data_wd,'tmp/prll.tif'),overwrite=T)
writeRaster(ma, 'tmp/merdall.tif',format="GTiff",overwrite=T)
extent(ma)
extent(ocean)
#This assumes a well behaved global raster with edges at -180, and 180 and the zero meridian being in between two columns.
getwd()
xyz<-read.csv("Xplus180%360meno180.csv")
cells_raster <- rasterFromXYZ(xyz)
writeRaster(cells_raster, 'tmp/celia.tif', format="GTiff")
plot(cells_raster)
cells=projectRaster(ma, crs=('+proj=moll'))
crs(cells_raster)
crs(ma)
proj4string(ma)
proj4string(ocean)

extent(cells)=extent(ocean)
plot(cells)
plot(trash)

trash<-projectRaster(cells_raster, crs=crs(ocean), extent=extent(ocean))

crs(ma)

#metodo celia con python
new_Lon = ( old_Lon + 180 )%360 -180

rgdal::getGDALVersionInfo()
rgdal::getPROJ4VersionInfo()
packageVersion("rgdal") 
packageVersion("raster")
