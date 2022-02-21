/*
[����]
�ѹ��� ��ǰ�� ���������� ���� ȸ�� ���̵�� �̸��� ��ȸ�϶�
*/
SELECT mem_id ���̵�, mem_name �̸� FROM member
    WHERE mem_id NOT IN (
        SELECT DISTINCT cart_member FROM cart
        );


/*
[����]
�ѹ��� �Ǹŵ� ���� ���� ��ǰ�� ��ȸ�Ϸ��� �Ѵ� ��ǰ �̸��� ��ȸ�϶�
*/
SELECT prod_name FROM prod
    WHERE prod_id NOT IN(
        SELECT DISTINCT cart_prod FROM cart
    );


/*
ȸ�� �� ������ 1975-01-01���� 1976-12-31 ���̿� �¾ ȸ���� �˻��Ͻÿ�
ȸ�� ID, ȸ�� ��, ���� ��ȸ
*/
SELECT mem_id, mem_name, mem_bir FROM member
    WHERE mem_bir BETWEEN '1975/01/01' AND '1976-12-12';

/*
��ǰ �� �ǸŰ����� 10���� �̻�, 30���� ������ ��ǰ�� ��ȸ
��ȸ �÷��� ��ǰ��, �ǸŰ����Դϴ�.
������ �ǸŰ����� �������� �������� �Ͻÿ�.
*/
SELECT prod_name, prod_sale FROM prod
    WHERE prod_sale BETWEEN 100000 AND 300000
        ORDER BY prod_sale DESC;

/*
[����]
ȸ�� �߿� ������ ȸ���� ���ݱ��� �����ߴ� ��� ��ǰ���� ��ȸ�϶�
*/
SELECT prod_name FROM prod
    WHERE prod_id IN(
        SELECT cart_prod FROM cart
            WHERE cart_member IN (
                SELECT  mem_id FROM member
                    WHERE mem_name = '������'
            )
    );


/*
[����]
�ŷ�ó ����� ���������� ����ϴ� ��ǰ�� ������ ȸ������ ��ȸ�Ϸ��� �Ѵ�
ȸ�����̵�, ȸ�� �̸��� ��ȸ�϶�
*/
SELECT mem_id, mem_name FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_prod IN(
                SELECT prod_id FROM prod
                    WHERE prod_buyer = (
                        SELECT buyer_id FROM buyer
                            WHERE buyer_charger = '�۵���'   -- ���������� ������� ��� �ٲ�
                    )
            )
    );

    
/*
��ǰ�� ���԰��� 30������ 150���̰� �ǸŰ��� 80������ 2�鸸�� ��ǰ �˻�
��ǰ��, ���԰�, �ǸŰ�
*/
SELECT prod_name, prod_cost, prod_sale FROM prod
    WHERE prod_cost BETWEEN 300000 AND 1500000 
        AND prod_sale BETWEEN 800000 AND 2000000;

/*
ȸ���߿� 1975�⵵ ���� �ƴ� ȸ���� �˻��Ͻÿ�
ȸ��ID, ȸ�� ��, ����
*/
SELECT lprod_gu, lprod_nm FROM lprod
    WHERE lprod_nm LIKE 'ȫ%';

-- �达ã��
SELECT mem_id, mem_name FROM member
    WHERE mem_name LIKE'��%';

SELECT * FROM member;

SELECT mem_id, mem_name, mem_bir FROM member
    WHERE TO_CHAR(mem_bir) NOT LIKE'75%';


-- ���� ��ġ��
-- CONCAT �� ���ڿ��� �����Ͽ� ��ȯ
SELECT CONCAT('my name is ', mem_name) FROM member;

-- �ƽ�Ű ���� ���ڷ� ���ڸ� �ƽ�Ű ������
SELECT CHR(65) "CHR", ASCII('��') "ASCII" FROM dual;


-- ��ҹ��� ����
SELECT LOWER('DATE upper lower TEST '),
        UPPER('DATE upper lower TEST '),
        INITCAP('DATE upper lower TEST ') FROM dual;

-- ȸ�� ���̺��� ȸ�� id�� ���� �빮�ڷ�
-- ��ȯ�� id ��ȯ�� id
SELECT mem_id, UPPER(mem_id) FROM member;


-- TRIM ���� �����
-- CONCAT �̶� ����ϰ� || �� �� ����
SELECT '<' || TRIM(' AAA  ') || '>' FROM dual;


-- ���� ��ȯ TRANSLATE

-- ���� ġȯ
-- REPLACE(' ���� �� ���ڿ��� ', '�� ���ڸ� ����', '�� ���ڷ� ġȯ�϶�(������ �����)')
SELECT REPLACE('SQL Project', 'SQL', 'SSQQLL'), REPLACE('JAVA Flex via', 'a') FROM dual;

