## 통계 데이터 베이스 과제

### ① 데이터 및 데이터베이스 구조 설명 (데이터, 테이블 등)
통계청 MDIS를 이용하여 2013년 사망원인통계자료를 습득하였다. 데이터의 갯수는 약 2만6천여개이며 따라붙는 자료로는 질병사인분류코드(약 16000개)와 나이,성별 분류코드(18개)가 있다. 이를 각각 사망원인 통계, 질병사인분류 , 나이분류 테이블로 만들었다.<br>

![캡처](https://user-images.githubusercontent.com/49007889/59583206-8e584100-9115-11e9-8383-7bd4f751d1b9.PNG)

---------------------


### ② 데이터 처리 과정 설명 (데이터 import/export 과정, SQL 문장 등)

통계청에서 다운받은 파일이 엑셀이였으므로 xlxs패키지를 사용하여 엑셀파일을 읽은 다음, 사망원인통계와 질병사인분류코드를 dbWriteTable함수를 이용하여 테이블로 만들었다. <br>
<pre><code>
#install.packages("xlsx")
library(xlsx)

code6=read.xlsx2("C:/Users/korea/Desktop/code6.xlsx",1,startRow = 2,header = T)
head(code6)

db=read.csv("C:/Users/korea/Desktop/db.csv",header = F)
head(db)

db0=`colnames<-`(db,c("Y","M","D","Age","Sex","death1","death2"))
head(db0)
</code></pre>

<pre><code>
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
</code></pre>
나이분류코드의 경우에는 그 수가 많지않아 dbCreateTable함수로 새로운 테이블을 만들고 데이터를 입력시켰다.
<pre><code>
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
</code></pre>
----------------------

### ③ 데이터 요약 (요약 통계량, 표/그래프 활용)
사망원인 통계에서 가장 많은 빈도를 차지하는 사망원인은 무엇일까?

![Rplot](https://user-images.githubusercontent.com/49007889/59585346-3a505b00-911b-11e9-80ba-334eda3291ba.png)

-----------------

|C34  | R54  | C22 | J18 | I21 | I69 | C16 | T71 | I63 | E11 |
|-----|:----:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|1760 | 1460 | 1118| 964 | 943 | 896 | 875 | 788 | 711 | 693 |

사망원인빈도 상위 10개를 추출해보았다. 가장 많은 빈도를 차지하는 사인은 C34이다. 이 코드는 주기관지의 악성신생물에 의한 사망을 의미한다. 여기서 악성신생물이란 암을 의미한다.<br>
뒤를 이은 R54는 노쇠, C22는 간세포암종 이였다. (J18: 상세불명의 기관지폐렴, I21: 심근경색, I69: 지주막하 출혈, C16: 위암, T71: 질식, I63: 뇌경색증, E11: 혼수를 동반한 인슐린-비의존 당뇨병 )
<br>
다음 표는 사망 특이사항이다.
|NULL | X70  | X59 | X67 | Y34 | V03 | X68 | W19 | X71 |
|-----|:----:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|23699| 757  | 186 | 184 | 171 | 167 | 152 | 86  | 49  |

그렇다면 사망 연령대의 분포는 어떨까?<br>

![캡1처](https://user-images.githubusercontent.com/49007889/59586853-cfa11e80-911e-11e9-9b5c-cfdcb30bf169.PNG)

![Rplot01](https://user-images.githubusercontent.com/49007889/59586856-d2037880-911e-11e9-86fc-bd9f8a7fef90.png)

0은 태어나기전이나 태어난 후 100일이 채 안되어 사망한경우를 뜻한다. 이어 1은 1~4세 영유아기, 2는 5~9세이다. 10대는 3,4; 20대는 5,6; 30대는 7,8에 해당하며 마지막 18은 80세이상을 의미한다. 나이와 사망에는 양의 상관이 존재하는 것으로 보인다.

-----------------------

### ④ 데이터 분석 (데이터 분석 기법 활용)


### ⑤ 결론
주로 볼 수 있는 보험 광고를 생각해 보더라도 나이가 들어 죽음에 이르는 과정이 아닌, 비교적 젊은 나이에 사망에 이르는 주요 원인은 암,뇌출혈,심근경색 이라는 결론을 내릴 수 있다. 
