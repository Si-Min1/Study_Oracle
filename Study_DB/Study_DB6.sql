/*
[����]
��ǰ�з���, ��ǰ��, ��ǰ ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ�Ͻÿ�.
��, ��ǰ�з� �ڵ尡 [P101, P201, P301] �� �͵鿡 ���� ��ȸ�ϰ�
���Լ����� 15�� �̻��̸�
'����'�� ����ִ� ȸ���� �߿� ������ 1974����� ����鸸 ��ȸ
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
            AND m.mem_add1 LIKE '%����%'
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
        AND m.mem_add1 LIKE '%����%'
        AND TO_CHAR(m.mem_bir,'yyyy') = '1974'
    );
            
/*
---- OUTER JOIN ----
��ü �����͸�(PK) �� ������ �ִ� ���� �������� ���� �ȴ�.
*/
SELECT * FROM lprod;

-- �Ϲ����� INNER
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu) 
    FROM lprod, prod
        WHERE lprod_gu = prod_lgu
            GROUP BY lprod_gu, lprod_nm;

-- �Ϲ����� OUTER 
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu) 
    FROM lprod, prod
        WHERE lprod_gu = prod_lgu (+)
            GROUP BY lprod_gu, lprod_nm;

-- ǥ�� OUTER JOIN
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu) 
    FROM lprod LEFT OUTER JOIN prod ON(
        lprod_gu = prod_lgu
    )
        GROUP BY lprod_gu, lprod_nm;

/*
��ü ��ǰ�� 2005�� 1�� �԰� ������ �˻� ��ȸ

-- �� ��ü �����͸� ���� �; OUTER ����ߴµ� �Ʒ��� �� �ڵ�� �� ������? --
FROM ���� �ΰ��� ���̺��� �޸𸮻� �ö�
WHERE���� ���͸��� �� // (+�� ���� ���� �������� ����)
�׸��� AND�� �ɷ��� // ���⼭ OUTER �ϳ����� �ɷ��� ���� �׷��� ǥ�ع������ �����
�� �� �׷����� ���
���
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

-- ǥ�� ��� OUTER--
/*
FROM���� �����͸� �޸𸮻� �ø���
ON���� �����͸� ���� ó���ϰ�
JOIN�� �Ѵ� (AND ���ǹ��� ������� ������ �ս��� ���°� ����)
*WHERE���� �Ϲ� ������ ���� outer������ �������� �� ������ ���������ѵ� �׷� �� ������ ������
*/
SELECT prod_id, prod_name, SUM(NVL(buy_qty,0))
    FROM prod LEFT OUTER JOIN buyprod ON(
        prod_id = buy_prod 
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    )
        GROUP BY prod_id, prod_name;


/*
��ü ȸ���� 2005�⵵ 4������ ���� ��Ȳ �˻�
�÷� ȸ��ID ���� ���ż����� ��
*/
SELECT mem_id, mem_name, SUM(NVL(cart_qty,0)) as "C_SUM"
    FROM member LEFT OUTER JOIN cart ON(
        mem_id = cart_member
        AND SUBSTR(cart_no,1,6) = '200504'
    )
        GROUP BY mem_id, mem_name
            ORDER BY C_SUM DESC;


/*
��ǰ�з��� ��ǻ����ǰ('P101')�� ��ǰ�� 2005�⵵ ���ں� �Ǹ� ��ȸ
(�Ǹ���, �Ǹűݾ�(5,000,000)�ʰ�, �Ǹż���)
*/
SELECT SUBSTR(cart_no, 1, 8) "�Ǹ���", 
          SUM(cart_qty * prod_sale) "�Ǹűݾ�", 
          SUM(cart_qty) "�Ǹż���"
    FROM prod INNER JOIN cart ON(
        prod_id = cart_prod
        AND cart_no LIKE '2005%'
        AND prod_lgu = 'P101'
    )
        GROUP BY SUBSTR(cart_no, 1, 8)
            HAVING SUM(cart_qty * prod_sale) > 5000000
                ORDER BY SUBSTR(cart_no, 1, 8) ASC;

