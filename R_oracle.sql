-- ��������
CREATE USER busan IDENTIFIED BY dbdb;

alter session set "_ORACLE_SCRIPT"= true;

Drop User busan;

-- ������ ����ڿ��� ���� �ο�, ���ӱ���, ������ ���� ��� �ο�
GRANT CONNECT,RESOURCE,DBA TO busan;

-- ��������� system �������� ó�� �Ʒ��� ������� �������� ����

CREATE TABLE TEST(
        AA VARCHAR2(40) NOT NULL,
        BB VARCHAR2(40) NOT NULL,
        CC VARCHAR2(40) NOT NULL
        );







