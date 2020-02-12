install.packages("idbr")
install.packages("tidyverse")
install.packages("extrafont")
install.packages("animation")
install.packages("ggthemes")
devtools::install_github('walkerke/idbr')
library(countrycode)
library(tidyverse)
library(idbr) 
library(ggplot2)
library(animation)
library(dplyr)
library(ggthemes)
library(extrafont)
loadfonts()
countrycode('Korea', 'country.name', 'fips104')
idb_api_key("e850bb017ada9a0f1f49f3d87832f9b6a30ab937")

male <- idb1('KS', 1990:2050, sex = 'male') %>%mutate(SEX = 'Male')

female <- idb1('KS', 1990:2050, sex = 'female') %>%mutate(POP = POP * -1,SEX = 'Female')

korea <- bind_rows(male, female) %>%
  mutate(abs_pop = abs(POP))

korea <- korea %>% mutate(SEX = ifelse(SEX == "Male", "남자", "여자"))

