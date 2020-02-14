install.packages("twitteR")
library(twitteR)
library(KoNLP)
useSejongDic()
#API key: o2osRA1cWvqte3qzWMsjcfE3Z
#API secret key: ocyOcl2F3jmtrDZ03KvoMHYghpKPRj8ZkvpkJ9f3lBcCS0Ikj0
# Access token : 1220541464368648193-nKZrB47vCzMdxd8IERz2CybceA0GH8
# Access token secret : bLEhgT2Gbwk5f0TgVOvQ2GPCpPN88lRf9vQ2fsPyvwQBL
# 트위터 API 인증
consumerKey = "o2osRA1cWvqte3qzWMsjcfE3Z"
consumerSecret = "ocyOcl2F3jmtrDZ03KvoMHYghpKPRj8ZkvpkJ9f3lBcCS0Ikj0"
accessToken = "1220541464368648193-nKZrB47vCzMdxd8IERz2CybceA0GH8"
accessTokenSecret = "bLEhgT2Gbwk5f0TgVOvQ2GPCpPN88lRf9vQ2fsPyvwQBL"
# OAuth 인증
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret )
# 키워드검색 
keyword <-  enc2utf8("노령화")
bigdata <-  searchTwitter(keyword, n = 20000, lang = "ko")
# 크롤링 결과를 데이터 프레임 변환 
bigdata_df <-  twListToDF(bigdata)
str(bigdata_df)
#텍스트 열 추출 
bigdata_text <-  bigdata_df$text
head(bigdata_text)
#워드 클라우드 라이브러리 호출 
library(wordcloud2)
# 함수이용해서 명사만 추출 
bigdata_noun <-  sapply(bigdata_text, extractNoun, USE.NAMES =  F)
bigdata_noun <-  unlist( bigdata_noun)
# 2글자만 추출, 정규표현식으로 특수문자, 영어,숫자 제거 
bigdata_noun <-  Filter(function(x) {nchar(x)  >= 2}, bigdata_noun)
bigdata_noun <-  gsub("[A-Za-z0-9]", "", bigdata_noun)
bigdata_noun <-  gsub("[~!@#$%^&*()?:+=-_]", "", bigdata_noun)
bigdata_noun <-  gsub("[ㄱ-ㅎ]", "", bigdata_noun)
bigdata_noun <-  gsub("[T|ㅠ]", "", bigdata_noun)
# 테이블 함수로 데이터 세트로 변환 
word_table <-  table(bigdata_noun)
#트위터에서 고령화 키워드로 나온 결과를 워드클라우드로 보여줌 
wordcloud2(word_table, fontFamily = "맑은고딕", size = 5, color = "random-light", backgroundColor = "black")

