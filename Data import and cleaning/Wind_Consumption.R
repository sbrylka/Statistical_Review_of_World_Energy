library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
WC <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Wind Consumption - EJ", na = "n/a")
WC <- as.data.frame(WC, stringsAsFactors = False)

#fixing few names
WC[111,1] = 'OECD'
WC[113,1] = 'European Union' 
WC[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(WC[,1])
WC <- WC[WC[,1] %in% List_of_observations,]

#creating fuWCtion which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
WC <- WC[WC[,1] %!in% Totals,]

#deleting organistions' rows
WC <- WC[WC[,1] %!in% Organizations,]

#adding column's names
colnames(WC) <- WC[1,]

#deleting comments in the last seven rows and the last one
WC <- head(WC, -7)

#deleting few last columns and first row
WC <- WC[2:94,1:56]


#unPivoting columns
WC2 <- gather(WC, key = 'Year', value = 'Wind Consumption - EJ' , -'Country' )