SELECT SUBSTR(cart_no, 1, 8) "�Ǹ���", 
          SUM(cart_qty * prod_sale) "�Ǹűݾ�", 
          SUM(cart_qty) "�Ǹż���"
    FROM prod, cart
        WHERE prod_id = cart_prod
        AND cart_no LIKE '2005%'
        AND prod_lgu = 'P101'
            GROUP BY SUBSTR(cart_no, 1, 8)
                HAVING SUM(cart_qty * prod_sale) > 5000000
                    ORDER BY SUBSTR(cart_no, 1, 8) ASC;
    
/*
ORACLE���� ����
ANY �� OR�� ����
ALL �� AND�� ����
*/
-- ���������� �� ���� �� ��������
SELECT mem_name, mem_job, mem_mileage
    FROM member
        WHERE mem_job != '������'
            AND mem_mileage > ALL(
                SELECT mem_mileage
                    FROM member
                        WHERE mem_job = '������'
            );


-- ���½ð� ���� Ǯ�� 1��
/*
������������ �󵵼��� ���� ���� ��ǰ�� ������ ȸ�� �� �ڿ��� �ƴ� ȸ���� id�� name
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
        AND mem_job != '�ڿ���';

/*
[���� �����]
��޻�ǰ�ڵ尡 'P1'�̰� '��õ'�� ��� ���� ������� ��ǰ�� ������ 
ȸ���� ��ȥ������� 8������ �ƴϸ鼭 
��ո��ϸ���(�Ҽ���°�ڸ�����) �̸��̸鼭 
�����Ͽ� ù��°�� ������ ȸ���� 
ȸ��ID, ȸ���̸�, ȸ�����ϸ����� �˻��Ͻÿ�.  
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
                                    WHERE buyer_add1 LIKE '��õ%'
                            )
                    )
    )
    AND (mem_memorial = '��ȥ�����' AND EXTRACT(MONTH FROM mem_memorialday) != '08');
/*
<�¿�>
�輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�?
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
                                                                         WHERE mem_name = '�輺��')));
/*
<�°�>
���� �� Ÿ������ ��� ��ȯ������ ����ϴ� �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� ������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ�������� '��' �� ġȯ�ؼ� ����ض� 
*/
SELECT concat(replace(substr(mem_name, 1, 1), '��', '��')
                    , substr(mem_name , 2)) �̸�
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
                WHERE buyer_add1 NOT Like '����%'
                AND buyer_bank = '��ȯ����')))
;
/*
1. ��ö�� �� ���� �� TV �� ���峪�� ��ȯ�������� �Ѵ�
��ȯ�������� �ŷ�ó ��ȭ��ȣ�� �̿��ؾ� �Ѵ�.
����ó�� ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
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
                                        WHERE mem_name = '��ö��'
                                )
                    )
        );


/*
2. ������ ��� 73�����Ŀ� �¾ �ֺε��� 2005��4���� ������ ��ǰ�� ��ȸ�ϰ�, 
�׻�ǰ�� �ŷ��ϴ� ���ŷ�ó�� ���� ������ ���¹�ȣ�� �����ÿ�.
(��, �����-���¹�ȣ).
*/
SELECT buyer_bank || ' ' ||buyer_bankno FROM buyer
    WHERE buyer_id IN(
        SELECT prod_buyer FROM prod
            WHERE prod_id IN(
                SELECT cart_prod FROM cart
                    WHERE cart_no LIKE '200504%'
                    AND cart_member IN (
                        SELECT mem_id FROM member
                            WHERE mem_add1 LIKE '����%'
                            AND TO_CHAR(mem_bir, 'yyyy') >= 1973
                            AND mem_job = '�ֺ�'
                    )
            )    
    );
    
/*
3. ������ ������ ȸ���� �� 5���̻� ������ ȸ���� 4�����Ϸ� ������ ȸ������ ������ �������� �ٸ� ������ ������ �����̴�. 
ȸ������ ����Ƚ���� ����  ������������ �����ϰ�  ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
*/
SELECT mem_id, mem_hp FROM member
    WHERE mem_id IN(
        SELECT cart_member FROM cart
            WHERE cart_qty > 4
    );






