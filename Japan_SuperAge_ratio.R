install.packages("readxl")
install.packages("ggplot2")
install.packages("reshape")
install.packages("reshape2")
install.packages("dplyr")

library(dplyr)
library(readxl)
library(ggplot2)
library(reshape)
library(reshape2)
japanth <-read_excel("material/일본노인th.xlsx")
as.data.frame(japanth)
as.list(japanth)


data_japanth <- melt(japanth,id.vars = 'Year')
japan <- ggplot(data_japanth,aes(Year,value)) +geom_line(aes(colour=variable),size=1.3) 
japan + geom_point (aes (color = variable),size=3)



