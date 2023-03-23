# Load necessary packages
library(dplyr)
library(ggplot2)
library(plotly)

current_path <- getwd()

# IMPORTANT: If not working, manually change the file_path to your laptop's file path
file_path <- paste(current_path,"/stackOverFlow_dataset.csv", sep = "")

# Load in dataset
tag_by_year <- read.csv(file_path)

# Filter dataset to only include popular mobile programming frameworks 
mobile_programming_framework = c('react-native', 'flutter', 'xamarin', 'swift', 'jquery-mobile', 'nativescript', 'extjs')
mobile_by_year <- tag_by_year %>%
                      filter(TagName %in% mobile_programming_framework) %>%
                      arrange(desc(Number))

# Add year total (total questions for every year) column to the dataset
year_total <- tag_by_year %>% 
  group_by(Year) %>%
  summarize(Year_total = sum(Number))

mobile_by_year_total <- mobile_by_year %>%
                      left_join(year_total, by = "Year")

# Add percentage column (No. question for the tag of the year/Total questions of the year) to the dataset 
mobile_percentage <- mobile_by_year_total %>%
  mutate(Percentage = Number/Year_total*100)

# Plot the line graph
fig <- ggplot(mobile_percentage, aes(x=Year, y=Percentage, color=TagName)) + 
  geom_line() +
  ggtitle("Growing Trend of Mobile Programming Frameworks") +
  labs(y="Percentage (No. Questions/Total Questions)")

ggplotly(fig)

