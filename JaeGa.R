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
library(rgeos)
library(maptools)
library(dplyr)


korea <- shapefile("material/TL_SCCO_CTPRVN.shp")

korea <- spTransform(korea,CRS("+proj=longlat"))
kore_map <-fortify(korea)

population <- read_excel("material/전국재가.xlsx")
as.data.frame(population)
View(population)

JaeGa <- population %>% dplyr::select('area','ratio','id')
View(JaeGa)

View(merge_result)

merge_result <- merge(kore_map,JaeGa,by="id")
population <- ggplot() + geom_polygon(data=merge_result,aes(x=long,y=lat,group=group,fill=ratio)) +labs(fill="전국 재가이용률") + theme_void() 

population + scale_fill_gradientn(colours = c("green","red"),
                                  values = scales::rescale(seq(0,10,0.01))) +theme(plot.title=element_text( face="bold", size=20, vjust=2)) + ggtitle("전국 소득비례 독거노인 비율")


