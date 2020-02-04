install.packages("ggmap")
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("maptools")
install.packages("rgdal")
install.packages('readxl')
library(ggmap)
library(ggplot2)
library(readxl)
library(raster)
library(raster)
library(rgeos)
library(maptools)
library(dplyr)

korea <- shapefile("TL_SCCO_CTPRVN.shp")
  
korea <- spTransform(korea,CRS("+proj=longlat"))
kore_map <-fortify(korea)

population <- read_excel("고령인구비율.xlsx")
as.data.frame(population)
View(population)

y00 <- population %>% select('시도','y00','id')
View(th00)

y04 <- population %>% select('시도','y04','id')
View(y04)

merge_result <- merge(kore_map,y04,by="id")
population <- ggplot() + geom_polygon(data=merge_result,aes(x=long,y=lat,group=group,fill=y04)) +labs(fill="2004년도 고령화 비율(%)") 

population
population + scale_fill_gradient(low = 'green' ,high='red')




