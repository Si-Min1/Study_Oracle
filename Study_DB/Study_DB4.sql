-- 평균내기
-- 상품테이블의 상품 분류별 매입가격 평균
-- ROUND 소수점 제거
-- 알반 컬럼과 그룹함수를 사용할 경우 GROUP BY를 사용해야 한다, 반대도 그러하다(안넣으면 뭔지 모름).

-- 상품 테이블의 상품 분류별 판매가격 평균값 구하기
SELECT prod_lgu, ROUND(AVG(prod_sale), 2) FROM prod
    GROUP BY prod_lgu;

-- 상품테이블의 판매가격 평균 값을 구하시오.
SELECT ROUND(AVG(prod_sale), 2) FROM prod;

-- COUNT
-- 장바구니 테이블에서 회원별 COUNT 집계
-- 컬럼은 회원ID 자료수(DISTINCT), 자료수, 자료수(*)
SELECT cart_member, COUNT(DISTINCT(cart_member)), COUNT(cart_member), COUNT(*) FROM cart
    GROUP BY cart_member;

/*
[문제]
구매수량의 전체 평균 이상을 구매한 회원들의 아이디와 이름을 조회
*/
SELECT mem_id, mem_name FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_qty >= (SELECT AVG(cart_qty) FROM cart)
    );


SELECT mem_id, mem_name FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_qty >= (
                SELECT cart_member, AVG(cart_qty) FROM cart 
                    GROUP BY cart_mem
                        HAVING AVG(cart_qty) > (SELECT AVG(cart_qty) FROM cart )
                )
        );

-- 이게 평균이지
SELECT cart_member, AVG(cart_qty) FROM cart 
                    GROUP BY cart_member
                        HAVING AVG(cart_qty) > (SELECT AVG(cart_qty) FROM cart );


SELECT DISTINCT(c.cart_member), m.mem_name FROM cart c, member m
    WHERE c.cart_member = m.mem_id AND c.cart_qty > (SELECT AVG(cart_qty) FROM cart);


/*
1.  SELECT
1_1. 컬럼들
2. FROM
3.  WHERE
4.  (AND,OR)
5.  GROUP
6.  HAVING
7.  ORDER

1 - 2 - 3 - 5 - 6 - 1_1 - 7 순으로 메모리 상으로 올라감
*/
SELECT COUNT(*) FROM prod;

/*
[문제]
구매내역(장바구니) 목록에서 회원 아이디 별로 주문(수량)에 대한 평균을 조회하시오
단 회원 아이디를 기준으로 내림차순으로 조회하시오
*/
SELECT cart_member, ROUND(AVG(cart_qty), 2) as qty
    FROM cart 
        GROUP BY cart_member
            ORDER BY cart_member DESC;

/*
[문제]
상품정보에서 판매가격의 평균값을 조회하시오
단, 평균값은 소수점 2번째 자리까지 표현하시오
*/
SELECT ROUND(AVG(prod_sale),2) FROM prod;

/*
[문제]
상품정보에서 상품분류별 판매가격의 평균값을 구해주세요.
조회 컬럼은 상품분류코드, 상품분류별 판매가격의 평균
단, 평균값은 소수점 2자리까지만 표현
*/
SELECT prod_lgu, ROUND(AVG(prod_sale),2) FROM prod
    GROUP BY prod_lgu;

-- 회원 테이블의 취미별로 COUNT집계하시오
SELECT mem_like, COUNT(mem_like), COUNT(*) FROM member
    GROUP BY mem_like;

-- 회원 테이블의 직업 종류수를 COUNT 집계하시오
SELECT COUNT(DISTINCT mem_job) as 직업종류수 FROM member;

/*
회원 전체의 마일리지 평균보다 큰 회원에 대한
아이디, 이름, 마일리지를 조회하시오.
단, 정렬은 마일리지가 높은순(내림차순)
*/
SELECT mem_id, mem_name, mem_mileage FROM member
    WHERE mem_mileage > (
        SELECT AVG(mem_mileage) FROM member
    )
        ORDER BY mem_mileage DESC;

-- 최대 최소 MAX, MIN

-- 오늘이 2005년도 7월 11일이라 가정하고 장바구니에 발생될 추가주문번호를 검색하시오
SELECT TO_CHAR(SYSDATE, 'yyyymmdd'), MAX(cart_no) as "검색 기록중 마지막 주문", MAX(cart_no)+1 as "추가될 주문 번호" FROM cart
    WHERE cart_no LIKE '20050711%';

