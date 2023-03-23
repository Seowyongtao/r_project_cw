library(dplyr)
library(ggplot2)
library(plotly)

current_path <- getwd()

file_path <- paste(current_path,"/stackOverFlow_dataset.csv", sep = "")

tag_by_year <- read.csv(file_path)

BiTools <- c('powerbi', 'tableau-api')

year_total <- tag_by_year %>% 
  group_by(Year) %>%
  summarize(Year_total = sum(Number))

tag_by_year <- tag_by_year %>%
                  filter(TagName %in% BiTools)

tag_by_year_total <- tag_by_year %>%
                      left_join(year_total, by = "Year")

tag_percentage <- tag_by_year_total %>%
                      mutate(Percentage = Number/Year_total*100)


fig <- ggplot(tag_percentage, aes(x=Year, y=Percentage, color=TagName)) + geom_line() +
        ggtitle("Growing Trend of PowerBi and Tableau") +
        labs(y='Percentage (No. Questions/Total Questions)')

ggplotly(fig)