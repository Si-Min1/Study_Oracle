-- ���ڿ��Լ� --

-- �ҹ��� -> �빮�� --
SELECT * FROM emp
    WHERE job = UPPER('analyst'); -- �빮�� -> �ҹ��ڴ� LOWER() --

SELECT UPPER('analyst') FROM dual; -- FROM dual ���� ������� �������� ������ --

SELECT  LOWER(ename) AS ename,
           LOWER(job)
    FROM emp
        WHERE comm is NOT NULL;     -- �ҹ��ڷ� ��� �ޱ� �� jobó�� �̸��� �ٲ�� ������ �������� ��Ī�� �ٽ� �ٲ������ --
        
SELECT INITCAP('analyst'), INITCAP('ANALYST') FROM dual; -- ù ���ڸ� �빮�� --

-- LENGTH --
SELECT ename,
          LENGTH(ename) as name_length
    FROM emp;                                   -- LENGTHB()�� ��� ���ڿ��� ����Ʈ ũ�⸦ �˷��ش� --


-- SUBSTR ���ڿ� �Ϻ� ���� --
SELECT SUBSTR('�ݰ��� �ҳ� �� �̸��� ���� ��ǳ�̶�� �Ѵ�.',5,1) AS ppap
    FROM dual;                                                                              -- SUBSTR("a",b,c) a�� ���ڿ� ,b�� �ڸ��� ������ ��ġ, c�� �󸶳� �ڸ�����(��� ��)--

SELECT REPLACE('JACK and JUE','J','BL') AS "Changes"
     FROM dual;                                                                            -- REPLACE("a",b,c) a�� ���ڿ� ,b�� ��ü���� ����, c�� ��ü�� ����--

SELECT 'A' || 'B' From dual;
SELECT CONCAT('A' , 'B') From dual; -- �� �Ʒ� ���� --

-- TRIM --
SELECT '     �ݰ��� �ҳ�.     ' FROM dual;   -- origin --
SELECT LTRIM('     �ݰ��� �ҳ�.     ') FROM dual;
SELECT RTRIM('     �ݰ��� �ҳ�.     ') FROM dual;
SELECT TRIM('     �ݰ��� �ҳ�.     ') FROM dual; -- ���� ����� , �� ���� ���� ������ ������ ���� --

SELECT ROUND(15.193,1) FROM dual;  -- �Ҽ��� �ݿø�       ������TRUNC --


-- SYSDATE �ý��� �ð� �� ����--
SELECT SYSDATE FROM dual;

-- �ڷ��� ���� --
SELECT TO_CHAR(99) FROM dual;
SELECT TRIM(TO_NUMBER('45')) FROM dual;
SELECT TO_DATE('2009  10  23', 'YYYY - mm - dd') FROM dual;
SELECT TO_DATE('10  10 2009', 'mm - dd - yyyy') FROM dual; -- if foreign field --
SELECT TO_DATE('10 10 09') FROM dual; -- check 09���� 9���� �Ǿ���� --

SELECT ename, hiredate, TO_CHAR(hiredate, 'yyyy - mm - dd'), TO_CHAR(sal) || ' $'
    FROM emp
        WHERE sal IS NOT NULL;  -- ��¥ ������ ���ڷ� �ѱ�� ���̰� �� ����--

-- null ó�� NVL(a,b) a�� ó���ϰ� ���� ��, b�� NULL���� b�� �ٲ� ��--
SELECT ename, job, sal, sal*12+NVL(comm,0) AS asdf, NVL(comm,0) AS comm
    FROM emp
        WHERE job IS NOT NULL
            ORDER BY asdf DESC;


-- (������) ���� �Լ� --
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

SELECT job, MAX(sal) AS �����ִ�, ROUND(AVG(sal),1) AS ���, deptno
    FROM emp
        WHERE sal IS NOT NULL
            GROUP BY job, deptno; -- �������� �������� ������ ã�ƶ� deptno���� ������ ������ �ִ�� ��� ���� --

SELECT job, MAX(sal) AS �����ִ�, ROUND(AVG(sal),1) AS ���
    FROM emp
        WHERE sal IS NOT NULL
            GROUP BY job
                HAVING AVG(sal) > 1000;               -- WHERE���� AVG���� �Լ� ���� --
                
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
                
SELECT NVL(TO_CHAR(deptno),'�� �հ�') �ٹ�ó, NVL(job, '�հ� ') ����, ROUND(AVG(sal),1) �޿����, MAX(sal) �ִ�, SUM(sal) �޿���, COUNT(*) �����
    FROM emp
        WHERE job IS NOT NULL
            GROUP BY ROLLUP (deptno, job);      -- ���� ���, �ִ�, ��, ����� --
--                ORDER BY deptno, job;
 
 SELECT ename, sal FROM emp;                 
