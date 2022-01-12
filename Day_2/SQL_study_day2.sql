-- ������� SELECT (���ǹ� �� ����)--

SELECT e.* FROM emp e WHERE SAL > 4000 or SAL < 1000;

SELECT * FROM emp 
    WHERE job = 'CLERK';

SELECT * FROM emp WHERE comm IS NULL;   -- NULL���� IS�����θ� �� --

SELECT * FROM emp WHERE NVL(comm,1) != 0; --"!=�̶� <>���� ���µ�? "NVL(null�� �˻��� ��, ġȯ�� ��) �̷��� �ϸ� IS�� �Ƚᵵ �Ǳ� ��--

SELECT * FROM emp e, dept d WHERE e.deptno = d.deptno;

-- �� �Ʒ��� ���� --

SELECT * FROM emp e 
    JOIN dept d
        ON e.deptno = d.deptno;
        
SELECT DISTINCT job FROM emp;  -- DISTINCT �ߺ� ���� --


-- ��Ī��AS ������ֱ� select ������ ��������� "select"�� ��� --
SELECT ename, job, sal, sal*12+comm AS asdf             
    FROM emp
        ORDER BY asdf desc;
-- DESC�������� ASC�������� --

SELECT ename, job, sal, sal*12+comm AS asdf             
    FROM emp
        WHERE sal * 12 > 10000;     -- comm�� ���� ��ɹ� �ȿ��� ����Ұ� ���� ���ΰ� ���߿� ���;���-- 
        
SELECT ename, job, sal, sal*12+comm AS asdf             
    FROM emp
        WHERE sal IN (800, 1600 , 5000);    -- ����Ƽ find������ --
        
SELECT ename, job, sal, sal*12+comm AS asdf             
    FROM emp
        WHERE sal BETWEEN 1000 AND 4000;    -- sal <1000 AND sal > 4000 --

SELECT ename, job, sal, sal*12+comm AS asdf             
    FROM emp
        WHERE ename LIKE '%S%'                  -- LIKE ���� %�� ���ڼ� ���� ���� _�� 1���� 1���� --