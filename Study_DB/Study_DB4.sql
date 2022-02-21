-- ��ճ���
-- ��ǰ���̺��� ��ǰ �з��� ���԰��� ���
-- ROUND �Ҽ��� ����
-- �˹� �÷��� �׷��Լ��� ����� ��� GROUP BY�� ����ؾ� �Ѵ�, �ݴ뵵 �׷��ϴ�(�ȳ����� ���� ��).

-- ��ǰ ���̺��� ��ǰ �з��� �ǸŰ��� ��հ� ���ϱ�
SELECT prod_lgu, ROUND(AVG(prod_sale), 2) FROM prod
    GROUP BY prod_lgu;

-- ��ǰ���̺��� �ǸŰ��� ��� ���� ���Ͻÿ�.
SELECT ROUND(AVG(prod_sale), 2) FROM prod;

-- COUNT
-- ��ٱ��� ���̺��� ȸ���� COUNT ����
-- �÷��� ȸ��ID �ڷ��(DISTINCT), �ڷ��, �ڷ��(*)
SELECT cart_member, COUNT(DISTINCT(cart_member)), COUNT(cart_member), COUNT(*) FROM cart
    GROUP BY cart_member;

/*
[����]
���ż����� ��ü ��� �̻��� ������ ȸ������ ���̵�� �̸��� ��ȸ
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

-- �̰� �������
SELECT cart_member, AVG(cart_qty) FROM cart 
                    GROUP BY cart_member
                        HAVING AVG(cart_qty) > (SELECT AVG(cart_qty) FROM cart );


SELECT DISTINCT(c.cart_member), m.mem_name FROM cart c, member m
    WHERE c.cart_member = m.mem_id AND c.cart_qty > (SELECT AVG(cart_qty) FROM cart);


/*
1.  SELECT
1_1. �÷���
2. FROM
3.  WHERE
4.  (AND,OR)
5.  GROUP
6.  HAVING
7.  ORDER

1 - 2 - 3 - 5 - 6 - 1_1 - 7 ������ �޸� ������ �ö�
*/
SELECT COUNT(*) FROM prod;

/*
[����]
���ų���(��ٱ���) ��Ͽ��� ȸ�� ���̵� ���� �ֹ�(����)�� ���� ����� ��ȸ�Ͻÿ�
�� ȸ�� ���̵� �������� ������������ ��ȸ�Ͻÿ�
*/
SELECT cart_member, ROUND(AVG(cart_qty), 2) as qty
    FROM cart 
        GROUP BY cart_member
            ORDER BY cart_member DESC;

/*
[����]
��ǰ�������� �ǸŰ����� ��հ��� ��ȸ�Ͻÿ�
��, ��հ��� �Ҽ��� 2��° �ڸ����� ǥ���Ͻÿ�
*/
SELECT ROUND(AVG(prod_sale),2) FROM prod;

/*
[����]
��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ��� �����ּ���.
��ȸ �÷��� ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ����� ���
��, ��հ��� �Ҽ��� 2�ڸ������� ǥ��
*/
SELECT prod_lgu, ROUND(AVG(prod_sale),2) FROM prod
    GROUP BY prod_lgu;

-- ȸ�� ���̺��� ��̺��� COUNT�����Ͻÿ�
SELECT mem_like, COUNT(mem_like), COUNT(*) FROM member
    GROUP BY mem_like;

-- ȸ�� ���̺��� ���� �������� COUNT �����Ͻÿ�
SELECT COUNT(DISTINCT mem_job) as ���������� FROM member;

/*
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ����
���̵�, �̸�, ���ϸ����� ��ȸ�Ͻÿ�.
��, ������ ���ϸ����� ������(��������)
*/
SELECT mem_id, mem_name, mem_mileage FROM member
    WHERE mem_mileage > (
        SELECT AVG(mem_mileage) FROM member
    )
        ORDER BY mem_mileage DESC;

-- �ִ� �ּ� MAX, MIN

-- ������ 2005�⵵ 7�� 11���̶� �����ϰ� ��ٱ��Ͽ� �߻��� �߰��ֹ���ȣ�� �˻��Ͻÿ�
SELECT TO_CHAR(SYSDATE, 'yyyymmdd'), MAX(cart_no) as "�˻� ����� ������ �ֹ�", MAX(cart_no)+1 as "�߰��� �ֹ� ��ȣ" FROM cart
    WHERE cart_no LIKE '20050711%';

