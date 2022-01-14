/*
[문제]
한번도 상품을 구매한적이 없는 회원 아이디와 이름을 조회하라
*/
SELECT mem_id 아이디, mem_name 이름 FROM member
    WHERE mem_id NOT IN (
        SELECT DISTINCT cart_member FROM cart
        );


/*
[문제]
한번도 판매된 적이 없는 상품을 조회하려고 한다 상품 이름을 조회하라
*/
SELECT prod_name FROM prod
    WHERE prod_id NOT IN(
        SELECT DISTINCT cart_prod FROM cart
    );


/*
회원 중 생일이 1975-01-01에서 1976-12-31 사이에 태어난 회원을 검색하시오
회원 ID, 회원 명, 생일 조회
*/
SELECT mem_id, mem_name, mem_bir FROM member
    WHERE mem_bir BETWEEN '1975/01/01' AND '1976-12-12';

/*
상품 중 판매가격이 10만원 이상, 30만원 이하인 상품을 조회
조회 컬럼은 상품명, 판매가격입니다.
정렬은 판매가격을 기준으로 내림차순 하시오.
*/
SELECT prod_name, prod_sale FROM prod
    WHERE prod_sale BETWEEN 100000 AND 300000
        ORDER BY prod_sale DESC;

/*
[문제]
회원 중에 김은대 회원이 지금까지 구매했던 모든 상품명을 조회하라
*/
SELECT prod_name FROM prod
    WHERE prod_id IN(
        SELECT cart_prod FROM cart
            WHERE cart_member IN (
                SELECT  mem_id FROM member
                    WHERE mem_name = '김은대'
            )
    );


/*
[문제]
거래처 담당자 강남구씨가 담당하는 상품을 구매한 회원들을 조회하려고 한다
회원아이디, 회원 이름을 조회하라
*/
SELECT mem_id, mem_name FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_prod IN(
                SELECT prod_id FROM prod
                    WHERE prod_buyer = (
                        SELECT buyer_id FROM buyer
                            WHERE buyer_charger = '송동구'   -- 강남구씨가 결과값이 없어서 바꿈
                    )
            )
    );

    
/*
상품중 매입가가 30만에서 150만이고 판매가가 80만에서 2백만인 상품 검색
상품명, 매입가, 판매가
*/
SELECT prod_name, prod_cost, prod_sale FROM prod
    WHERE prod_cost BETWEEN 300000 AND 1500000 
        AND prod_sale BETWEEN 800000 AND 2000000;

/*
회원중에 1975년도 생이 아닌 회원을 검색하시오
회원ID, 회원 명, 생일
*/
SELECT lprod_gu, lprod_nm FROM lprod
    WHERE lprod_nm LIKE '홍%';

-- 김씨찾기
SELECT mem_id, mem_name FROM member
    WHERE mem_name LIKE'김%';

SELECT * FROM member;

SELECT mem_id, mem_name, mem_bir FROM member
    WHERE TO_CHAR(mem_bir) NOT LIKE'75%';


-- 문자 합치기
-- CONCAT 두 문자열을 연결하여 반환
SELECT CONCAT('my name is ', mem_name) FROM member;

-- 아스키 값을 문자로 문자를 아스키 값으로
SELECT CHR(65) "CHR", ASCII('§') "ASCII" FROM dual;


-- 대소문자 변경
SELECT LOWER('DATE upper lower TEST '),
        UPPER('DATE upper lower TEST '),
        INITCAP('DATE upper lower TEST ') FROM dual;

-- 회원 테이블의 회원 id를 전무 대문자로
-- 전환전 id 전환후 id
SELECT mem_id, UPPER(mem_id) FROM member;


-- TRIM 공백 지우기
-- CONCAT 이랑 비슷하게 || 쓸 수 있음
SELECT '<' || TRIM(' AAA  ') || '>' FROM dual;


-- 문자 변환 TRANSLATE

-- 문자 치환
-- REPLACE(' 여기 들어갈 문자에서 ', '이 문자를 빼고', '이 문자로 치환하라(없으면 지우기)')
SELECT REPLACE('SQL Project', 'SQL', 'SSQQLL'), REPLACE('JAVA Flex via', 'a') FROM dual;

/*
-- 문자 반환
회원 테이블의 회원명 중 성씨가 이씨인 사람을  리씨로 바꿔 조회하시오.
회원명, 리씨로 치환한후 이름
*/
SELECT mem_name as 이름, REPLACE( SUBSTR(mem_name,1,1), '이', '리') || SUBSTR(mem_name,2) as 성씨변경
    FROM member
        WHERE mem_name LIKE '이%';

-- 반올림, 절삭 ROUND, TRUNC
SELECT ROUND(345.123,0), ROUND(345.123,1), ROUND(345.123,-1) FROM dual;

