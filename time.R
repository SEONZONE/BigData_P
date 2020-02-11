library(ggplot2)
library(readxl)
library(reshape2)

oldAge <- read_excel("material/percent.xlsx")
as.data.frame(oldAge)

View(oldAge)
str(oldAge)

oldAge2 <- reshape2::melt(oldAge,id.vars="YEAR")
View(oldAge2)

oldAge3 <- ggplot(oldAge2,aes(x=YEAR,y=value,fill=variable)) 
oldAge3 +geom_line(aes(color=variable),size=1.3) + theme_dark()+theme(legend.title = element_blank()) + scale_x_continuous(breaks=seq(0, 2020, 5)) +  scale_y_continuous(breaks=seq(0, 100, 10)) +  ylab("PERCENT") 



