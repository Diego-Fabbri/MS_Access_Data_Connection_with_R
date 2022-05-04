# install.package(RODBC)
# install.packages('readr', dependencies = TRUE)
library(readr)
library(RODBC)

## set the database path
DbPath <- "C:/Users/fabbrid/Documents/MyDB.accdb" ##Set MS Access file's path

## connect to the database
conn <- odbcConnectAccess2007(DbPath,rows_at_time = 1) #create and open a connection to the DB

sqlTables(conn) #Get list of database tables

table_name <- sqlFetch(conn,
                       "table_name", #set name of the table you want to save
                       as.is = T)# read your database table an save it

close(conn)# close the connection

colnames(table_name) 

write.csv(table_name,
          "table_name.csv",
          row.names = FALSE)# save your data as csv for further analysis
############################