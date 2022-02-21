/*
lprod   : ��ǰ�з�����
prod    : ��ǰ����
buyer   : �ŷ�ó ���� (��� ���� ��ǰ�ΰ�)
member: ȸ������
cart    : ���� ����
buyprod: �԰��ǰ����
remain  : ������ ����
*/SELECT * FROM MEMBER;


-- ȸ�� ���ϸ��� 12�� ������ " / ' Ư������ ���� ���� �� ������ �÷��� ���� �ʼ� (�ѱ� ���� �ӽÿ� ����)
SELECT mem_mileage, mem_mileage/12 as ����� FROM MEMBER;


SELECT prod_id, prod_name, prod_sale*55 as sale FROM prod;

-- �ߺ��� �� ����
SELECT DISTINCT * FROM prod;

-- ��ǰ ���̺��� �ŷ�ó�ڵ带 �ߺ����� �ʰ� �˻��Ͻÿ�.
SELECT DISTINCT prod_id as �ŷ�ó FROM prod;

SELECT mem_id id, mem_name name, mem_bir bir, mem_mileage mileage
    From member
        ORDER BY id ASC;        -- as�� �ٲ� ������ ����

SELECT prod_name as ��ǰ, prod_sale as �ǸŰ�
    FROM prod
        WHERE prod_sale != 170000;       -- �̰� as �ȸ���

SELECT prod_name as ��ǰ, prod_sale as �ǸŰ�
    FROM prod
        WHERE prod_sale > 170000;     

SELECT mem_id, mem_name, mem_regno1 
    FROM member
        WHERE mem_bir > '76/01/01'
            ORDER BY mem_id ASC;

-- ���Ϸ� �ֹι�ȣ ���ڸ� ���� ����ϱ�
SELECT TO_CHAR(mem_bir, 'yymmdd'), mem_bir 
    FROM member WHERE TO_CHAR(mem_bir, 'yymmdd') > '800101';

SELECT * FROM prod
    WHERE prod_lgu = 'P201' OR prod_sale = '170000';

SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��, prod_sale �ǸŰ�
    FROM prod
        WHERE prod_sale >= 300000 AND prod_sale <= 500000;


-- ��ǰ �߿� �ǸŰ����� 15����, 17����, 33������ ��ǰ���� ��ȸ.
-- ��ǰ�ڵ�, ��ǰ��, �ǸŰ��� ��ȸ, ������ ��ǰ���� �������� ��������
SELECT prod_id, prod_name, prod_sale as sale 
    FROM prod
        WHERE prod_sale IN (150000, 170000, 330000)
            ORDER BY prod_id ASC;


-- ȸ�� �߿� ���̵� C001, F001, W001�� ȸ�� ��ȸ.
-- ȸ�� ���̵�, ȸ���� ��ȸ, ������ �ֹι�ȣ�� ��������
SELECT mem_id, mem_name 
    FROM member
        WHERE mem_id IN ('c001', 'f001', 'w001')
            ORDER BY mem_regno1 DESC;

SELECT * FROM member;

-- ��ǰ �з� ���̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�( �з���, �з��ڵ�)
SELECT lprod_gu, lprod_nm FROM lprod
    WHERE lprod_gu IN (
        SELECT prod_lgu FROM prod
        );

-- ��ǰ �з� ���̺��� ���� ��ǰ ���̺� �������� �ʴ� �з��� �˻��Ͻÿ�
SELECT lprod_gu, lprod_nm FROM lprod
    WHERE lprod_gu NOT IN (
        SELECT prod_lgu FROM prod
        );






