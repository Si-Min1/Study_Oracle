-- 주석 아래의 셀렉트 구문을 실행--
DESC bonus;

SELECT * FROM bonus; -- * = all --

SELECT ename, job, hiredate FROM emp;

SELECT DISTINCT deptno FROM emp;

SELECT DISTINCT deptno,empno FROM emp; --DISTINCT는 or 처럼 작동--

SELECT * FROM emp WHERE deptno = 30;

SELECT * FROM emp WHERE job = 'CLERK' and sal > 1000;