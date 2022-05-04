# install.package(RODBC)
# install.packages('readr', dependencies = TRUE)
library(readr)
library(RODBC)
library(usefun)

## set the database path
DbPath <- "C:/Users/fabbrid/Documents/CaseStudy_Palmera.accdb" ##Set MS Access file's path

## connect to the database
conn <- odbcConnectAccess2007(DbPath,rows_at_time = 1) 

#Get list of database tables
sqlTables(conn, tableType = "TABLE") 

# save Database Tables
Tables_List <- sqlTables(conn, tableType = "TABLE") 
Tables_List

Tables_List <- as.data.frame(Tables_List[,"TABLE_NAME"])
Tables_List

## Export tables as csv file
for (i in 1:nrow(Tables_List)) {
  
  # read your database table and save it
  table_tmp <- sqlFetch(conn,
                        Tables_List[i,], #set name of the table you want to save
                        as.is = T)
  
## Export your table as .csv 
  write.csv(table_tmp,
            # sep = " ",
            file = paste(Tables_List[i,],".csv"),
            row.names=FALSE)
  
#Export table as .txt file
write.table(table_tmp, 
            file = paste(Tables_List[i,],".txt"),
            append = FALSE, 
            #sep = "",
            #dec = ".",
            quote = FALSE,
            row.names = FALSE,
            col.names = TRUE)

}


############################



#######TABLES RECAP#########

#Export Tables' details on a .txt file
sink("./Tables Recap.txt",append = FALSE)

for (i in 1:nrow(Tables_List)) {
  
table_tmp <- sqlFetch(conn,
                      Tables_List[i,], #set name of the table you want to save
                      as.is = T)

print(paste("--------> Table",Tables_List[i,],
            "has",nrow(table_tmp),"rows",
             "and",ncol(table_tmp),"columns"))

  for (j in 1:ncol(table_tmp)) {
    print(paste("--- ",
                colnames(table_tmp)[j],
                "has",
                length(unique(table_tmp[,j])),
                "distinct values"))
  }

print_empty_line(html.output = FALSE)


}

sink()
close(conn)# close the connection