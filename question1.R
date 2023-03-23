library(dplyr)
library(ggplot2)
library(plotly)

current_path <- getwd()

file_path <- paste(current_path,"/stackOverFlow_dataset.csv", sep = "")

tag_by_year <- read.csv(file_path)

tag_by_year_2022 <- tag_by_year %>%
                      filter(Year == 2022) %>%
                      arrange(desc(Number))

tag_by_year_2022_top5 <- head(tag_by_year_2022, 5) 

tag_by_year_2022_top20 <- head(tag_by_year_2022, 20) 

tag_by_year_2022_top20 <- tag_by_year_2022_top20 %>%
                            mutate(cond = case_when(
                              TagName %in% tag_by_year_2022_top5[,"TagName"] ~ 'red',
                              TRUE ~ 'grey'   
                            ))

options("scipen"=100, "digits"=4)

                      
fig <- ggplot(tag_by_year_2022_top20, aes(x=reorder(TagName, Number), y=Number, fill=cond)) + 
        geom_col() + 
        theme(axis.text.x = element_text(angle = 90)) +  
        scale_fill_identity() + 
        labs(y= "Number of Questions", x = "") + 
        ggtitle("Top 20 Most Asked-About Tags (2022)") + 
        coord_flip()

ggplotly(fig)