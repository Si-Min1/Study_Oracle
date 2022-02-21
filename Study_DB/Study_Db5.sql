/*
[����]
ȸ������ �߿� ���ų����� �ִ� ȸ� ���� ȸ�����̵� ȸ���̸� ����(yyyy-mm-dd)���¸� ��ȸ�� �ּ���
������ ������ ��������
*/
-- �ӵ������� EXISTS�� ��õ�� ��������
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
-- �Ϲݹ��
SELECT m.mem_id, c.cart_member 
    FROM member m,cart c;

-- ���� ǥ�� ���
SELECT * FROM member 
                    CROSS JOIN cart 
                    CROSS JOIN prod
                    CROSS JOIN lprod;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ
-- �Ϲݹ�� (WHERE ������ ����)
SELECT p.prod_id, p.prod_name, lprod_nm
    FROM prod p, lprod lp
        WHERE p.prod_lgu = lp.lprod_gu;

-- ���� ǥ�� ���
SELECT p.prod_id, p.prod_name, lprod_nm
    FROM prod p Inner JOIN lprod lp
        ON p.prod_lgu = lp.lprod_gu;

SELECT p.prod_id "��ǰ�ڵ�", p.prod_name "��ǰ��", lprod_nm "�з�", b.buyer_name "�ŷ�ó ��"
    FROM prod p, lprod lp, buyer b
        WHERE p.prod_lgu = lp.lprod_gu 
        AND p.prod_buyer = b.buyer_id;

SELECT p.prod_id "��ǰ�ڵ�", p.prod_name "��ǰ��", lprod_nm "�з�", b.buyer_name "�ŷ�ó ��" 
    FROM prod p 
        INNER JOIN lprod lp 
            ON p.prod_lgu = lp.lprod_gu
        INNER JOIN buyer b
            ON p.prod_buyer = b.buyer_id;

/*
����
ȸ���� ������ �ŷ�ó ������ ��ȸ�Ϸ��� �Ѵ�
ȸ�� ���̵�, ȸ�� �̸�, ��ǰ�ŷ�ó��, ��ǰ �з��� �˻�
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
[����]
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
��ǰ�ڵ�, ��ǰ��, �ŷ�ó ���� ��ȸ�϶�
*/

SELECT p.prod_id, p.prod_name, b.buyer_name
    FROM prod p, buyer b
        WHERE p.prod_buyer = b.buyer_id
           AND b.buyer_name = '�Ｚ����';


SELECT p.prod_id, p.prod_name, b.buyer_name
    FROM prod p INNER JOIN buyer b ON ( p.prod_buyer = b.buyer_id )
        WHERE b.buyer_name = '�Ｚ����';

SELECT p.prod_id, p.prod_name, b.buyer_name
    FROM prod p INNER JOIN buyer b ON ( p.prod_buyer = b.buyer_id 
                                                        AND b.buyer_name = '�Ｚ����');


-- OUTER JOIN --
/*
��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó �ּҸ� ��ȸ
��, �ǸŰ����� 10���� �����̰� �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
*/
SELECT p.prod_id, p.prod_name, lp.lprod_nm, b.buyer_name, b.buyer_add1
    FROM prod p, buyer b, lprod lp
        WHERE p.prod_buyer = b.buyer_id
            AND p.prod_lgu = lp.lprod_gu
            AND p.prod_sale <= 100000
            AND b.buyer_add1 LIKE '�λ�%';


SELECT p.prod_id, p.prod_name, p.prod_lgu, b.buyer_name, b.buyer_add1
    FROM prod p 
        INNER JOIN buyer b ON(
            p.prod_buyer = b.buyer_id
            AND p.prod_sale <= 100000
            AND b.buyer_add1 LIKE '�λ�%'
        )
        INNER JOIN lprod lp ON(
            p.prod_lgu = lp.lprod_gu
        );

/*
[����]
��ǰ�з��ڵ尡 'P101' �ΰͿ� ����
��ǰ �з���, ��ǰ ���̵�, �ǸŰ�, �ŷ�ó �����, ȸ�����̵�, �ֹ����� ��ȸ
��, ��ǰ �з����� �������� ��������, ��ǰ ���̵� �������� ��������
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
6���� ����(5���ޱ���)�� �԰�� ��ǰ�߿� 
���Ư������� '��Ź ����'�̸鼭 ������ null���� ��ǰ�� �߿� �Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
�达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
Alias �̸�, ���� ���ϸ���, ����
*/
SELECT DISTINCT m.mem_name, m.mem_mileage , DECODE(SUBSTR(m.mem_regno2,1,1), 1,'��', '��') as ���� 
    FROM member m , cart c, prod p , buyprod b
        WHERE m.mem_id = cart_member AND cart_prod = prod_id AND prod_id = buy_prod
        AND c.cart_qty >= (SELECT AVG(cc.cart_qty) FROM cart cc)
        AND p.prod_color IS NULL
        AND p.prod_delivery = '��Ź ����'
        AND b.buy_date < TO_DATE('050601', 'yymmdd')
        AND m.mem_name LIKE '��%'
        ;

SELECT mem_name, mem_mileage , DECODE(SUBSTR(mem_regno2,1,1), 1,'��', '��') as ���� FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_qty >= (SELECT AVG(cart_qty) FROM cart)
                AND cart_prod IN(
                    SELECT prod_id FROM prod
                        WHERE prod_delivery = '��Ź ����'
                            AND prod_color IS NULL
                            AND prod_id IN (
                                SELECT buy_prod FROM buyprod
                                    WHERE buy_date < TO_DATE('050601', 'yymmdd'))
                )
    AND mem_name LIKE '��%'
    );

/*
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
����� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
Alias ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
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
          WHEN mem_mileage >= '2500' THEN '���ȸ��'
          ELSE '�Ϲ�ȸ��' END as "ȸ�� ���"
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
���� �� Ÿ������ ��� ��ȯ������ ����ϴ� �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� ������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ�������� '��' �� ġȯ�ؼ� ����ض� 
*/

SELECT mem_name,REPLACE( SUBSTR(mem_name,1,1), '��', '��') || SUBSTR(mem_name,2) as �������� , mem_bir 
    FROM member
        WHERE mem_id IN (
            SELECT cart_member FROM cart
                WHERE cart_prod IN (
                    SELECT prod_id FROM prod
                        WHERE prod_buyer IN (
                            SELECT buyer_id FROM buyer
                                WHERE buyer_bank = '��ȯ����'
                        )
                )
        );