/*
[문제]
구매정보 내역에서 년도 별로 판매된 상품의 갯수,
평균 구매수량을 조회하려고한다.
정렬은 년도별로 내림차순한다.
*/
SELECT SUBSTR(cart_no,1,4) as asdf, SUM(cart_qty), AVG(cart_qty) FROM cart
    GROUP BY SUBSTR(cart_no,1,4)
        ORDER BY asdf desc;

/*
[문제]
구매정보에서 년도별, 상품분류 코드별 상품의 갯수를 조회하려고 한다(COUNT)
정렬은 년도를 기준으로 내림차순 하시오
*/
SELECT SUBSTR(cart_no,1,4) as yyyy, SUBSTR(cart_prod,1,4) as "상품 코드", COUNT(cart_qty) as "수량" FROM cart
    GROUP BY  SUBSTR(cart_prod,1,4), SUBSTR(cart_no,1,4)
        ORDER BY yyyy DESC;

/*
회원테이블의 회원전체의 마일리지 평균, 마일리지 합계, 최고마일리지, 최소마일리지, 인원수 검색
*/
SELECT ROUND(AVG(mem_mileage),2) asd1, SUM(mem_mileage) asd2, MAX(mem_mileage) asd3, MIN(mem_mileage) asd4, COUNT(mem_id) asd5
    FROM member;

/*
상품테이블에서 상품분류별 판매가 전체의 평균, 합꼐 최고저 값, 자료수를 검색하시오
*/
SELECT prod_lgu, ROUND(AVG(prod_sale),2) asd1, SUM(prod_sale) asd2, MAX(prod_sale) asd3, MIN(prod_sale) asd4, COUNT(prod_sale) asd5
    FROM prod
        GROUP BY prod_lgu
            HAVING COUNT(prod_sale) > 20;

/*
회원 테이블에서 지역(주소1의 2자리), 생일년도별로 마일리지 평균, 마일리지 합계, 최고저 마일리지, 자료수 검색
*/
SELECT SUBSTR(mem_add1,1,2) as "지역" , TO_CHAR(mem_bir, 'yyyy') as "년도", 
          ROUND(AVG(mem_mileage),2) asd1, SUM(mem_mileage) asd2, 
          MAX(mem_mileage) asd3, MIN(mem_mileage) asd4, COUNT(mem_id) asd5
    FROM member
        GROUP BY SUBSTR(mem_add1,1,2), TO_CHAR(mem_bir, 'yyyy');

-- 예제용 NULL 데이터 생성 COMMIT ㄴㄴ --
UPDATE buyer SET buyer_charger = NULL
    WHERE buyer_charger LIKE '김%';
UPDATE buyer SET buyer_charger = ''
    WHERE buyer_charger LIKE '성%';
--------------------------------------------------
SELECT buyer_charger FROM buyer; -- (null) 로 나옴
    
-- NULL을 이용한 NULL값 비교
SELECT buyer_name 거래처, buyer_charger 담당자 FROM buyer
    WHERE buyer_charger = NULL; -- 안나옴
SELECT buyer_name 거래처, buyer_charger 담당자 FROM buyer
    WHERE buyer_charger IS NULL;

-- NULL값인 경운 없다로 치환
SELECT buyer_name 거래처, NVL(buyer_charger, '없음') 담당자 FROM buyer;
SELECT buyer_name 거래처, NVL2(buyer_charger, '있음', '없음') 담당자 FROM buyer;

SELECT 10 * NULL FROM dual;
SELECT 10 * NVL(NULL,0) FROM dual;

/*
회원 마일리지에 100을 더한 수치 검색 (NVL 사용)
컬럼 성명 마일리지 변경 마일리지
*/
SELECT mem_name, mem_mileage, NVL(mem_mileage, 0) + 100 FROM member;

/*
회원 마일리지가 있으면 '정상 회원' 없으면 '비정상 회원'으로 출력
컬럼 성명 마일리지 회원 상태
*/
SELECT mem_name, mem_mileage, NVL2(mem_mileage, '정상회원', '비정상 회원') as asdf FROM member;

-- DECODE
/*
아래의 DECODE 해석
n = 8
if(n == 10){
    cout >> 'A';
} else
if(n == 9){
    cout >> 'B';
} else
if(n == 9){
    cout >> 'C';
} 
else{
    cout >> 'D';
}
*/
SELECT DECODE(8, 10, 'A', 9, 'B', 8, 'C', 'D') FROM dual;

SELECT DECODE(SUBSTR(prod_lgu,1,2),
                    'P1', '컴퓨터/전자 제품',
                    'P2', '의류',
                    'P3', '잡화', '기타')
    FROM prod;