-- MOD(c,n) c를 n으로 나눈 나머지 값
SELECT ROUND(3/2,1), MOD(3,2) FROM dual;

-- 시스템 날짜 값 , ADD_MONTH
SELECT SYSDATE() FROM dual;

-- 제일 빨리 돌아오는 월요일이 언제냐? // 월의 마지막 날짜
SELECT NEXT_DAY(SYSDATE, '월요일'), LAST_DAY(SYSDATE) FROM dual;

-- 이번달 얼마나 남았나
SELECT LAST_DAY(SYSDATE) - SYSDATE || '일'  as 남은날 FROM dual;

-- EXTRACT 날짜에서 필요한 부분만 추출 (DATE 타입만 써야함 주의)
SELECT EXTRACT(YEAR FROM SYSDATE) as "년" FROM dual; 
--(MONTH FROM SYSDATE)(DAY FROM SYSDATE)

SELECT mem_name, mem_bir from member
    WHERE EXTRACT(MONTH FROM mem_bir) = '3';

/*
[문제]
회원 생일 중 1973년생이 주로 구매한 상품을 오름차순으로 조회하려고 합니다.
컬럼 상품명
조건 : 삼성이 포함된 상품만 조회, 중복 결과는 제거
*/
SELECT DISTINCT prod_name FROM prod
    WHERE prod_name LIKE '%삼성%'
        AND prod_id IN (
            SELECT cart_prod FROM cart
                WHERE cart_member IN(
                    SELECT mem_id FROM member
                        WHERE TO_CHAR(mem_bir) LIKE'73%'
                )
        )
        ORDER BY prod_name ASC;


SELECT prod_name, COUNT(prod_name) FROM prod
    WHERE prod_name LIKE '%삼성%'
       AND prod_id IN (
            SELECT cart_prod FROM cart
                WHERE cart_member IN(
                    SELECT mem_id FROM member
                        WHERE TO_CHAR(mem_bir) LIKE'73%'
                )
        )
        GROUP BY prod_name
            HAVING COUNT(prod_name) >= 1
                ORDER BY prod_name ASC;

-- 형 변환
-- 날짜 포맷
SELECT TO_CHAR(SYSDATE, 'AD YYYY"년 ", CC"세기" ') FROM dual;

-- 상품 테이블에서 상품입고일을 2008-09-28 형식으로 나오게 조회하시오
-- 컬럼은 상품명 상품 판매가 입고일
SELECT prod_name, prod_sale, TO_CHAR(prod_insdate, 'YYYY-MM-DD') FROM prod;

-- 회원 이름과 생일이 다음처럼 나오게 조회하시오
-- 김은대님은 1976년 1월 출생이시고 태어난 요일은 목요일
SELECT mem_name || '님은 ' || TO_CHAR(mem_bir, 'YYYY"년" MM"월 출생이시고 태어난 요일은" DAY" 입니다" ') as "출생" FROM member;
-- 데이터 크기는 알아서 조절

-- 숫자 포맷
-- 9는 출력형식의 자리에 값이 있으면 출력, 0 은 없으면 0 출력
SELECT TO_CHAR(1234.5,'99,009,999.000') FROM dual;
-- -값이면 <>처리
SELECT TO_CHAR(-1234.5,'99,009,999.000PR') FROM dual;
-- -위치 변경
SELECT TO_CHAR(-1234.5,'99,009,999.000MI') FROM dual;

-- 상품 테이블에서 상품코드, 상품명, 매입가격, 소비자 가격, 판매가격을 출력하시오(단위 구분 및 원화 표시)
SELECT 
    prod_id, TO_CHAR(prod_cost, '999,999,999L'),
    prod_name, 
    TO_CHAR(prod_price, '999,999,999L'),
    TO_CHAR(prod_sale, '999,999,999L') FROM prod;

-- 문자를 숫자로 형 변환
SELECT TO_NUMBER(3.14) FROM dual;

/*
회원테이블에서 이쁜이 회원의 회원ID 2~4번쨰의 문자열을 숫자형으로 치환한 후 10을 더하여 새로운 회원 ID로 조합하시오.
컬럼은 회원ID, 조합후 회원ID
*/
SELECT mem_id, SUBSTR(mem_id,1,2) || (SUBSTR(mem_id,3,4) + 10) FROM member
    WHERE mem_name = '이쁜이';
-- 간단하게 위에처럼 해도 좋음
SELECT mem_id, SUBSTR(mem_id,1,1) || LPAD(TO_NUMBER(SUBSTR(mem_id,2,4) + 10) , LENGTH (SUBSTR(mem_id,2,4)) , '0') FROM member
    WHERE mem_name = '이쁜이';





