# install.package(RODBC)
# install.packages('readr', dependencies = TRUE)
library(readr)
library(RODBC)

## set the database path
DbPath <- "C:/Users/fabbrid/Documents/MyDB.accdb" ##Set MS Access file's path

## connect to the database
conn <- odbcConnectAccess2007(DbPath,rows_at_time = 1) #create and open a connection to the DB

sqlTables(conn) #Get list of database tables

My_table <- sqlFetch(conn,
                     "name_table_you_want", #set name of the table you want to save
                      as.is = T)    #read your database table an save it

close(conn)# close the connection

colnames(My_table) 

write.csv(My_table,
          "My_table.csv",#Set file's name
          row.names = FALSE)# save your data as csv for further analysis

#Get Table details
for (j in 1:ncol(My_table)) {
  print(paste("--- ",
              colnames(My_table)[j],
              "has",
              length(unique(My_table[,j])),
              "distinct values"))
}

############################