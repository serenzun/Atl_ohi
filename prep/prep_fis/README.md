in the original ohi data prep the file are in prs_fis. 

in my virtual pc the file are located in the rastFolder in the fis folder. fis/watson/raw/raster

here i've saved all the file that I've obtained through the watson data. here I will find both the draster of land/disc, commerci/artisanl and their copy corrected with the NPP layers. 

This mismatch should be solved in the next future in order to make easier to understand the difference


#DParallel
the error, also the other time, was to to upload the libraries for each code.
thus, after call the core with registerDoParallel, we have to insert in the foreach the function .packages and call back tha packages needed in the particular loop fucntion

registerDoParallel(3)
doParallel::registerDoParallel()
getDoParWorkers()

cl<-makeCluster(2)
registerDoParallel(cl)
clusterCall(cl, function() library(magrittr))##♥non riesce a lavorare in parallelo. è come se ogni nuovo cor non avesse i pacchetti installati
## check to see which years of data to run in the foreach() loop
 years_of_data[[1]]:years_of_data[[length(years_of_data)-4]]
foreach (i = 2003:2011, .packages=c("dplyr", "stringr","raster"))  %dopar%{ # i = 2010
  
  yrs <- c(i:(i+4))
  
  
  
##Problem with the raster analysis. 
to compjute the reference point, shoul I first crop the raster to the atlantic regions?
I think so..ask to the ohi team 

to do so, use fishin pressure layer and at row 552 perform the crop and mask operations


--> I've crop to the atl_mask_hirgres but i wasn't able to use the mask funciton since the extension doens't overlap. I think this is the reason why there's still the pacific ocean and the land.

##NPP file 
should be replace witht the CMEMS file of NPP
