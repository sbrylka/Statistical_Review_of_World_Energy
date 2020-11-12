library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
GC <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Gas Consumption - EJ", na = "n/a")
GC <- as.data.frame(GC, stringsAsFactors = False)

#fixing few names
GC[111,1] = 'OECD'
GC[113,1] = 'European Union' 
GC[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(GC[,1])
GC <- GC[GC[,1] %in% List_of_observations,]

#creating function which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
GC <- GC[GC[,1] %!in% Totals,]

#deleting organistions' rows
GC <- GC[GC[,1] %!in% Organizations,]

#adding column's names
colnames(GC) <- GC[1,]

#deleting comments in the last seven rows and the last one
GC <- head(GC, -7)

#deleting few last columns and first row
GC <- GC[2:94,1:56]


#unPivoting columns
GC2 <- gather(GC, key = 'Year', value = 'Gas Consumption - EJ', -'Country' )