/*
상품 분류중 앞의 두글자가 'P1'이면 판매가를 10% 인상하고 'P2'이면 15%인상하고 나머지는 냅둬라
컬럼 상품명 판매가 변경 판매가
*/
SELECT prod_name, prod_sale,
          DECODE(SUBSTR(prod_lgu,1,2), 'P1', prod_sale*1.1, 'P2', prod_sale*1.15, prod_sale) as asdf
    FROM prod;

-- CASE WHEN
/*
cin << n;
switch(n){
    case 값1 : 
        실행문; 
        break;  
    default :
        실행문;    
}
CASE 컬럼  
WHEN 조건1 THEN 값1 
WHEN 조건2 THEN 값2 
ELSE 값3 
END 

회원정보 테이블의 주민들록번호 뒷자리를 써서 성별 구분하기
컬럼은 회원명 주민등록번호(주민1 - 주민2), 성별
*/
SELECT SUBSTR(mem_regno2,1,1) FROM member;
SELECT mem_name, mem_regno1 || '-' || mem_regno2 as 주민번호, 
          CASE 
          WHEN SUBSTR(mem_regno2,1,1) = 1 THEN '남자'
          ELSE '여자' END as "성별"
    FROM member;

/*
-입고 정보-6월달 이전(5월달까지)에 입고된 상품중에 -상품정보-배달특기사항이 '세탁 주의'이면서 색상이 null값인
-구매정보-제품들의 판매량의 평균보다 많이 팔린걸 구매한 -회원정보-김씨를 가진 손님의 이름과 보유 마일리지를 1000을 더하여 구하고 성별을 출력하시오
컬럼 회원 이름, 회운 마일리지, 회원 성별
*/
-- 2005년 6월 이전(5월달까지)에 입고된 상품중에 
-- 배달특기사항이 '세탁 주의'이면서 색상이 null값이며
-- 판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
-- 김씨 성을 가진 손님의 이름과 보유 마일리지를 10% 올리고 성별을 출력하시오
-- 컬럼은 회원 이름, (변경 후)회원 마일리지, 회원 성별을 출력
SELECT mem_name, mem_mileage , DECODE(SUBSTR(mem_regno2,1,1), 1,'남', '여') as 성별 FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_qty >= (SELECT AVG(cart_qty) FROM cart)
                AND cart_prod IN(
                    SELECT prod_id FROM prod
                        WHERE prod_delivery = '세탁 주의'
                            AND prod.prod_color IS NULL
                            AND prod_id IN (
                                SELECT buy_prod FROM buyprod
                                    WHERE buy_date < TO_DATE('050601', 'yymmdd'))
                )
    AND mem_name LIKE '김%'
    );

/*
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/

SELECT DECODE(8, 10, 'A', 9, 'B', 8, 'C', 'D') FROM dual;

SELECT mem_id,mem_mileage,CASE 
          WHEN mem_mileage >= '2500' THEN '우수회원'
          ELSE '일반회원' END as "회원 등급"
            FROM member
                WHERE mem_id IN(
                     SELECT cart_member FROM cart
                        WHERE cart_prod IN (
                            SELECT prod_id FROM prod
                                WHERE prod_insdate > TO_DATE('050131','yymmdd')
                                    AND prod_id IN (
                                        SELECT buy_prod FROM buyprod
                                            WHERE buy_cost >= 200000
                                                AND prod_buyer IN(
                                                    SELECT buyer_id FROM buyer
                                                        WHERE SUBSTR(buyer_id,1,3) = 'P20'
                                                )
                                    )
                        )
                );
    
--상품분류정보-- 여성 캐주얼이면서 
--상품정보-- 여름 의류이고, 
--입고상품정보--매입수량이 30개이상이고 6월에 입고한 제품의
-- 마일리지와 판매가를 합한 값 조회
-- Alias 이름,판매가격, 판매가격+마일리지

select prod_name 이름, prod_sale 판매가격, nvl(prod_mileage,0)+prod_sale as "판매가격+마일리지"
    from prod
        where prod_id in(
            select buy_prod
                from buyprod
                    where buy_qty >=30 and
                        to_char(buy_date,'mm')='06') and
                        prod_lgu in(
                            select lprod_gu
                                from lprod
                                    where lprod_nm ='여성캐주얼')and prod_name like '%여름%';

select prod_name 이름
, prod_sale 판매가격
, nvl(prod_mileage,0)+prod_sale as "판매가격+마일리지",
replace(prod_qtysale,0,'입고예정')
from prod
where prod_id in
(select buy_prod
from buyprod
where buy_qty >=1 and
to_char(buy_date,'mm')='06') and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm ='여성캐주얼')and prod_name like '%여름%'
;
