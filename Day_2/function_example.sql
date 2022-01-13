-- 문자열함수 --

-- 소문자 -> 대문자 --
SELECT * FROM emp
    WHERE job = UPPER('analyst'); -- 대문자 -> 소문자는 LOWER() --

SELECT UPPER('analyst') FROM dual; -- FROM dual 사용시 결과값을 가상으로 보여줌 --

SELECT  LOWER(ename) AS ename,
           LOWER(job)
    FROM emp
        WHERE comm is NOT NULL;     -- 소문자로 결과 받기 단 job처럼 이름이 바뀌어 버려서 별명으로 명칭을 다시 바꿔줘야함 --
        
SELECT INITCAP('analyst'), INITCAP('ANALYST') FROM dual; -- 첫 글자만 대문자 --

-- LENGTH --
SELECT ename,
          LENGTH(ename) as name_length
    FROM emp;                                   -- LENGTHB()의 경우 문자열의 바이트 크기를 알려준다 --


-- SUBSTR 문자열 일부 추출 --
SELECT SUBSTR('반갑다 소년 내 이름은 간지 폭풍이라고 한다.',5,1) AS ppap
    FROM dual;                                                                              -- SUBSTR("a",b,c) a는 문자열 ,b는 자르기 시작할 위치, c는 얼마나 자를건지(없어도 됨)--

SELECT REPLACE('JACK and JUE','J','BL') AS "Changes"
     FROM dual;                                                                            -- REPLACE("a",b,c) a는 문자열 ,b는 대체당할 문자, c는 대체할 문자--

SELECT 'A' || 'B' From dual;
SELECT CONCAT('A' , 'B') From dual; -- 위 아래 같음 --

-- TRIM --
SELECT '     반갑다 소년.     ' FROM dual;   -- origin --
SELECT LTRIM('     반갑다 소년.     ') FROM dual;
SELECT RTRIM('     반갑다 소년.     ') FROM dual;
SELECT TRIM('     반갑다 소년.     ') FROM dual; -- 여백 지우기 , 단 문장 사이 여백은 지우지 않음 --

SELECT ROUND(15.193,1) FROM dual;  -- 소수점 반올림       버림은TRUNC --


-- SYSDATE 시스템 시간 및 날자--
SELECT SYSDATE FROM dual;

-- 자료형 변경 --
SELECT TO_CHAR(99) FROM dual;
SELECT TRIM(TO_NUMBER('45')) FROM dual;
SELECT TO_DATE('2009  10  23', 'YYYY - mm - dd') FROM dual;
SELECT TO_DATE('10  10 2009', 'mm - dd - yyyy') FROM dual; -- if foreign field --
SELECT TO_DATE('10 10 09') FROM dual; -- check 09년이 9월이 되어버림 --

SELECT ename, hiredate, TO_CHAR(hiredate, 'yyyy - mm - dd'), TO_CHAR(sal) || ' $'
    FROM emp
        WHERE sal IS NOT NULL;  -- 날짜 정보를 문자로 넘기면 차이가 좀 생김--

-- null 처리 NVL(a,b) a는 처리하고 싶은 열, b는 NULL값을 b로 바꿀 값--
SELECT ename, job, sal, sal*12+NVL(comm,0) AS asdf, NVL(comm,0) AS comm
    FROM emp
        WHERE job IS NOT NULL
            ORDER BY asdf DESC;


-- (다중행) 집계 함수 --
SELECT sal, NVL(comm,0)
    FROM emp;

SELECT ROUND(SUM(sal)/12,2) AS salsum
    FROM emp;
SELECT SUM(comm) AS salsum
    FROM emp;
SELECT AVG(comm) AS salavg
    FROM emp;
    
SELECT MAX(sal)
    FROM emp;
SELECT MIN(sal)
    FROM emp;

SELECT job, MAX(sal) AS 월급최대, ROUND(AVG(sal),1) AS 평균, deptno
    FROM emp
        WHERE sal IS NOT NULL
            GROUP BY job, deptno; -- 직업별과 지역별로 나눠서 찾아라 deptno빼면 직업만 따져서 최대및 평균 구함 --

SELECT job, MAX(sal) AS 월급최대, ROUND(AVG(sal),1) AS 평균
    FROM emp
        WHERE sal IS NOT NULL
            GROUP BY job
                HAVING AVG(sal) > 1000;               -- WHERE에는 AVG같은 함수 못씀 --
                
SELECT deptno, job, AVG(sal)
    FROM emp
        GROUP BY deptno, job
            HAVING AVG(sal) >= 3000
                ORDER BY deptno, job;
                
SELECT e.deptno, job, SUM(sal), COUNT(*)
    FROM emp e
        WHERE job IS NOT NULL
            GROUP BY deptno, job
                ORDER BY deptno, job;       
                
SELECT NVL(TO_CHAR(deptno),'총 합계') 근무처, NVL(job, '합계 ') 직업, ROUND(AVG(sal),1) 급여평균, MAX(sal) 최대, SUM(sal) 급여합, COUNT(*) 사람수
    FROM emp
        WHERE job IS NOT NULL
            GROUP BY ROLLUP (deptno, job);      -- 모든걸 평균, 최대, 합, 사람합 --
--                ORDER BY deptno, job;
 
 SELECT ename, sal FROM emp;                 
