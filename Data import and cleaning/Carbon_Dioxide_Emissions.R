library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
CDE <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Carbon Dioxide Emissions", na = "n/a")
CDE <- as.data.frame(CDE, stringsAsFactors = False)

#fixing few names
CDE[111,1] = 'OECD'
CDE[113,1] = 'European Union' 
CDE[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(CDE[,1])
CDE <- CDE[CDE[,1] %in% List_of_observations,]

#creating function which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
CDE <- CDE[CDE[,1] %!in% Totals,]

#deleting organistions' rows
CDE <- CDE[CDE[,1] %!in% Organizations,]

#adding column's names
colnames(CDE) <- CDE[1,]

#deleting comments in the last seven rows and the last one
CDE <- head(CDE, -7)

#deleting few last columns and first row
CDE <- CDE[2:94,1:56]


#unPivoting columns
CDE2 <- gather(CDE, key = 'Year', value = 'Million tonnes of carbon dioxide', -'Country' )





