library(ggplot2)
library(readxl)
library(reshape2)

oldAge <- read_excel("material/노인천명.xlsx")
as.data.frame(oldAge)

View(oldAge)
str(oldAge)

oldAge2 <- reshape2::melt(oldAge,id.vars="Year")
View(oldAge2)

oldAge3 <- ggplot(oldAge2,aes(x=Year,y=value,fill=variable)) 
oldAge3 + geom_line(color="blue",size=1.3)  + scale_x_continuous(breaks=seq(0, 2020, 1)) +scale_y_continuous(breaks=seq(0,15,0.1)) +  ylab("Percent") +geom_point(color="red") +theme_bw() + theme(legend.position ="none")
  


