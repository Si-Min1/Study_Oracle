-- �ּ� �Ʒ��� ����Ʈ ������ ����--
DESC bonus;

SELECT * FROM bonus; -- * = all --

SELECT ename, job, hiredate FROM emp;

SELECT DISTINCT deptno FROM emp;

SELECT DISTINCT deptno,empno FROM emp; --DISTINCT�� or ó�� �۵�--

SELECT * FROM emp WHERE deptno = 30;

SELECT * FROM emp WHERE job = 'CLERK' and sal > 1000;