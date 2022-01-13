SELECT e.empno
        , e.ename
        , e.job, TO_CHAR(e.hiredate, 'yyyy - mm - dd')
        , e.deptno
        , d.dname 
    FROM emp e
    INNER JOIN dept d
        ON e.deptno = d.deptno 
            WHERE e.ename LIKE '%S%'
                ORDER BY e.deptno;
  
SELECT *
    FROM emp e, dept d
        WHERE e.deptno = d.deptno
            ORDER BY e.deptno;

SELECT *
    FROM emp e
    INNER JOIN dept d
    ON e.deptno = d.deptno
        ORDER BY e.deptno;

SELECT e.ename, e.job ,e.deptno
    FROM emp e
        WHERE e.deptno != ALL (SELECT d.deptno FROM dept d WHERE d.dname = 'SALES');
                  -- ^^ e.deptno ��� ���� ������ �ȵ��� ���� --
                                        SELECT d.deptno FROM dept d WHERE d.dname = 'SALES';



-- PLSQL INNER JOIN --
SELECT e.deptno
        , d.dname
        , e.empno
        , e.ename
        , e.job
    FROM emp e, dept d
        WHERE 1 = 1
            AND e.deptno = d.deptno  -- e.deptno (+) = d.deptno RIGHT OUTER JOIN--
                ORDER BY e.deptno;     -- e.deptno = d.deptno (+) LEFT OUTER JOIN--
        
-- LEFT OUTER JOIN --
SELECT  e.deptno
        , d.dname
        , e.empno
        , e.ename
        , e.job
        , TO_CHAR(e.hiredate, 'yyyy - mm - dd')
    FROM emp e
    LEFT OUTER JOIN dept d
        ON e.deptno = d.deptno
            ORDER BY e.deptno;       
            
-- RIGHT OUTER JOIN --
SELECT d.deptno
        , e.deptno
        , d.dname 
        , e.empno
        , e.ename
        , e.job
        , TO_CHAR(e.hiredate, 'yyyy - mm - dd')
    FROM emp e
    RIGHT OUTER JOIN dept d
        ON e.deptno = d.deptno    -- dept�� ���ؿ����� deptno�� �� �޶��ؼ� 40���� ��µ� emp�� deptno�� 40�����ؼ� �ϰ͵� �����ؼ� null�� --
            ORDER BY e.deptno;
            
 -- ���� JOIN --
SELECT e.deptno
        , d.dname
        , e.empno
        , e.ename
        , e.job
        , b.comm
    FROM emp e, dept d, bonus b
        WHERE 1 = 1
            AND e.deptno (+)= d.deptno
            AND e.ename = b.ename (+)
                ORDER BY e.deptno;         

