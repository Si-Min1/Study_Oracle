/*
[문제]
회원정보 중에 구매내역이 있는 회운에 대한 회원아이디 회원이름 생일(yyyy-mm-dd)형태를 조회해 주세오
정렬은 생일을 기준으로
*/
-- 속도문제로 EXISTS를 추천함 위에꺼는
SELECT prod_id, prod_name, prod_lgu
    FROM prod p
        WHERE EXISTS(
            SELECT lprod_gu
                FROM lprod
                    WHERE lprod_gu = p.prod_lgu
                       AND lprod_gu = 'P301'
        ):
        
SELECT mem_id, mem_name, TO_CHAR(mem_bir, 'yyyy-mm-dd') as asdf FROM member
    WHERE mem_id IN(
        SELECT DISTINCT cart_member FROM cart
    )
        ORDER BY asdf ASC;




-------- join --------
-- INNER JOIN --
-- 일반방식
SELECT m.mem_id, c.cart_member 
    FROM member m,cart c;

-- 국제 표준 방식
SELECT * FROM member 
                    CROSS JOIN cart 
                    CROSS JOIN prod
                    CROSS JOIN lprod;

-- 상품테이블에서 상품코드, 상품명, 분류명을 조회
-- 일반방식 (WHERE 문으로 조인)
SELECT p.prod_id, p.prod_name, lprod_nm
    FROM prod p, lprod lp
        WHERE p.prod_lgu = lp.lprod_gu;

-- 국제 표준 방식
SELECT p.prod_id, p.prod_name, lprod_nm
    FROM prod p Inner JOIN lprod lp
        ON p.prod_lgu = lp.lprod_gu;

SELECT p.prod_id "상품코드", p.prod_name "상품명", lprod_nm "분류", b.buyer_name "거래처 명"
    FROM prod p, lprod lp, buyer b
        WHERE p.prod_lgu = lp.lprod_gu 
        AND p.prod_buyer = b.buyer_id;

SELECT p.prod_id "상품코드", p.prod_name "상품명", lprod_nm "분류", b.buyer_name "거래처 명" 
    FROM prod p 
        INNER JOIN lprod lp 
            ON p.prod_lgu = lp.lprod_gu
        INNER JOIN buyer b
            ON p.prod_buyer = b.buyer_id;

/*
문제
회원이 구매한 거래처 정보를 조회하려고 한다
회원 아이디, 회원 이름, 상품거래처명, 상품 분류명 검색
*/
SELECT M.mem_id, M.mem_name, B.buyer_name, L.lprod_nm
    FROM member M, cart C, prod P, buyer B, lprod L 
        WHERE M.mem_id = C.cart_member
           AND P.prod_id = C.cart_prod 
           AND B.buyer_id = P.prod_buyer 
           AND L.lprod_gu = P.prod_lgu;

SELECT M.mem_id, M.mem_name, B.buyer_name, L.lprod_gu
    FROM member M INNER JOIN cart C ON (M.mem_id = C.cart_member)
                            INNER JOIN prod P ON (C.cart_prod = P.prod_id)
                            INNER JOIN buyer B ON (P.prod_buyer = B.buyer_id)
                            INNER JOIN lprod L ON (P.prod_lgu = L.lprod_gu);

/*
[문제]
거래처가 '삼성전자'인 자료에 대한
상품코드, 상품명, 거래처 명을 조회하라
*/

SELECT p.prod_id, p.prod_name, b.buyer_name
    FROM prod p, buyer b
        WHERE p.prod_buyer = b.buyer_id
           AND b.buyer_name = '삼성전자';


SELECT p.prod_id, p.prod_name, b.buyer_name
    FROM prod p INNER JOIN buyer b ON ( p.prod_buyer = b.buyer_id )
        WHERE b.buyer_name = '삼성전자';

SELECT p.prod_id, p.prod_name, b.buyer_name
    FROM prod p INNER JOIN buyer b ON ( p.prod_buyer = b.buyer_id 
                                                        AND b.buyer_name = '삼성전자');


-- OUTER JOIN --
/*
상품 테이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처 주소를 조회
단, 판매가격이 10만원 이하이고 거래처 주소가 부산인 경우만 조회
*/
SELECT p.prod_id, p.prod_name, lp.lprod_nm, b.buyer_name, b.buyer_add1
    FROM prod p, buyer b, lprod lp
        WHERE p.prod_buyer = b.buyer_id
            AND p.prod_lgu = lp.lprod_gu
            AND p.prod_sale <= 100000
            AND b.buyer_add1 LIKE '부산%';


