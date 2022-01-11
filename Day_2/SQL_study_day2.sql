-- 행단위로 SELECT (조건문 및 조인)--

SELECT e.* FROM emp e WHERE SAL > 4000 or SAL < 1000;

SELECT * FROM emp 
    WHERE job = 'CLERK';

SELECT * FROM emp WHERE comm IS NULL;   -- NULL값은 IS문으로만 비교 --

SELECT * FROM emp WHERE NVL(comm,1) <> 0; --"!=이랑 <>차이 없는듯? "NVL(null값 검색할 열, 치환할 값) 이렇게 하면 IS문 안써도 되긴 함--

SELECT * FROM emp e, dept d WHERE e.deptno = d.deptno;

-- 이 아래는 조인 --

SELECT * FROM emp e 
    JOIN dept d
        ON e.deptno = d.deptno;
        
SELECT DISTINCT job FROM emp;  -- DISTINCT 중복 제거 --


-- 별칭은AS 사용해주기 select 같은거 쓰고싶으면 "select"로 사용 --
SELECT ename, job, sal, sal*12+comm AS asdf             
    FROM emp ORDER BY asdf desc;
-- DESC내림차순 ASC오름차순 --

