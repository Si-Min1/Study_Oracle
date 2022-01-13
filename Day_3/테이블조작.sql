-- CUD example --
-- 데이터 입력 (INSERT) --

INSERT INTO BONUS (ename, job, sal, comm)
VALUES('고길동', 'asdf', 1200, NULL);

COMMIT; --완전 저장--
ROLLBACK; --되돌리기--

INSERT INTO test(
    IDX
    , TITLE
    , DESCS
    , REGDATE
    )
VALUES(
    3
    , '제목1'
    , '불꽃사나이 도화가'
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
    , '제목1'
    , '불꽃사나이 도화가'
    , TO_DATE('3021-10-05' , 'yyyy-mm-dd')
    );

SELECT SEQ_TEST_IDX.CURRVAL FROM dual;  -- 현재 시퀀스 값  --
SELECT SEQ_TEST_IDX.NEXTVAL FROM dual;  -- 실행하면 다음 시퀀스로 넘어가면서 값을 리턴함 --

INSERT INTO test(
    IDX
    , TITLE
    , DESCS
    , REGDATE
    )
VALUES(
    SEQ_TEST_IDX.NEXTVAL
    , '앨랠래'
    , '불꽃 도화가'
    , SYSDATE
    );
    


-- 업데이트 --

UPDATE TEST
    SET title = '왈랄랄루'
        , descs = '내용변경됨'
    WHERE idx = 9;


-- 딜리트 DELETE --
DELETE FROM test
    WHERE idx = 8;

-- 서브 쿼리 --
SELECT 
        ROWNUM
        , su.ename   
        , job
        , sal
        , comm
    FROM (
        SELECT ename
                , job
                , sal
                , comm
            FROM emp
                ORDER BY sal DESC
                ) su --별명 가능--
        WHERE ROWNUM = 1; 
