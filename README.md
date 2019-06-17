## 통계 데이터 베이스 과제

### ① 데이터 및 데이터베이스 구조 설명 (데이터, 테이블 등)
통계청 MDIS를 이용하여 사망원인 통계자료를 습득하였다. 데이터의 갯수는 약 2만6천여개이며 따라붙는 자료로는 질병사인분류코드(약 16000개)와 나이,성별 분류코드(18개)가 있다. 이를 각각 사망원인 통계, 질병사인분류 , 나이분류 테이블로 만들었다.<br>

![캡처](https://user-images.githubusercontent.com/49007889/59583206-8e584100-9115-11e9-8383-7bd4f751d1b9.PNG)

---------------------


### ② 데이터 처리 과정 설명 (데이터 import/export 과정, SQL 문장 등)

통계청에서 데이터를 가져온 다음, 사망원인통계와 질병사인분류코드를 dbWriteTable함수를 이용하여 테이블로 만들었다. <br>

#death code
#X1= 질병사인코드, X2= 코드명/ X4= KCD, X5= KCD 코드명/X3는 공백
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

나이분류코드의 경우에는 그 수가 많지않아 dbCreateTable함수로 새로운 테이블을 만들고 데이터를 입력시켰다.
#code_age table

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


③ 데이터 요약 (요약 통계량, 표/그래프 활용)
④ 데이터 분석 (데이터 분석 기법 활용)
⑤ 결론
