library(dplyr)
library(ggplot2)
library(plotly)

tag_by_year <- read.csv("C:/Users/Acer Spin 5/Desktop/R_projects/r_project_cw/QueryResults.csv")

year_total <- tag_by_year %>% 
                  group_by(Year) %>%
                  summarize(Year_total = sum(Number))

r_by_year <- tag_by_year %>%
                filter(TagName == 'r')

r_by_year_total <- r_by_year %>%
                      left_join(year_total, by = "Year")

r_percentage <- r_by_year_total %>%
                    mutate(Percentage = Number/Year_total*100)

fig <- ggplot(r_percentage , aes(x=Year, y=Percentage)) + 
  geom_line(color='red') +
  geom_point(color= 'red') +
  ggtitle("Growing Trend of R") +
  labs(y= "Percentage (No. Questions/Total Questions)")
  
ggplotly(fig)