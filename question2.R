library(dplyr)
library(ggplot2)
library(plotly)

tag_by_year <- read.csv("C:/Users/Acer Spin 5/Desktop/R_projects/r_project_cw/QueryResults.csv")


tag_by_year_2022 <- tag_by_year %>%
                        filter(Year == 2022) %>%
                        arrange(desc(Number))

tag_by_year_2022_top5 <- head(tag_by_year_2022, 5) 

tag_by_year_2022_top20 <- head(tag_by_year_2022, 20) 

tag_by_year_filtered_top20 <- tag_by_year %>%
                                  filter(TagName %in% tag_by_year_2022_top20[,"TagName"]) %>%
                                  arrange(Year, Number)

tag_by_year_filtered_top20 <- tag_by_year_filtered_top20 %>%
  mutate(cond = case_when(
    TagName %in% tag_by_year_2022_top5[,"TagName"] ~ TRUE,
    TRUE ~ FALSE   
  ))
                                  

fig <- tag_by_year_filtered_top20 %>%
  plot_ly(
    y = ~TagName, 
    x = ~Number, 
    color = ~cond,
    colors = c('grey','red'),
    frame = ~Year, 
    type = 'bar',
    orientation = 'h'
  )%>% 
  layout(yaxis = list(categoryorder = "total ascending", title = ''), 
         xaxis = list(title = 'Number of Questions'))

fig