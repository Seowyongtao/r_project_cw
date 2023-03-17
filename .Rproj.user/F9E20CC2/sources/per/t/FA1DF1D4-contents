library(dplyr)
library(ggplot2)
library(plotly)

tag_by_year <- read.csv('/Users/seowyongtao/Desktop/R_learn/fiv_cw/QueryResults.csv')
                      
Tags <- c('powerbi', 'tableau-api')

bi_tool_2020 <- tag_by_year %>%
  filter(TagName %in% Tags, Year == 2020) %>%
  arrange(TagName)

bi_tool_2020_list <- bi_tool_2020[,"Number"]

bi_tool_2021 <- tag_by_year %>%
  filter(TagName %in% Tags, Year == 2021) %>%
  arrange(TagName)

bi_tool_2021_list <- bi_tool_2021[,"Number"]

bi_tool_2022 <- tag_by_year %>%
  filter(TagName %in% Tags, Year == 2022) %>%
  arrange(TagName)

bi_tool_2022_list <- bi_tool_2022[,"Number"]

data <- data.frame(Tags, bi_tool_2020_list, bi_tool_2021_list, bi_tool_2022_list)

fig <- plot_ly(data, x = ~Tags, y = ~bi_tool_2020_list, type = 'bar', name = '2020')
fig <- fig %>% add_trace(y = ~bi_tool_2021_list, name = '2021')
fig <- fig %>% add_trace(y = ~bi_tool_2022_list, name = '2022')
fig <- fig %>% layout(title = "Comparison between Power Bi and Tableau in the Past 3 Years", yaxis = list(title = 'Number of Questions'), barmode = 'stack')

fig




