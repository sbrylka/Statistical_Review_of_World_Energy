library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
OC <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Oil Consumption - EJ", na = "n/a")
OC <- as.data.frame(OC, stringsAsFactors = False)

#fixing few names
OC[111,1] = 'OECD'
OC[113,1] = 'European Union' 
OC[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(OC[,1])
OC <- OC[OC[,1] %in% List_of_observations,]

#creating fuOCtion which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
OC <- OC[OC[,1] %!in% Totals,]

#deleting organistions' rows
OC <- OC[OC[,1] %!in% Organizations,]

#adding column's names
colnames(OC) <- OC[1,]

#deleting comments in the last seven rows and the last one
OC <- head(OC, -7)

#deleting few last columns and first row
OC <- OC[2:94,1:56]


#unPivoting columns
OC2 <- gather(OC, key = 'Year', value = 'Oil Consumption - EJ' , -'Country' )




