library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
GBOC <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Geo Biomass Other - EJ", na = "n/a")
GBOC <- as.data.frame(GBOC, stringsAsFactors = False)

#fixing few names
GBOC[111,1] = 'OECD'
GBOC[113,1] = 'European Union' 
GBOC[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(GBOC[,1])
GBOC <- GBOC[GBOC[,1] %in% List_of_observations,]

#creating fuGBOCtion which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
GBOC <- GBOC[GBOC[,1] %!in% Totals,]

#deleting organistions' rows
GBOC <- GBOC[GBOC[,1] %!in% Organizations,]

#adding column's names
colnames(GBOC) <- GBOC[1,]

#deleting comments in the last seven rows and the last one
GBOC <- head(GBOC, -7)

#deleting few last columns and first row
GBOC <- GBOC[2:94,1:56]


#unPivoting columns
GBOC2 <- gather(GBOC, key = 'Year', value = 'Geothermal, biomass and other Consumption - EJ' , -'Country' )




