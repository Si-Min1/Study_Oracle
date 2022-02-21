-- ����
CREATE TABLE lprod(
    lprod_id number(7) NOT NULL,
    lprod_gu char(4) NOT NULL,
    lprod_nm varchar2(40) NOT NULL,
    CONSTRAINT pk_lprod primary key (lprod_gu)
);

-- ��ȸ�ϱ�
SELECT * FROM lprod;


-- ������ ����
INSERT INTO lprod(
    lprod_id, lprod_gu, lprod_nm
) Values (
    9, 'P403', '������'
);

-- ��ȸ
-- ��ǰ�з��������� ��ǰ�з� �ڵ��� ���� P@@@ �� �����͸� ��ȸ�Ͻʽÿ�
SELECT * FROM lprod
    WHERE lprod_gu = 'P202';

-- ���� ����
-- ��ǰ�з��ڵ尡 P102�� ���Ͽ� ��ǰ�з� ���� ����� �����Ͻʽÿ�.
UPDATE lprod SET lprod_nm = '���'
    WHERE lprod_gu = 'P102';

-- ���� ����
-- ��ǰ�з��������� �з��ڵ尡  P202�� ���� �����͸� �����Ͻÿ�.
DELETE FROM lprod
    WHERE lprod_gu = 'P202';

-- ����
-- �ŷ�ó ���� ���̺� ����
CREATE TABLE buyer(
    buyer_id char(6) NOT NULL,                      -- �ŷ�ó �ڵ�
    buyer_name VARCHAR2(40) NOT NULL,       -- �ŷ�ó��
    buyer_lgu char(4) NOT NULL,                    -- ��� ��ǰ ��з�
    buyer_bank VARCHAR2(60),                        -- ����
    buyer_bankno VARCHAR2(60),                     -- ���¹�ȣ
    buyer_bankname VARCHAR2(15),                -- ������
    buyer_zip CHAR(7),                                  -- �����ȣ
    buyer_add1 VARCHAR2(100),                       -- �ּ�1
    buyer_add2 VARCHAR2(70),                        -- �ּ�2
    buyer_comtel VARCHAR2(14) NOT NULL,       -- ��ȭ��ȣ
    buyer_fax VARCHAR2(20) NOT NULL             -- FAX��ȣ
);


-- ���̺� ���� ����
-- �÷� �߰�
ALTER TABLE buyer ADD (
    buyer_mail VARCHAR2(60) NOT NULL,
    buyer_charger VARCHAR2(20),
    buyer_telext VARCHAR2(2)
    );

-- �÷� ����
ALTER TABLE buyer MODIFY (
    buyer_name VARCHAR2(60)
    );

ALTER TABLE buyer ADD (
    CONSTRAINT pk_buyer PRIMARY KEY (buyer_id),
    CONSTRAINT fr_buyer_lprod FOREIGN KEY (buyer_lgu)
        REFERENCES lprod(lprod_gu)
);
    
    
-- �������� ���� ASC���� NULL�� ���� �ö�´�.

    