library(dplyr)
library(ggplot2)
library(plotly)

current_path <- getwd()

file_path <- paste(current_path,"/stackOverFlow_dataset.csv", sep = "")

tag_by_year <- read.csv(file_path)

mobile_programming_framework = c('react-native', 'flutter', 'xamarin', 'swift', 'jquery-mobile', 'nativescript', 'extjs')

mobile_by_year <- tag_by_year %>%
                    filter(TagName %in% mobile_programming_framework, Year == 2022) %>%
                    arrange(desc(Number))


top <- head(mobile_by_year,1)

mobile_by_year <- mobile_by_year %>%
  mutate(cond = case_when(
    TagName %in% top[,"TagName"] ~ 'red',
    TRUE ~ 'grey'   
  ))

fig <- ggplot(mobile_by_year , aes(x=reorder(TagName, Number), y=Number, fill=cond)) + 
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90)) +  
  scale_fill_identity() + 
  labs(y= "Number of Questions", x = "") + 
  ggtitle("Popular Mobile Programming Frameworks") + 
  coord_flip()

ggplotly(fig)



