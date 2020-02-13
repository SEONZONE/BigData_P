library(readxl)
library(reshape2)

grade <- read_excel('material/등급별.xlsx')
as.data.frame(grade)

View(grade)
grade1 <- subset(grade,select=-qualify)

View(grade1)
grade_result <- melt(grade1,id.vars='area')

View(grade_result)

ratio <- ggplot(grade_result,aes(x=area,y=value,fill=variable))
ratio + geom_bar(stat='identity',position = 'dodge') + scale_fill_manual(name='성별', labels=c('재가 대상자', '실제 이용자'), values=c('darkorange', 'dodgerblue2')) +xlab('지역') + ylab('비율') +theme_bw()+scale_y_continuous(breaks=seq(0,25,1))
