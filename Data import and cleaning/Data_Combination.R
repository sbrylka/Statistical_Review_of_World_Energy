#left_join allows to combine only two dataframes so I need to join it step by step
Consumption <- left_join(OC2, GC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, CC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, NC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, HC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, WC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, SC2 , by = c("Country", "Year"))
Consumption <- left_join(Consumption, GBOC2 , by = c("Country", "Year"))
