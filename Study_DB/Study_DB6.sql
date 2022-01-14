/*
[문제]
상품분류명, 상품명, 상품 색상, 매입수량, 주문수량, 거래처명을 조회하시오.
단, 상품분류 코드가 [P101, P201, P301] 인 것들에 대해 조회하고
매입수량이 15개 이상이며
'서울'에 살고있는 회원들 중에 생일이 1974년생인 사람들만 조회
*/
SELECT DISTINCT p.prod_name, lp.lprod_nm,p.prod_color, bp.buy_qty, b.buyer_name
    FROM buyprod bp, prod p,buyer b, lprod lp, cart c, member m
        WHERE bp.buy_prod = p.prod_id 
            AND p.prod_buyer = b.buyer_id 
            AND p.prod_lgu = lp.lprod_gu 
            AND p.prod_id = c.cart_prod
            AND c.cart_member = m.mem_id
            AND p.prod_lgu LIKE '%01'
            AND bp.buy_qty >= 15
            AND m.mem_add1 LIKE '%서울%'
            AND TO_CHAR(m.mem_bir,'yyyy') = '1974'
                ORDER BY bp.buy_qty DESC;

SELECT *
    FROM buyprod bp INNER JOIN prod p ON (
        bp.buy_prod = p.prod_id
        AND bp.buy_qty >= 15
    ) INNER JOIN buyer b ON(
        p.prod_buyer = b.buyer_id 
        AND p.prod_lgu LIKE '%01'
    ) INNER JOIN lprod lp ON(
        p.prod_lgu = lp.lprod_gu
    ) INNER JOIN cart c ON (
        p.prod_id = c.cart_prod
    ) INNER JOIN member m ON(
        c.cart_member = m.mem_id
        AND m.mem_add1 LIKE '%서울%'
        AND TO_CHAR(m.mem_bir,'yyyy') = '1974'
    );
            
/*
---- OUTER JOIN ----
전체 데이터를(PK) 를 가지고 있는 쪽을 기준으로 보면 된다.
*/
SELECT * FROM lprod;

-- 일반조인 INNER
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu) 
    FROM lprod, prod
        WHERE lprod_gu = prod_lgu
            GROUP BY lprod_gu, lprod_nm;

-- 일반조인 OUTER 
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu) 
    FROM lprod, prod
        WHERE lprod_gu = prod_lgu (+)
            GROUP BY lprod_gu, lprod_nm;

-- 표준 OUTER JOIN
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu) 
    FROM lprod LEFT OUTER JOIN prod ON(
        lprod_gu = prod_lgu
    )
        GROUP BY lprod_gu, lprod_nm;

/*
전체 상품의 2005년 1월 입고 수량을 검색 조회

-- 난 전체 데이터를 보고 싶어서 OUTER 사용했는데 아래의 두 코드는 왜 같은가? --
FROM 으로 두개의 테이블이 메모리상에 올라감
WHERE절로 필터링을 함 // (+가 없는 쪽을 기준으로 묶음)
그리고 AND로 걸러냄 // 여기서 OUTER 하나마나 걸러져 버림 그래서 표준방식으로 써야함
그 후 그룹으로 묶어서
출력
*/
SELECT prod_id, prod_name, SUM(buy_qty)
    FROM prod, buyprod
        WHERE prod_id = buy_prod 
            AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
                GROUP BY prod_id, prod_name;

SELECT prod_id, prod_name, SUM(buy_qty)
    FROM prod, buyprod
        WHERE prod_id = buy_prod(+)
            AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
                GROUP BY prod_id, prod_name;

-- 표준 방식 OUTER--
/*
FROM에서 데이터를 메모리상에 올리고
ON으로 데이터를 먼저 처리하고
JOIN을 한다 (AND 조건문을 했을경우 데이터 손실이 나는걸 막음)
*WHERE절에 일반 조건이 들어가면 outer조인이 깨져버림 다 있으면 문제없긴한데 그럼 쓸 이유가 없긴함
*/
SELECT prod_id, prod_name, SUM(NVL(buy_qty,0))
    FROM prod LEFT OUTER JOIN buyprod ON(
        prod_id = buy_prod 
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    )
        GROUP BY prod_id, prod_name;


/*
전체 회원의 2005년도 4월달의 구매 현황 검색
컬럼 회원ID 성명 구매수량의 합
*/
SELECT mem_id, mem_name, SUM(NVL(cart_qty,0)) as "C_SUM"
    FROM member LEFT OUTER JOIN cart ON(
        mem_id = cart_member
        AND SUBSTR(cart_no,1,6) = '200504'
    )
        GROUP BY mem_id, mem_name
            ORDER BY C_SUM DESC;


/*
상품분류가 컴퓨터제품('P101')인 상품의 2005년도 일자별 판매 조회
(판매일, 판매금액(5,000,000)초과, 판매수량)
*/
SELECT SUBSTR(cart_no, 1, 8) "판매일", 
          SUM(cart_qty * prod_sale) "판매금액", 
          SUM(cart_qty) "판매수량"
    FROM prod INNER JOIN cart ON(
        prod_id = cart_prod
        AND cart_no LIKE '2005%'
        AND prod_lgu = 'P101'
    )
        GROUP BY SUBSTR(cart_no, 1, 8)
            HAVING SUM(cart_qty * prod_sale) > 5000000
                ORDER BY SUBSTR(cart_no, 1, 8) ASC;

