library(readxl)
library(dplyr)
library(tidyr)

#reading BP data
HC <- read_excel("bp-stats-review-2020-all-data.xlsx", sheet = "Hydro Consumption - EJ", na = "n/a")
HC <- as.data.frame(HC, stringsAsFactors = False)

#fixing few names
HC[111,1] = 'OECD'
HC[113,1] = 'European Union' 
HC[2,1] = 'Country' #changing JEDNOSTKA to Country will help us later

#first variable without NAs
List_of_observations <- na.exclude(HC[,1])
HC <- HC[HC[,1] %in% List_of_observations,]

#creating fuHCtion which negates %in%
'%!in%' = Negate('%in%')

#creating two variables to contain names of Organisations and Totals
Totals <- c("Total North America","Total S. & Cent. America", "Total Asia Pacific", "Total Europe", "Total CIS", "Total Africa", "Total World")
Organizations <- c("of which: OECD" = "OECD", "Non-OECD", "European Union")

#deleting totals' rows
HC <- HC[HC[,1] %!in% Totals,]

#deleting organistions' rows
HC <- HC[HC[,1] %!in% Organizations,]

#adding column's names
colnames(HC) <- HC[1,]

#deleting comments in the last seven rows and the last one
HC <- head(HC, -7)

#deleting few last columns and first row
HC <- HC[2:94,1:56]


#unPivoting columns
HC2 <- gather(HC, key = 'Year', value = 'Hydroelectricity Consumption - EJ' , -'Country' )




