-- CUD example --
-- ������ �Է� (INSERT) --

INSERT INTO BONUS (ename, job, sal, comm)
VALUES('��浿', 'asdf', 1200, NULL);

COMMIT; --���� ����--
ROLLBACK; --�ǵ�����--

INSERT INTO test(
    IDX
    , TITLE
    , DESCS
    , REGDATE
    )
VALUES(
    3
    , '����1'
    , '�Ҳɻ糪�� ��ȭ��'
    , SYSDATE
    );


INSERT INTO test(
    IDX
    , TITLE
    , DESCS
    , REGDATE
    )
VALUES(
    5
    , '����1'
    , '�Ҳɻ糪�� ��ȭ��'
    , TO_DATE('3021-10-05' , 'yyyy-mm-dd')
    );


SELECT SEQ_TEST_IDX.CURRVAL FROM dual;  -- ���� ������ ��  --
SELECT SEQ_TEST_IDX.NEXTVAL FROM dual;  -- �����ϸ� ���� �������� �Ѿ�鼭 ���� ������ --

INSERT INTO test(
    IDX
    , TITLE
    , DESCS
    , REGDATE
    )
VALUES(
    SEQ_TEST_IDX.NEXTVAL
    , '�ٷ���'
    , '�Ҳ� ��ȭ��'
    , SYSDATE
    );