# SOURCE: https://statisticsglobe.com/create-connect-database-r

# install.packages("odbc")
# install.packages("DBI")
# install.packages("tidyverse")

library(odbc) #Contains drivers to connect to a database
library(DBI) #Contains functions for interacting with the database
library(tidyverse)


#Load the sample data
data("population")
data("who")

#Create database
con <- dbConnect(drv = RSQLite::SQLite(),
                 dbname = ":memory:") #Create an empty Database

dbListTables(con)

#store sample data in database
dbWriteTable(conn = con, 
             name = "population",
             value = population)
dbWriteTable(conn = con, 
             name = "who",
             value = who)

dbListTables(con) #Get tables from database
#remove the local data from the environment
rm(who, population)

## Querying Your Database
res <- DBI::dbGetQuery(conn = con,
                       statement = "
                        SELECT who.country, who.year, who.new_sp_m014, population.population 
                        FROM   population, who 
                        WHERE  who.country = 'Afghanistan' AND 
                               who.year > 1995 AND 
                               who.country = population.country AND 
                               who.year = population.year
                ")