/*
[����]
�������� �������� �⵵ ���� �Ǹŵ� ��ǰ�� ����,
��� ���ż����� ��ȸ�Ϸ����Ѵ�.
������ �⵵���� ���������Ѵ�.
*/
SELECT SUBSTR(cart_no,1,4) as asdf, SUM(cart_qty), AVG(cart_qty) FROM cart
    GROUP BY SUBSTR(cart_no,1,4)
        ORDER BY asdf desc;

/*
[����]
������������ �⵵��, ��ǰ�з� �ڵ庰 ��ǰ�� ������ ��ȸ�Ϸ��� �Ѵ�(COUNT)
������ �⵵�� �������� �������� �Ͻÿ�
*/
SELECT SUBSTR(cart_no,1,4) as yyyy, SUBSTR(cart_prod,1,4) as "��ǰ �ڵ�", COUNT(cart_qty) as "����" FROM cart
    GROUP BY  SUBSTR(cart_prod,1,4), SUBSTR(cart_no,1,4)
        ORDER BY yyyy DESC;

/*
ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ��� �հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ο��� �˻�
*/
SELECT ROUND(AVG(mem_mileage),2) asd1, SUM(mem_mileage) asd2, MAX(mem_mileage) asd3, MIN(mem_mileage) asd4, COUNT(mem_id) asd5
    FROM member;

/*
��ǰ���̺��� ��ǰ�з��� �ǸŰ� ��ü�� ���, �ղ� �ְ��� ��, �ڷ���� �˻��Ͻÿ�
*/
SELECT prod_lgu, ROUND(AVG(prod_sale),2) asd1, SUM(prod_sale) asd2, MAX(prod_sale) asd3, MIN(prod_sale) asd4, COUNT(prod_sale) asd5
    FROM prod
        GROUP BY prod_lgu
            HAVING COUNT(prod_sale) > 20;

/*
ȸ�� ���̺��� ����(�ּ�1�� 2�ڸ�), ���ϳ⵵���� ���ϸ��� ���, ���ϸ��� �հ�, �ְ��� ���ϸ���, �ڷ�� �˻�
*/
SELECT SUBSTR(mem_add1,1,2) as "����" , TO_CHAR(mem_bir, 'yyyy') as "�⵵", 
          ROUND(AVG(mem_mileage),2) asd1, SUM(mem_mileage) asd2, 
          MAX(mem_mileage) asd3, MIN(mem_mileage) asd4, COUNT(mem_id) asd5
    FROM member
        GROUP BY SUBSTR(mem_add1,1,2), TO_CHAR(mem_bir, 'yyyy');

-- ������ NULL ������ ���� COMMIT ���� --
UPDATE buyer SET buyer_charger = NULL
    WHERE buyer_charger LIKE '��%';
UPDATE buyer SET buyer_charger = ''
    WHERE buyer_charger LIKE '��%';
--------------------------------------------------
SELECT buyer_charger FROM buyer; -- (null) �� ����
    
-- NULL�� �̿��� NULL�� ��
SELECT buyer_name �ŷ�ó, buyer_charger ����� FROM buyer
    WHERE buyer_charger = NULL; -- �ȳ���
SELECT buyer_name �ŷ�ó, buyer_charger ����� FROM buyer
    WHERE buyer_charger IS NULL;

-- NULL���� ��� ���ٷ� ġȯ
SELECT buyer_name �ŷ�ó, NVL(buyer_charger, '����') ����� FROM buyer;
SELECT buyer_name �ŷ�ó, NVL2(buyer_charger, '����', '����') ����� FROM buyer;

SELECT 10 * NULL FROM dual;
SELECT 10 * NVL(NULL,0) FROM dual;

/*
ȸ�� ���ϸ����� 100�� ���� ��ġ �˻� (NVL ���)
�÷� ���� ���ϸ��� ���� ���ϸ���
*/
SELECT mem_name, mem_mileage, NVL(mem_mileage, 0) + 100 FROM member;

/*
ȸ�� ���ϸ����� ������ '���� ȸ��' ������ '������ ȸ��'���� ���
�÷� ���� ���ϸ��� ȸ�� ����
*/
SELECT mem_name, mem_mileage, NVL2(mem_mileage, '����ȸ��', '������ ȸ��') as asdf FROM member;

