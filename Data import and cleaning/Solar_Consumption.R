library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
SC <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Solar Consumption - EJ", na = "n/a")
SC <- as.data.frame(SC, stringsAsFactors = False)

#fixing few names
SC[111,1] = 'OECD'
SC[113,1] = 'European Union' 
SC[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(SC[,1])
SC <- SC[SC[,1] %in% List_of_observations,]

#creating fuSCtion which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
SC <- SC[SC[,1] %!in% Totals,]

#deleting organistions' rows
SC <- SC[SC[,1] %!in% Organizations,]

#adding column's names
colnames(SC) <- SC[1,]

#deleting comments in the last seven rows and the last one
SC <- head(SC, -7)

#deleting few last columns and first row
SC <- SC[2:94,1:56]


#unPivoting columns
SC2 <- gather(SC, key = 'Year', value = 'Solar Consumption - EJ' , -'Country' )




