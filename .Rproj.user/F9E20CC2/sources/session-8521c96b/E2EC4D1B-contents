library(dplyr)
library(ggplot2)

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

head(r_by_year)

ggplot(r_by_year, aes(x=Year, y=percentage)) + geom_line()
