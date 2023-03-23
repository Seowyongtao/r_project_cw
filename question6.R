# Load necessary packages
library(dplyr)
library(ggplot2)
library(plotly)

current_path <- getwd()

# IMPORTANT: If not working, manually change the file_path to your laptop's file path
file_path <- paste(current_path,"/stackOverFlow_dataset.csv", sep = "")

# Load in dataset
tag_by_year <- read.csv(file_path)

year_total <- tag_by_year %>% 
  group_by(Year) %>%
  summarize(Year_total = sum(Number))

# Filter dataset to only include bi tools tag
BiTools <- c('powerbi', 'tableau-api')

tag_by_year <- tag_by_year %>%
                  filter(TagName %in% BiTools)

# Add year total column (Total questions asked for the year) to the dataset
tag_by_year_total <- tag_by_year %>%
                      left_join(year_total, by = "Year")

# Add percentage column (No. question for the tag of the year/Total questions of the year) to the dataset 
tag_percentage <- tag_by_year_total %>%
                      mutate(Percentage = Number/Year_total*100)

# Plot the line chart
fig <- ggplot(tag_percentage, aes(x=Year, y=Percentage, color=TagName)) + geom_line() +
        ggtitle("Growing Trend of PowerBi and Tableau") +
        labs(y='Percentage (No. Questions/Total Questions)')

ggplotly(fig)