/*
-- ���� ��ȯ
ȸ�� ���̺��� ȸ���� �� ������ �̾��� �����  ������ �ٲ� ��ȸ�Ͻÿ�.
ȸ����, ������ ġȯ���� �̸�
*/
SELECT mem_name as �̸�, REPLACE( SUBSTR(mem_name,1,1), '��', '��') || SUBSTR(mem_name,2) as ��������
    FROM member
        WHERE mem_name LIKE '��%';

-- �ݿø�, ���� ROUND, TRUNC
SELECT ROUND(345.123,0), ROUND(345.123,1), ROUND(345.123,-1) FROM dual;

-- MOD(c,n) c�� n���� ���� ������ ��
SELECT ROUND(3/2,1), MOD(3,2) FROM dual;

-- �ý��� ��¥ �� , ADD_MONTH
SELECT SYSDATE() FROM dual;

-- ���� ���� ���ƿ��� �������� ������? // ���� ������ ��¥
SELECT NEXT_DAY(SYSDATE, '������'), LAST_DAY(SYSDATE) FROM dual;

-- �̹��� �󸶳� ���ҳ�
SELECT LAST_DAY(SYSDATE) - SYSDATE || '��'  as ������ FROM dual;

-- EXTRACT ��¥���� �ʿ��� �κи� ���� (DATE Ÿ�Ը� ����� ����)
SELECT EXTRACT(YEAR FROM SYSDATE) as "��" FROM dual; 
--(MONTH FROM SYSDATE)(DAY FROM SYSDATE)

SELECT mem_name, mem_bir from member
    WHERE EXTRACT(MONTH FROM mem_bir) = '3';

/*
[����]
ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� ������������ ��ȸ�Ϸ��� �մϴ�.
�÷� ��ǰ��
���� : �Ｚ�� ���Ե� ��ǰ�� ��ȸ, �ߺ� ����� ����
*/
SELECT DISTINCT prod_name FROM prod
    WHERE prod_name LIKE '%�Ｚ%'
        AND prod_id IN (
            SELECT cart_prod FROM cart
                WHERE cart_member IN(
                    SELECT mem_id FROM member
                        WHERE TO_CHAR(mem_bir) LIKE'73%'
                )
        )
        ORDER BY prod_name ASC;


SELECT prod_name, COUNT(prod_name) FROM prod
    WHERE prod_name LIKE '%�Ｚ%'
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

-- �� ��ȯ
-- ��¥ ����
SELECT TO_CHAR(SYSDATE, 'AD YYYY"�� ", CC"����" ') FROM dual;

-- ��ǰ ���̺��� ��ǰ�԰����� 2008-09-28 �������� ������ ��ȸ�Ͻÿ�
-- �÷��� ��ǰ�� ��ǰ �ǸŰ� �԰���
SELECT prod_name, prod_sale, TO_CHAR(prod_insdate, 'YYYY-MM-DD') FROM prod;

-- ȸ�� �̸��� ������ ����ó�� ������ ��ȸ�Ͻÿ�
-- ��������� 1976�� 1�� ����̽ð� �¾ ������ �����
SELECT mem_name || '���� ' || TO_CHAR(mem_bir, 'YYYY"��" MM"�� ����̽ð� �¾ ������" DAY" �Դϴ�" ') as "���" FROM member;
-- ������ ũ��� �˾Ƽ� ����

-- ���� ����
-- 9�� ��������� �ڸ��� ���� ������ ���, 0 �� ������ 0 ���
SELECT TO_CHAR(1234.5,'99,009,999.000') FROM dual;
-- -���̸� <>ó��
SELECT TO_CHAR(-1234.5,'99,009,999.000PR') FROM dual;
-- -��ġ ����
SELECT TO_CHAR(-1234.5,'99,009,999.000MI') FROM dual;

-- ��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��� ����, �ǸŰ����� ����Ͻÿ�(���� ���� �� ��ȭ ǥ��)
SELECT 
    prod_id, TO_CHAR(prod_cost, '999,999,999L'),
    prod_name, 
    TO_CHAR(prod_price, '999,999,999L'),
    TO_CHAR(prod_sale, '999,999,999L') FROM prod;

-- ���ڸ� ���ڷ� �� ��ȯ
SELECT TO_NUMBER(3.14) FROM dual;

/*
ȸ�����̺��� �̻��� ȸ���� ȸ��ID 2~4������ ���ڿ��� ���������� ġȯ�� �� 10�� ���Ͽ� ���ο� ȸ�� ID�� �����Ͻÿ�.
�÷��� ȸ��ID, ������ ȸ��ID
*/
SELECT mem_id, SUBSTR(mem_id,1,2) || (SUBSTR(mem_id,3,4) + 10) FROM member
    WHERE mem_name = '�̻���';
-- �����ϰ� ����ó�� �ص� ����
SELECT mem_id, SUBSTR(mem_id,1,1) || LPAD(TO_NUMBER(SUBSTR(mem_id,2,4) + 10) , LENGTH (SUBSTR(mem_id,2,4)) , '0') FROM member
    WHERE mem_name = '�̻���';





