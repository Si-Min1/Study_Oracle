/*
lprod   : 상품분류정보
prod    : 상품정보
buyer   : 거래처 정보 (어디서 들고온 상품인가)
member: 회원정보
cart    : 구매 정보
buyprod: 입고상품정보
remain  : 재고수불 정보
*/SELECT * FROM MEMBER;


-- 회원 마일리지 12로 나눈값 " / ' 특수문자 오류 생길 수 있으니 컬럼명 변경 필수 (한글 ㄴㄴ 임시용 ㄱㅊ)
SELECT mem_mileage, mem_mileage/12 as 월평균 FROM MEMBER;


SELECT prod_id, prod_name, prod_sale*55 as sale FROM prod;

-- 중복된 행 제거
SELECT DISTINCT * FROM prod;

-- 상품 테이블의 거래처코드를 중복되지 않게 검색하시오.
SELECT DISTINCT prod_id as 거래처 FROM prod;

SELECT mem_id id, mem_name name, mem_bir bir, mem_mileage mileage
    From member
        ORDER BY id ASC;        -- as로 바꾼 변수도 가능

SELECT prod_name as 상품, prod_sale as 판매가
    FROM prod
        WHERE prod_sale != 170000;       -- 이건 as 안먹힘

SELECT prod_name as 상품, prod_sale as 판매가
    FROM prod
        WHERE prod_sale > 170000;     

SELECT mem_id, mem_name, mem_regno1 
    FROM member
        WHERE mem_bir > '76/01/01'
            ORDER BY mem_id ASC;

-- 생일로 주민번호 앞자리 만들어서 계산하기
SELECT TO_CHAR(mem_bir, 'yymmdd'), mem_bir 
    FROM member WHERE TO_CHAR(mem_bir, 'yymmdd') > '800101';

SELECT * FROM prod
    WHERE prod_lgu = 'P201' OR prod_sale = '170000';

SELECT prod_id 상품코드, prod_name 상품명, prod_sale 판매가
    FROM prod
        WHERE prod_sale >= 300000 AND prod_sale <= 500000;


-- 상품 중에 판매가격이 15만원, 17만원, 33만원인 상품정보 조회.
-- 상품코드, 상품명, 판매가격 조회, 정렬은 상품명을 기준으로 오름차순
SELECT prod_id, prod_name, prod_sale as sale 
    FROM prod
        WHERE prod_sale IN (150000, 170000, 330000)
            ORDER BY prod_id ASC;


-- 회원 중에 아이디가 C001, F001, W001인 회원 조회.
-- 회원 아이디, 회원명 조회, 정렬은 주민번호로 내림차순
SELECT mem_id, mem_name 
    FROM member
        WHERE mem_id IN ('c001', 'f001', 'w001')
            ORDER BY mem_regno1 DESC;

SELECT * FROM member;

-- 상품 분류 테이블에서 현재 상품테이블에 존재하는 분류만 검색( 분류명, 분류코드)
SELECT lprod_gu, lprod_nm FROM lprod
    WHERE lprod_gu IN (
        SELECT prod_lgu FROM prod
        );

-- 상품 분류 테이블에서 현재 상품 테이블에 존재하지 않는 분류만 검색하시오
SELECT lprod_gu, lprod_nm FROM lprod
    WHERE lprod_gu NOT IN (
        SELECT prod_lgu FROM prod
        );






