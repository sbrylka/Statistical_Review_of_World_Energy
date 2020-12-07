#left_join allows to combine only two dataframes so I need to join it step by step
Consumption <- left_join(OC2, GC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, CC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, NC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, HC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, WC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, SC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, GBOC2 , by = c("Country", "Year"))

#I want to add colums which represents sum of renewable and nonrenewable energy sources
Consumption <- mutate(
  Consumption,
  nonrenewable = Consumption[,3] + Consumption [,4] + Consumption[,5],
  renewable = Consumption[,7] + Consumption [,8] + Consumption[,9] + Consumption[,10]
)

