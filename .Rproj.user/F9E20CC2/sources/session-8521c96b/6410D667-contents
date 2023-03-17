# shared data object
shared_us <- SharedData$new(mobile_percentage, key = ~TagName)

# scatterplot of housing price index against homeownership
p17 <- shared_us %>%
  plot_ly(x = ~Year, y = ~Percentage, color = ~TagName, type='scatter', mode='line') 

# add a column of checkboxes for region to the left of the plot
bscols(widths = c(7, NA),
       filter_checkbox(id = "region", label = "Tag", sharedData = shared_us, group = ~TagName),
       p17
)