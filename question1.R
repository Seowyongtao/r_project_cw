# Load necessary packages
library(dplyr)
library(ggplot2)
library(plotly)

current_path <- getwd()

# IMPORTANT: If not working, manually change the file_path to your laptop's file path
file_path <- paste(current_path,"/stackOverFlow_dataset.csv", sep = "")

# Load in dataset
tag_by_year <- read.csv(file_path)

# Filter dataset to only include data from 2022, and sort by the number of questions per tag
tag_by_year_2022 <- tag_by_year %>%
                      filter(Year == 2022) %>%
                      arrange(desc(Number))

# Select top 5 and top 20 most frequently asked-about tags in 2022
tag_by_year_2022_top5 <- head(tag_by_year_2022, 5) 
tag_by_year_2022_top20 <- head(tag_by_year_2022, 20) 

# Assign a color to each tag based on whether it's in the top 5 or not
tag_by_year_2022_top20 <- tag_by_year_2022_top20 %>%
                            mutate(cond = case_when(
                              TagName %in% tag_by_year_2022_top5[,"TagName"] ~ 'red',
                              TRUE ~ 'grey'   
                            ))

options("scipen"=100, "digits"=4)

# Plot the bar chart 
fig <- ggplot(tag_by_year_2022_top20, aes(x=reorder(TagName, Number), y=Number, fill=cond)) + 
        geom_col() + 
        theme(axis.text.x = element_text(angle = 90)) +  
        scale_fill_identity() + 
        labs(y= "Number of Questions", x = "") + 
        ggtitle("Top 20 Most Asked-About Tags (2022)") + 
        coord_flip()

ggplotly(fig)