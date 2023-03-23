library(dplyr)
library(ggplot2)
library(plotly)
library(crosstalk)

current_path <- getwd()

file_path <- paste(current_path,"/stackOverFlow_dataset.csv", sep = "")

tag_by_year <- read.csv(file_path)

mobile_programming_framework = c('react-native', 'flutter', 'xamarin', 'swift', 'jquery-mobile', 'nativescript', 'extjs')

year_total <- tag_by_year %>% 
                  group_by(Year) %>%
                  summarize(Year_total = sum(Number))

mobile_by_year <- tag_by_year %>%
                      filter(TagName %in% mobile_programming_framework) %>%
                      arrange(desc(Number))

mobile_by_year_total <- mobile_by_year %>%
                      left_join(year_total, by = "Year")


mobile_percentage <- mobile_by_year_total %>%
  mutate(Percentage = Number/Year_total*100)

fig <- ggplot(mobile_percentage, aes(x=Year, y=Percentage, color=TagName)) + 
  geom_line() +
  ggtitle("Growing Trend of Mobile Programming Frameworks") +
  labs(y="Percentage (No. Questions/Total Questions)")

ggplotly(fig)

