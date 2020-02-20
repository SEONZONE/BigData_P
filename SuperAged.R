install.packages('gganimate')
install.packages('gifski')
install.packages('png')
library(gganimate)
library(gifski)
library(png)
library(dplyr)
library(tidyr)
library(ggplot2)
library(reshape2)
library(readxl)
# ++++++++++++++++++++++
# ++++ 인구피라미드 ++++
# ++++++++++++++++++++++


datPop <- data.table::fread('material/population.csv', encoding='UTF-8')
datPop2 <- read_excel('material/2021~2023.xls')
datPop3 <- read_excel('material/2050.xlsx')

datPopAni <- datPop %>% mutate(year=as.integer(year)) %>% gather(key='gender', value='population', male, female)
datPop2Ani <- datPop2 %>% mutate(year=as.integer(year)) %>% gather(key='gender', value='population', male, female)
datPop3Ani <- datPop3 %>% mutate(year=as.integer(year)) %>% gather(key='gender', value='population', male, female)

datPopAni <- subset(datPopAni,select=-age)
datPop4Ani <- rbind(datPopAni,datPop2Ani)
datPop5Ani <- rbind(datPop4Ani,datPop3Ani)

ggplot(datPop5Ani, aes(x=age2, 
                       y=ifelse(gender=='male', 
                                population/10000, -population/10000), fill=gender)) +
  geom_bar(stat='identity') +
  geom_bar(stat='identity', width=0.9,alpha=0.8) +
  scale_x_continuous(name='나이') +
  scale_y_continuous(name='인구(만명)', labels=c(50, 25, 0, 25, 50)) + 
  coord_flip() +
  labs(title = '한국의 인구 변화 ({frame_time} 년)')+
  scale_fill_manual(name='성별', labels=c('여', '남'), values=c('#FF33CC', 'dodgerblue2'))+
  theme_minimal() +
  theme(legend.position='bottom', title=element_text(size=16)) + 
  theme(legend.position='bottom') +
  transition_time(year) + 
  enter_fade() -> p
p
anim_save("populationratio.gif")


# ++++++++++++++++++++++ 
# ++++ 재가 실 사용자 그래프 ++++
# ++++++++++++++++++++++
# 엑셀 파일 읽어들이기
grade <- read_excel('material/등급별.xlsx')
as.data.frame(grade)

View(grade)
# 불필요한 부분 지우기 
grade1 <- subset(grade,select=-qualify)

View(grade1)
# melt
grade_result <- melt(grade1,id.vars='area')

View(grade_result)
# ggplot,geom_bar 를 이용하여 그래프로 나타내기 
ratio <- ggplot(grade_result,aes(x=area,y=value,fill=variable))
ratio + geom_bar(stat='identity',position = 'dodge') + scale_fill_manual(name='', labels=c('재가 대상자', '실제 이용자'), values=c('darkorange', 'dodgerblue2')) +xlab('지역') + ylab('비율') +theme_bw()+scale_y_continuous(breaks=seq(0,25,1))



# ++++++++++++++++++++++
# ++++ 복지시설실태 ++++
# ++++++++++++++++++++++
area<-read_excel("material/실태.xlsx")
View(area)

ggplot(data = area, aes(x =facilities, y =수용인원)) +
  geom_col(fill="dodgerblue2")+                                             #색깔지정
  scale_y_continuous(breaks=seq(10000,2700000,250000))+                     #칸 수
  ggtitle('복지시설과 이용자 수')+ theme_bw()+                              # theme_bw 사각형
  ylab("수용인원") + xlab("시설")+
  theme(plot.title = element_text(                                          #타이틀 지정
    face="bold",
    hjust=0.5,
    vjust=1,
    size=20,
    color="#FF6600"))+
  geom_line(data = area,color="orange",size=1.5, aes(x =facilities, y = 사용인원, group = 1,))+
  geom_point(data = area,color="orange",size=3, aes(x =facilities, y = 사용인원, group = 1)) +
  theme(legend.position = "top")


# ++++++++++++++++++++++++++++++++++
# +++++++++복지시설그래프+++++++++++
# ++++++++++++++++++++++++++++++++++
