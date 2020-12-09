library("dplyr")

#setting transparent background
par(bg = '#e6e6e6')     

#preparing dataset
data_2019 <- Consumption %>%
  filter(Year == 2019) %>%
  summarize(
    Renewable = sum(renewable,na.rm = TRUE),
    Nonrenewable = sum(nonrenewable, na.rm = TRUE),
    Nuclear = sum(`Nuclear Consumption - EJ`, na.rm = TRUE)
  )

#creating percent labels
percent <- round(data_2019/sum(data_2019)*100, digits = 2)
percent_labels <- paste(colnames(data_2019), percent, "%", sep =" ")

#creating pie chart
pie(x = as.numeric(data_2019), labels = percent_labels, col = c("#336600","#FF0000", "#FFFF00"),
    main = "Contribution of primary energy sources")

