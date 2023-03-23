# Load necessary packages
library(dplyr)
library(ggplot2)
library(plotly)

current_path <- getwd()

# IMPORTANT: If not working, manually change the file_path to your laptop's file path
file_path <- paste(current_path,"/stackOverFlow_dataset.csv", sep = "")

# Load in dataset
tag_by_year <- read.csv(file_path)
                      
Tags <- c('powerbi', 'tableau-api')

# Filter dataset to include only data for the selected tags in 2020, and sort by tag nam
bi_tool_2020 <- tag_by_year %>%
  filter(TagName %in% Tags, Year == 2020) %>%
  arrange(TagName)

# Extract number of questions per tag for 2020
bi_tool_2020_list <- bi_tool_2020[,"Number"]

# Filter dataset to include only data for the selected tags in 2021, and sort by tag nam
bi_tool_2021 <- tag_by_year %>%
  filter(TagName %in% Tags, Year == 2021) %>%
  arrange(TagName)

# Extract number of questions per tag for 2021
bi_tool_2021_list <- bi_tool_2021[,"Number"]

# Filter dataset to include only data for the selected tags in 2022, and sort by tag nam
bi_tool_2022 <- tag_by_year %>%
  filter(TagName %in% Tags, Year == 2022) %>%
  arrange(TagName)

# Extract number of questions per tag for 2022
bi_tool_2022_list <- bi_tool_2022[,"Number"]

# Combine data into a single data frame
data <- data.frame(Tags, bi_tool_2020_list, bi_tool_2021_list, bi_tool_2022_list)

# Plot the stacked bar chart
fig <- plot_ly(data, x = ~Tags, y = ~bi_tool_2020_list, type = 'bar', name = '2020')
fig <- fig %>% add_trace(y = ~bi_tool_2021_list, name = '2021')
fig <- fig %>% add_trace(y = ~bi_tool_2022_list, name = '2022')
fig <- fig %>% layout(title = "Comparison between Power Bi and Tableau in the Past 3 Years", yaxis = list(title = 'Number of Questions'), barmode = 'stack')

fig




