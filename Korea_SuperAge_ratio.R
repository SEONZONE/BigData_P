install.packages("ggmap")
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("maptools")
install.packages("rgdal")
install.packages('readxl')
library(RColorBrewer)
library(ggmap)
library(ggplot2)
library(readxl)
library(raster)
library(raster)
library(rgeos)
library(maptools)
library(dplyr)
install.packages("viridis")
library(viridis)


display.brewer.all()
korea <- shapefile("material/TL_SCCO_CTPRVN.shp")
  
korea <- spTransform(korea,CRS("+proj=longlat"))
kore_map <-fortify(korea)

population <- read_excel("material/고령인구비율.xlsx")
as.data.frame(population)
View(population)

y00 <- population %>% select('시도','y00','id')
View(y00)

y04 <- population %>% select('시도','y04','id')
View(y04)

merge_00<- merge(kore_map,y00,by="id")
y00 <- ggplot() + geom_polygon(data=merge_00,aes(x=long,y=lat,group=group,fill=y00)) +labs(fill="2000년도 고령화 비율(%)") 
y00


merge_04<- merge(kore_map,y04,by="id")
y04 <- ggplot() + geom_polygon(data=merge_04,aes(x=long,y=lat,group=group,fill=y04)) +labs(fill="2004년도 고령화 비율(%)") 
y04 +  scale_fill_gradient(low="green", high="red", limits=c(0.1, 14))

