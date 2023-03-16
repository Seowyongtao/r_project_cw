library(dplyr)
library(ggplot2)
update.packages("ggplot2")
library(plotly)
library(gapminder)

tag_by_year <- read.csv('/Users/seowyongtao/Desktop/R_learn/fiv_cw/QueryResults.csv')

head(tag_by_year)

year_total <- tag_by_year %>% 
  group_by(Year) %>%
  summarize(year_total = sum(Number))

head(year_total)

tag_by_year_total <- tag_by_year %>%
  left_join(year_total, by = "Year")

head(tag_by_year_total)

options("scipen"=100, "digits"=4)

tag_percentage_by_year <- tag_by_year_total %>%
  mutate(percentage = Number/year_total*100)

head(tag_percentage_by_year)

r_by_year <- tag_percentage_by_year %>%
  filter(TagName == 'r')

fig <- r_by_year %>%
  plot_ly(
    x = ~Year, 
    y = ~percentage, 
    frame = ~Year, 
    type = 'scatter',
    mode = 'line'
  )


fig