library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
CC <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Coal Consumption - EJ", na = "n/a")
CC <- as.data.frame(CC, stringsAsFactors = False)

#fixing few names
CC[111,1] = 'OECD'
CC[113,1] = 'European Union' 
CC[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(CC[,1])
CC <- CC[CC[,1] %in% List_of_observations,]

#creating function which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
CC <- CC[CC[,1] %!in% Totals,]

#deleting organistions' rows
CC <- CC[CC[,1] %!in% Organizations,]

#adding column's names
colnames(CC) <- CC[1,]

#deleting comments in the last seven rows and the last one
CC <- head(CC, -7)

#deleting few last columns and first row
CC <- CC[2:94,1:56]


#unPivoting columns
CC2 <- gather(CC, key = 'Year', value = 'Coal Consumption - EJ"', -'Country' )




