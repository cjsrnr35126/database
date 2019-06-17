#install.packages("xlsx")
library(xlsx)

code6=read.xlsx2("C:/Users/korea/Desktop/code6.xlsx",1,startRow = 2,header = T)
head(code6)

db=read.csv("C:/Users/korea/Desktop/db.csv",header = F)
head(db)

db0=`colnames<-`(db,c("Y","M","D","Age","Sex","death1","death2"))
head(db0)

library(DBI)
library(RSQLite)

conn <- dbConnect(SQLite(), dbname = "d:/db-test/disease.sqlite")

dbWriteTable(conn = conn, name = "database", db0, overwrite=T, row.names=FALSE)
data.b=dbReadTable(conn, "database")
#reason of die data
rs <- dbSendQuery(conn,
                  "CREATE TABLE IF NOT EXISTS database 
                  (
                  Y TEXT,
                  M TEXT,
                  D TEXT,
                  Age TEXT PRIMARY KEY, 
                  Sex TEXT , 
                  death1 TEXT PRIMARY KEY, 
                  death2 TEXT PRIMARY KEY 
                  )"
)
dbClearResult(rs)
dbExistsTable(conn, "database")

dbListTables(conn)
dbGetQuery(conn, "SELECT * FROM database")

# code_age table

dbCreateTable(
  conn,
  "code_age",
  c(code = "TEXT", code_n = "TEXT")
)
dbExistsTable(conn, "code_age")

rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'01\',
                  \'1~4\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'02\',
                  \'5~9\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'03\',
                  \'10~14\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'04\',
                  \'15~19\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'05\',
                  \'20~24\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'06\',
                  \'25~29\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'07\',
                  \'30~34\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'08\',
                  \'35~39\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'09\',
                  \'40~44\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'10\',
                  \'45~49\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'11\',
                  \'50~54\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'12\',
                  \'55~59\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'13\',
                  \'60~64\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'14\',
                  \'65~69\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'15\',
                  \'70~74\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'16\',
                  \'75~79\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'17\',
                  \'80~84\')")
dbClearResult(rs)
rs <- dbSendQuery(conn,
                  "INSERT INTO code_age
                  (code, code_n)
                  VALUES
                  (\'18\',
                  \'80~.\')")
dbClearResult(rs)
dbGetQuery(conn, "SELECT * FROM code_age")

#death code

#X1= 질병사인코드, X2= 코드명/ X4= KCD, X5= KCD 코드명/X3는 공백
rcode6=`colnames<-`(code6,c("X1","X2","X3","X4","X5"))

dbWriteTable(conn = conn, name = "code_death", rcode6, overwrite=T, row.names=FALSE)

rs <- dbSendQuery(conn,
                  "CREATE TABLE IF NOT EXISTS code_death 
                  (
                  X1 TEXT,
                  X2 TEXT,
                  X3 TEXT,
                  X4 TEXT, 
                  X5 TEXT 
                  )"
)
dbClearResult(rs)
dbExistsTable(conn, "code_death")

dbListTables(conn)
dbGetQuery(conn, "SELECT * FROM code_death")


#hist
install.packages("descr")
library(descr)

sql = "SELECT death1,death2 dept FROM database"
sd=dbGetQuery(conn, sql)

fr=freq(sd[,1],plot = T)
head(sort(fr[,1],decreasing = T),11)
fr=freq(sd[,2],plot = T)
head(sort(fr[,1],decreasing = T),11)


sql = "SELECT Age dept FROM database"
sd=dbGetQuery(conn, sql)
freq(sd[,1],plot = T)

#generation 30
sql = "SELECT death1,death2 dept FROM database
      WHERE Age=7 OR Age=8"
sd=dbGetQuery(conn, sql)
fr=freq(sd[,1],plot = T)
head(sort(fr[,1],decreasing = T),11)
fr=freq(sd[,2],plot = T)
head(sort(fr[,1],decreasing = T),11)
#generation 40
sql = "SELECT death1,death2 dept FROM database
      WHERE Age=9 OR Age=10"
sd=dbGetQuery(conn, sql)
fr=freq(sd[,1],plot = T)
head(sort(fr[,1],decreasing = T),11)
fr=freq(sd[,2],plot = T)
head(sort(fr[,1],decreasing = T),11)
