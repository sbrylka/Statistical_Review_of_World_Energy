library("ggplot2")
library("dplyr")
library("tidyr")

#setting background as transparent
par(bg = '')     

#preparing data for first chart
area_chart_data <- Consumption  %>%
  group_by(Year) %>%
  summarise(
    Renewable = sum(renewable,na.rm = TRUE),
    Nonrenewable = sum(nonrenewable, na.rm = TRUE),
    Nuclear = sum(`Nuclear Consumption - EJ`, na.rm = TRUE)
  )

#changing form data
area_chart_data.long = gather(data = area_chart_data, 
                 key = "Source", 
                 value = "nazwa",
                 -Year)

#Area chart
ggplot(area_chart_data.long, aes(x=Year, y= as.numeric(nazwa), fill = Source, group = Source)) + 
  geom_area() +
  scale_x_discrete(breaks=seq(1965,2019,2)) +
  scale_y_continuous(breaks=seq(0,650,50)) +
  ggtitle("Usage of primary energy sources by group in 1965-2019") +
  labs(x="Year", y="Exajoules") +
  theme(plot.background = element_rect(fill = "#e6e6e6")) #ggplot requires different way of changing bakcground



#preparing data for second chart
area_chart_data2 <- area_chart_data %>%
  summarise(
    Renewable = Renewable/suma,
    Nonrenewable = Nonrenewable/suma,
    Nuclear = Nuclear/suma
    ) %>%
  mutate(Year = area_chart_data$Year)

#changing form data
area_chart_data.long2 = gather(data = data2, 
                 key = "Source", 
                 value = "nazwa",
                 -Year)

#Area chart 2
ggplot(data = area_chart_data.long2, aes(x=Year, y= nazwa, fill=Source, group = Source)) + 
  geom_area(size=0.8, colour="black") +
  scale_x_discrete(breaks=seq(1965,2019,2)) +
  scale_y_continuous(breaks=seq(0,1,0.1)) +
  ggtitle("Contribution of primary energy sources by group in 1965-2019") +
  labs(x="Year", y="Percentage") +
  theme(plot.background = element_rect(fill = "#e6e6e6")) #ggplot requires different way of changing bakcground