-- DECODE
/*
�Ʒ��� DECODE �ؼ�
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
                    'P1', '��ǻ��/���� ��ǰ',
                    'P2', '�Ƿ�',
                    'P3', '��ȭ', '��Ÿ')
    FROM prod;

/*
��ǰ �з��� ���� �α��ڰ� 'P1'�̸� �ǸŰ��� 10% �λ��ϰ� 'P2'�̸� 15%�λ��ϰ� �������� ���ֶ�
�÷� ��ǰ�� �ǸŰ� ���� �ǸŰ�
*/
SELECT prod_name, prod_sale,
          DECODE(SUBSTR(prod_lgu,1,2), 'P1', prod_sale*1.1, 'P2', prod_sale*1.15, prod_sale) as asdf
    FROM prod;

-- CASE WHEN
/*
cin << n;
switch(n){
    case ��1 : 
        ���๮; 
        break;  
    default :
        ���๮;    
}
CASE �÷�  
WHEN ����1 THEN ��1 
WHEN ����2 THEN ��2 
ELSE ��3 
END 

ȸ������ ���̺��� �ֹε�Ϲ�ȣ ���ڸ��� �Ἥ ���� �����ϱ�
�÷��� ȸ���� �ֹε�Ϲ�ȣ(�ֹ�1 - �ֹ�2), ����
*/
SELECT SUBSTR(mem_regno2,1,1) FROM member;
SELECT mem_name, mem_regno1 || '-' || mem_regno2 as �ֹι�ȣ, 
          CASE 
          WHEN SUBSTR(mem_regno2,1,1) = 1 THEN '����'
          ELSE '����' END as "����"
    FROM member;

/*
-�԰� ����-6���� ����(5���ޱ���)�� �԰�� ��ǰ�߿� -��ǰ����-���Ư������� '��Ź ����'�̸鼭 ������ null����
-��������-��ǰ���� �Ǹŷ��� ��պ��� ���� �ȸ��� ������ -ȸ������-�达�� ���� �մ��� �̸��� ���� ���ϸ����� 1000�� ���Ͽ� ���ϰ� ������ ����Ͻÿ�
�÷� ȸ�� �̸�, ȸ�� ���ϸ���, ȸ�� ����
*/
-- 2005�� 6�� ����(5���ޱ���)�� �԰�� ��ǰ�߿� 
-- ���Ư������� '��Ź ����'�̸鼭 ������ null���̸�
-- �Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
-- �达 ���� ���� �մ��� �̸��� ���� ���ϸ����� 10% �ø��� ������ ����Ͻÿ�
-- �÷��� ȸ�� �̸�, (���� ��)ȸ�� ���ϸ���, ȸ�� ������ ���
SELECT mem_name, mem_mileage , DECODE(SUBSTR(mem_regno2,1,1), 1,'��', '��') as ���� FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_qty >= (SELECT AVG(cart_qty) FROM cart)
                AND cart_prod IN(
                    SELECT prod_id FROM prod
                        WHERE prod_delivery = '��Ź ����'
                            AND prod.prod_color IS NULL
                            AND prod_id IN (
                                SELECT buy_prod FROM buyprod
                                    WHERE buy_date < TO_DATE('050601', 'yymmdd'))
                )
    AND mem_name LIKE '��%'
    );

/*
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ ������� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/

SELECT DECODE(8, 10, 'A', 9, 'B', 8, 'C', 'D') FROM dual;

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
    
--��ǰ�з�����-- ���� ĳ�־��̸鼭 
--��ǰ����-- ���� �Ƿ��̰�, 
--�԰��ǰ����--���Լ����� 30���̻��̰� 6���� �԰��� ��ǰ��
-- ���ϸ����� �ǸŰ��� ���� �� ��ȸ
-- Alias �̸�,�ǸŰ���, �ǸŰ���+���ϸ���

select prod_name �̸�, prod_sale �ǸŰ���, nvl(prod_mileage,0)+prod_sale as "�ǸŰ���+���ϸ���"
    from prod
        where prod_id in(
            select buy_prod
                from buyprod
                    where buy_qty >=30 and
                        to_char(buy_date,'mm')='06') and
                        prod_lgu in(
                            select lprod_gu
                                from lprod
                                    where lprod_nm ='����ĳ�־�')and prod_name like '%����%';

select prod_name �̸�
, prod_sale �ǸŰ���
, nvl(prod_mileage,0)+prod_sale as "�ǸŰ���+���ϸ���",
replace(prod_qtysale,0,'�԰���')
from prod
where prod_id in
(select buy_prod
from buyprod
where buy_qty >=1 and
to_char(buy_date,'mm')='06') and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm ='����ĳ�־�')and prod_name like '%����%'
;