SELECT p.prod_id, p.prod_name, p.prod_lgu, b.buyer_name, b.buyer_add1
    FROM prod p 
        INNER JOIN buyer b ON(
            p.prod_buyer = b.buyer_id
            AND p.prod_sale <= 100000
            AND b.buyer_add1 LIKE '부산%'
        )
        INNER JOIN lprod lp ON(
            p.prod_lgu = lp.lprod_gu
        );

/*
[문제]
상품분류코드가 'P101' 인것에 대한
상품 분류명, 상품 아이디, 판매가, 거래처 담당자, 회원아이디, 주문수량 조회
단, 상품 분류명을 기준으로 내림차순, 상품 아이디를 기준으로 오름차순
*/
SELECT lp.lprod_nm, p.prod_id, p.prod_sale, b.buyer_charger, c.cart_member, c.cart_qty
    FROM prod p, lprod lp, buyer b, cart c
        WHERE p.prod_buyer = b.buyer_id
            AND p.prod_lgu = lp.lprod_gu
            AND c.cart_prod = p.prod_id
            AND lp.lprod_gu = 'P101'
                ORDER BY lp.lprod_nm DESC, p.prod_id ASC;


SELECT lp.lprod_nm, p.prod_id, p.prod_sale, b.buyer_charger, c.cart_member, c.cart_qty
    FROM prod p 
        INNER JOIN lprod lp ON( 
            p.prod_lgu = lp.lprod_gu
            AND lp.lprod_gu = 'P101'
        ) INNER JOIN buyer b ON(
            p.prod_buyer = b.buyer_id
        ) INNER JOIN cart c ON  (
            c.cart_prod = p.prod_id
        )
            ORDER BY lp.lprod_nm DESC, p.prod_id ASC;


--------
/*
6월달 이전(5월달까지)에 입고된 상품중에 
배달특기사항이 '세탁 주의'이면서 색상이 null값인 제품들 중에 판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
김씨 성을 가진 손님의 이름과 보유 마일리지를 구하고 성별을 출력하시오
Alias 이름, 보유 마일리지, 성별
*/
SELECT DISTINCT m.mem_name, m.mem_mileage , DECODE(SUBSTR(m.mem_regno2,1,1), 1,'남', '여') as 성별 
    FROM member m , cart c, prod p , buyprod b
        WHERE m.mem_id = cart_member AND cart_prod = prod_id AND prod_id = buy_prod
        AND c.cart_qty >= (SELECT AVG(cc.cart_qty) FROM cart cc)
        AND p.prod_color IS NULL
        AND p.prod_delivery = '세탁 주의'
        AND b.buy_date < TO_DATE('050601', 'yymmdd')
        AND m.mem_name LIKE '김%'
        ;

SELECT mem_name, mem_mileage , DECODE(SUBSTR(mem_regno2,1,1), 1,'남', '여') as 성별 FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_qty >= (SELECT AVG(cart_qty) FROM cart)
                AND cart_prod IN(
                    SELECT prod_id FROM prod
                        WHERE prod_delivery = '세탁 주의'
                            AND prod_color IS NULL
                            AND prod_id IN (
                                SELECT buy_prod FROM buyprod
                                    WHERE buy_date < TO_DATE('050601', 'yymmdd'))
                )
    AND mem_name LIKE '김%'
    );

/*
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
등록이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
Alias 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/

                
SELECT m.mem_id,m.mem_mileage
            FROM (SELECT mem_id,mem_mileage FROM member) m,
                    (SELECT cart_member, cart_prod FROM cart) c, (SELECT prod_id, prod_insdate, prod_buyer FROM prod) p, 
                    (SELECT buy_prod, buy_cost FROM buyprod) bp, (SELECT buyer_id FROM buyer) b
                WHERE m.mem_id = c.cart_member AND c.cart_prod = p.prod_id AND p.prod_buyer = b.buyer_id AND p.prod_id = bp.buy_prod
                AND p.prod_insdate > TO_DATE('050131','yymmdd')
                AND bp.buy_cost >= 200000
                AND SUBSTR(buyer_id,1,3) = 'P20';

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
/*
서울 외 타지역에 살며 외환은행을 사용하는 거래처 담당자가 담당하는 상품을 구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을을 '리' 로 치환해서 출력해라 
*/

SELECT mem_name,REPLACE( SUBSTR(mem_name,1,1), '이', '리') || SUBSTR(mem_name,2) as 성씨변경 , mem_bir 
    FROM member
        WHERE mem_id IN (
            SELECT cart_member FROM cart
                WHERE cart_prod IN (
                    SELECT prod_id FROM prod
                        WHERE prod_buyer IN (
                            SELECT buyer_id FROM buyer
                                WHERE buyer_bank = '외환은행'
                        )
                )
        );
