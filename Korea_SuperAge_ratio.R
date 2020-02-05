install.packages("ggmap")
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("maptools")
install.packages("rgdal")
install.packages('readxl')
install.packages("viridis")
library(RColorBrewer)
library(ggmap)
library(ggplot2)
library(readxl)
library(raster)
library(raster)
library(rgeos)
library(maptools)
library(dplyr)
library(viridis)


display.brewer.all()
korea <- shapefile("material/TL_SCCO_CTPRVN.shp")
  

korea <- spTransform(korea,CRS("+proj=longlat"))
kore_map <-fortify(korea)

population <- read_excel("material/고령인구비율.xlsx")
as.data.frame(population)
View(population)

y00 <- population %>% select('시도','y00','id')
View(y19)

y19 <- population %>% select('시도','y19','id')
merge_19<- merge(kore_map,y19,by="id")
y19 <- ggplot() + geom_polygon(data=merge_19,aes(x=long,y=lat,group=group,fill=y19)) +labs(fill="2019년도 고령화 비율(%)")  
y13 +  scale_fill_gradient(low="green", high="red", limits=c(0,23))