SELECT SUBSTR(cart_no, 1, 8) "판매일", 
          SUM(cart_qty * prod_sale) "판매금액", 
          SUM(cart_qty) "판매수량"
    FROM prod, cart
        WHERE prod_id = cart_prod
        AND cart_no LIKE '2005%'
        AND prod_lgu = 'P101'
            GROUP BY SUBSTR(cart_no, 1, 8)
                HAVING SUM(cart_qty * prod_sale) > 5000000
                    ORDER BY SUBSTR(cart_no, 1, 8) ASC;
    
/*
ORACLE에만 있음
ANY 는 OR의 개념
ALL 은 AND의 개념
*/
-- 공무원보다 잘 버는 안 공무원들
SELECT mem_name, mem_job, mem_mileage
    FROM member
        WHERE mem_job != '공무원'
            AND mem_mileage > ALL(
                SELECT mem_mileage
                    FROM member
                        WHERE mem_job = '공무원'
            );


-- 남는시간 문제 풀기 1조
/*
안전재고수량별 빈도수가 가장 높은 상품을 구매한 회원 중 자영업 아닌 회원의 id와 name
*/
SELECT mem_name, mem_id FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_prod IN (
                SELECT prod_id FROM prod
                    WHERE prod_properstock IN(
                        SELECT MAX(prod_properstock) FROM prod
                    )
            )
    )
        AND mem_job != '자영업';

/*
[문제 만들기]
취급상품코드가 'P1'이고 '인천'에 사는 구매 담당자의 상품을 구매한 
회원의 결혼기념일이 8월달이 아니면서 
평균마일리지(소수두째자리까지) 미만이면서 
구매일에 첫번째로 구매한 회원의 
회원ID, 회원이름, 회원마일리지를 검색하시오.  
*/

SELECT mem_id, mem_name, mem_mileage FROM member
    WHERE mem_id IN(
           SELECT cart_member FROM cart
                WHERE cart_no LIKE '%01'
                    AND cart_prod LIKE 'P1%'
                    AND cart_prod IN (
                        SELECT prod_id FROM prod
                            WHERE prod_buyer IN (
                                SELECT buyer_id FROM buyer
                                    WHERE buyer_add1 LIKE '인천%'
                            )
                    )
    )
    AND (mem_memorial = '결혼기념일' AND EXTRACT(MONTH FROM mem_memorialday) != '08');
/*
<태영>
김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가?
*/
SELECT buyer_comtel
FROM buyer
WHERE buyer_id IN( 
         SELECT prod_buyer
         FROM prod
         WHERE prod_id IN ( 
                                      SELECT cart_prod
                                      FROM cart
                                      WHERE cart_member IN (
                                                                         SELECT mem_id
                                                                         FROM member
                                                                         WHERE mem_name = '김성욱')));
/*
<태경>
서울 외 타지역에 살며 외환은행을 사용하는 거래처 담당자가 담당하는 상품을 구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을을 '리' 로 치환해서 출력해라 
*/
SELECT concat(replace(substr(mem_name, 1, 1), '이', '리')
                    , substr(mem_name , 2)) 이름
        , mem_bir
        FROM member
        WHERE mem_ID IN(
            SELECT cart_member
            FROM cart
            WHERE cart_prod IN(
            SELECT prod_id
            FROM prod
            WHERE prod_buyer IN(
                SELECT buyer_id
                FROM buyer
                WHERE buyer_add1 NOT Like '서울%'
                AND buyer_bank = '외환은행')))
;
/*
1. 오철희가 산 물건 중 TV 가 고장나서 교환받으려고 한다
교환받으려면 거래처 전화번호를 이용해야 한다.
구매처와 전화번호를 조회하시오.
*/
select buyer_name, buyer_comtel
    FROM buyer
        WHERE buyer_id IN (
            SELECT prod_buyer
                FROM prod
                    WHERE prod_id IN(
                        SELECT cart_prod
                            FROM cart
                                WHERE cart_member IN(
                                    SELECT mem_id FROM member
                                        WHERE mem_name = '오철희'
                                )
                    )
        );


/*
2. 대전에 사는 73년이후에 태어난 주부들중 2005년4월에 구매한 물품을 조회하고, 
그상품을 거래하는 각거래처의 계좌 은행명과 계좌번호를 뽑으시오.
(단, 은행명-계좌번호).
*/
SELECT buyer_bank || ' ' ||buyer_bankno FROM buyer
    WHERE buyer_id IN(
        SELECT prod_buyer FROM prod
            WHERE prod_id IN(
                SELECT cart_prod FROM cart
                    WHERE cart_no LIKE '200504%'
                    AND cart_member IN (
                        SELECT mem_id FROM member
                            WHERE mem_add1 LIKE '대전%'
                            AND TO_CHAR(mem_bir, 'yyyy') >= 1973
                            AND mem_job = '주부'
                    )
            )    
    );
    
/*
3. 물건을 구매한 회원들 중 5개이상 구매한 회원과 4개이하로 구매한 회원에게 쿠폰을 할인율이 다른 쿠폰을 발행할 예정이다. 
회원들을 구매횟수에 따라  오름차순으로 정렬하고  회원들의 회원id와 전화번호(HP)를 조회하라.
*/
SELECT mem_id, mem_hp FROM member
    WHERE mem_id IN(
        SELECT cart_member FROM cart
            WHERE cart_qty > 4
    );






