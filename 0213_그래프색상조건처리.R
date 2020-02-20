library(readxl)
library(dplyr)
library(ggplot2)


# ========== 데이터 준비 ========== 

# 엑셀 읽기
pac <- read_xlsx("material/노인복지생활시설수.xlsx")


# 데이터 전처리
pacdata <-  as.data.frame(pac)
pacdata <- rename(pacdata, cnt = "춧")
# ========== 데이터타입 변경 ========== 
# place 변수는 그래프에서 x축에 출력된다. 
# 이때 place 변수명은 자동으로 가나다순으로 정렬된다. 
# place 변수가 팩터형일 경우에는 자동으로 정렬되지 않는다. 
# 따라서 place 변수의 데이터타입을 팩터형으로 변경한다.


# 데이터타입 확인
#   - 현재 데이터타입은 문자형이다.
str(pacdata$place)


# place 변수 데이터타입 변경
#   - 문자형 -> 팩터형
pacdata$place <- as.factor(pacdata$place)


# 데이터타입 확인
#   - 데이터타입이 팩터형으로 변경되었다.
str(pacdata$place)


# 데이터 확인
#   - 레벨 순서에 의해 변수 내용이 화면에 출력된다.
#   - 레벨이 원하는 순서인지 확인한다.
pacdata$place


# 레벨 순서 설정
#   - 원하는 순서대로 레벨 순서를 변경한다.
pacdata$place <- 
  factor(pacdata$place, levels = c("노인주거복지시설", "노인의료복지시설", "노인여가복지시설", "재가노인복지시설"))


# 데이터 확인
#   - 원하는 순서대로 레벨 순서가 변경되었다.
pacdata$place




# ========== 그래프  ========== 

# 그래프 작성
ggplot(pacdata, aes(x=place, y=cnt)) + 
  geom_col()


# 그래프 색상 변경
#   - 조건에 맞게 그래프 색상을 변경한다.
ggplot(pacdata, aes(x=place, y=cnt)) + 
  geom_col( fill = ifelse(pacdata$cnt >= 10000, "orange", 
                          ifelse(pacdata$cnt >= 5000, "dodgerblue2",
                                 ifelse(pacdata$cnt >= 1000, "dodgerblue", "darkorange")))) +
  xlab('노인복지시설') + ylab('인원') +
  theme_bw()+ scale_y_continuous(breaks=seq(0,100000,5000)) 





