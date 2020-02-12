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
# ============== excel 파일 넣기 ==============
datPop <- data.table::fread('material/population.csv', encoding='UTF-8')
datPop2 <- read_excel('material/2021~2023.xls')
datPop3 <- read_excel('material/2050.xlsx')

head(datPop2)
str(datPop3)
View(datPop3)
# ======================== 합치고 rbind() ======================== 
datPop2Ani <- datPop2 %>% mutate(year=as.integer(year)) %>% gather(key='gender', value='population', male, female)
datPopAni <- datPop %>% mutate(year=as.integer(year)) %>% gather(key='gender', value='population', male, female)
datPop3Ani <- datPop3 %>% mutate(year=as.integer(year)) %>% gather(key='gender', value='population', male, female)

datPop4Ani <- rbind(datPop4Ani,datPop3Ani)
View(datPop4Ani)

datPopAni <- subset(datPopAni,select=-age)
#================ gganimate 실행 =========================

ggplot(datPopAni, aes(x=age2, 
                      y=ifelse(gender=='male', 
                               population/10000, -population/10000), fill=gender)) +
  geom_bar(stat='identity') +
  geom_bar(stat='identity', width=0.9,alpha=0.8) +
  scale_x_continuous(name='나이') +
  scale_y_continuous(name='인구(만명)', labels=c(50, 25, 0, 25, 50)) + 
  coord_flip() +
  labs(title = '한국의 인구 구조 변화 ({frame_time} 년)')+
  scale_fill_manual(name='성별', labels=c('여', '남'), values=c('darkorange', 'dodgerblue2'))+
  theme_minimal() +
  theme(legend.position='bottom', title=element_text(size=16)) + 
  theme(legend.position='bottom') +
  transition_time(year) + 
  enter_fade() -> p
p
