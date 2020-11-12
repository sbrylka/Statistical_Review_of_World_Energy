library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
NC <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Nuclear Consumption - EJ", na = "n/a")
NC <- as.data.frame(NC, stringsAsFactors = False)

#fixing few names
NC[111,1] = 'OECD'
NC[113,1] = 'European Union' 
NC[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(NC[,1])
NC <- NC[NC[,1] %in% List_of_observations,]

#creating function which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
NC <- NC[NC[,1] %!in% Totals,]

#deleting organistions' rows
NC <- NC[NC[,1] %!in% Organizations,]

#adding column's names
colnames(NC) <- NC[1,]

#deleting comments in the last seven rows and the last one
NC <- head(NC, -7)

#deleting few last columns and first row
NC <- NC[2:94,1:56]


#unPivoting columns
NC2 <- gather(NC, key = 'Year', value = 'Nuclear Consumption - EJ' , -'Country' )




