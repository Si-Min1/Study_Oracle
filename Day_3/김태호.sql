-- 1. ȸ�� ���̺��� �̸���, �����, �̸�, �ּ�, ���� ���� ������ ����ϰ�, �̸��� ������������, �̸����� �ҹ��ڷ� ����ϼ��� .--
SELECT LOWER(email), mobile, names, addr, levels
    FROM membertbl
        ORDER BY names DESC;
        
--2. å ���̺��� å����, ����, ������, �ݾ� ������ ����ϰ� ������ ��� ������ ������ �Ͻʽÿ�. �÷��̸��� Ȯ���ϼ���!!--
SELECT names, author, releasedate, price
    FROM bookstbl
        ORDER BY price DESC;

--3. å ���̺�� ���� ���̺��� �����Ͽ� �Ʒ��� ���� ������ �������� �����ϼ���. �Ȱ��� ���;� �մϴ�!!--
SELECT d.names �帣
        , b.names å����
        , b.author ����
        , b.releasedate ������
        , b.isbn å�ڵ��ȣ
        , b.price ����
    FROM  bookstbl b
        --JOIN divtbl d
         --   ON d.division = b.division ;
            , divtbl d
        WHERE b.division = d.division 
            ORDER BY b.idx DESC;

-- 4.ȸ�� ���̺� ������ ȫ�浿 ȸ���� �Է��ϴ� ������ �ۼ��ϼ���. �������� ���� ����ؾ� �մϴ�. * --
INSERT INTO membertbl(
    IDX
    , NAMES
    , LEVELS
    , ADDR
    , mobile
    , email
    , userid
    , password
    , lastlogindt
    , loginipaddr
    )
VALUES(
    SEQ_NOTITLE_IDX.NEXTVAL 
    , 'ȫ�浿'
    , 'A'
    , '�λ�� ���� �ʷ���'
    , '010-7989-0909'
    , 'HGD09@NAVER.COM'
    , 'HGD7989'
    , 12345
    , NULL
    , NULL
    );
COMMIT;

--5. �Ʒ��� ���� å�� ���к��� �հ�� ��� å�� �հ谡 ���� �������� �����ϼ���.--
SELECT NVL(d.names,'--�հ�--') �帣
        , SUM(b.price) �帣���հ�ݾ�
    FROM  bookstbl b
            , divtbl d
        WHERE b.division = d.division
            GROUP BY ROLLUP (d.names);


