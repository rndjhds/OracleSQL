-- 2022.01.25(ȭ)

-- ����(join)
-- : 2�� �̻��� ���̺��� �����ؼ� ������ ���ؿ��� ��

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�? 
-- ����� emp���̺�  �μ����� dept���̺�
--1.������̺�(EMP)���� SCOTT����� �μ���ȣ�� ���Ѵ�.
select deptno from emp where ename = 'SCOTT'; -- 20
--2. �μ����̺�(DEPT)���� 20�� �μ��� �μ����� ���Ѵ�.
select dname from dept where deptno = 20; -- RESEARCH

-- CROSS JOIN
-- �ΰ��� ���̺��� �����ϴ°� CROSS JOIN�̶�� �Ѵ�.
select * from dept, emp; -- 4 * 14 = 56�� ������ �˻�
select * from emp, dept; -- 14 * 4 = 56�� ������ �˻�

-- CROSS JOIN�� ����
--1. � ����(Equi Join) -- ���� ���� ���̴� Join
--2. �� ����(Non-Equi Join)
--3. ��ü����(Self Join)
--4. �ܺ�����(Outer Join)

-- 1. � ����(Equi Join)
-- : �� ���̺� ������ �÷��� �������� JOIN
select * from dept, emp where dept.deptno = emp.deptno; -- 14�� ������ �˻�

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�?
select ename, dname from dept, emp 
    where dept.deptno = emp.deptno and ename = 'SCOTT';

-- �����÷�(deptno)�� ���̺��.�����÷��� �������� ����ؾ� �Ѵ�.
-- �����÷��� �ƴ� �÷����� �տ� ���̺���� ������ �� �ִ�.
select deptno, ename, dname from dept, emp 
    where dept.deptno = emp.deptno and ename = 'SCOTT'; -- �����߻� : deptno�� �����̺��� �������� �÷��̱� ������ �����߻�

-- �ذ�
select emp.deptno, ename, dname from dept, emp 
    where dept.deptno = emp.deptno and ename = 'SCOTT';                       or    
select dept.deptno, ename, dname from dept, emp 
    where dept.deptno = emp.deptno and ename = 'SCOTT';
    
-- ���̺� ��Ī �ο��ϱ�
--1. ���̺� ���� ��Ī�� �ο��� �������ʹ� ���̺���� ����� �� ����,
-- ��Ī�� ����ؾ� �Ѵ�.
--2. ��Ī���� ��.�ҹ��� �������� �ʽ��ϴ�.
--3. ���� �÷�(deptno)�� ��Ī��.�����÷��� �������� ����ؾ� �Ѵ�. ex) D.deptno
--4. ���� �÷��� �ƴ� �÷����� �տ� ��Ī���� ������ �� �ִ�.

select D.deptno, E.ename, D.dname from dept D, emp E 
    where D.deptno = E.deptno and E.ename = 'SCOTT';

-- ��Ī���� ��ҹ��ڸ� �������� �ʴ´�.
select d.deptno, E.ename, D.dname from dept D, emp E 
    where D.deptno = E.deptno and E.ename = 'SCOTT'; 
    
-- �����߻� : ��Ī�� �ο��� ���� ���ʹ� ���̺���� ����� �� ����.  
select DEPT.deptno, E.ename, D.dname from dept D, emp E 
    where D.deptno = E.deptno and E.ename = 'SCOTT';    
   
-- �Ϲ� �÷��� �տ� ��Ī���� ������ �� �ִ�.   
select D.deptno, ename, dname from dept D, emp E 
    where D.deptno = E.deptno and ename = 'SCOTT';
    
-- 2. �� ����(Non-Equi Join)
-- : �� ���̺� ������ �÷����� �ٸ� ������ ����Ͽ� JOIN

--Q. ��� ���̺� �ִ�  �� ������� �޿��� �� ��������� ����ϴ� SQL�� �ۼ�?
-- EMP(SAL) - SALGRADE(GRADE)

select ename, sal, grade from emp, salgrade 
    where sal >= losal and sal <= hisal;
    
select ename, sal, grade from emp, salgrade
    where sal between losal and hisal;
    
select e.ename, e.sal, s.grade from emp e, salgrade s
    where e.sal between s.losal and s.hisal;
    
--3. ��ü ����(Self Join)
-- : �Ѱ��� ���̺� ������ �÷��� �÷� ������ ���踦 �̿��ؼ� ����

--Q. ��ü����(Self Join)�� �̿��ؼ� ��� ���̺��� �� ������� ������ 
-- �Ŵ���(= ���ӻ��)�� ����ϴ� SQL�� �ۼ�?
-- EMP(EMPNO) - EMP(MGR)

select employee.ename || '�� �Ŵ�����' || manager.ename
    from emp employee, emp manager 
    where employee.mgr = manager.empno; 

-- 13�� ������ �˻� ����� ��µȴ�.
-- KING ����� ���ӻ���� ���� ������ ��µ��� �ʴ´�.

--4. �ܺ� ����(Outer Join)
-- :  ���� ������ �������� �ʴ� �����͸� ������ִ� JOIN
-- 1) ���̺��� �����Ҷ� ��� ������ ���̺��� �����Ͱ� ����������, 
-- �ٸ� ���̺��� �������� �ʴ� ��쿡, �� �����Ͱ� ��µ��� �ʴ�
-- ������ �ذ��ϱ� ���ؼ� ���Ǵ� ���� ���
-- 2) ������ ������ ���� (+)�� �߰��Ѵ�.

--Q1. ���� ��ü����(Self Join)�� ���, KING����� ���ӻ���� ���� ������
-- ��µ��� �ʾҴµ�, KING ����� �ܺ������� �̿��ؼ� ��� �ϼ���?
select employee.ename || '�� �Ŵ�����' || manager.ename
    from emp employee, emp manager 
    where employee.mgr = manager.empno(+);
    
--Q2. �μ����̺�(DEPT)�� 40�� �μ��� ������ ������̺�(EMP)�� �μ���ȣ����
-- ��Ÿ���� ������, 40�� �μ��� �μ����� ����ϴ� SQL�� �ۼ�?
-- 1) DEPT - EMP ����� : 40�� �μ��� ��¾ȵ�

select ename, d.deptno, dname from dept d, emp e
    where d.deptno = e.deptno order by deptno asc;
    
-- 2) �ܺ����� : ��µ��� �ʴ� 40�� �μ��� ������ִ� ����
select ename, d.deptno, dname from dept d, emp e
    where d.deptno = e.deptno(+) order by deptno asc;

----------------------------------------------------------------------------------
-- ANSI JOIN
-- : ANSI(�̱� ǥ�� ��ȸ) ǥ�ؾȿ� ���� ������� JOIN ���

-- ANSI CROSS JOIN : �Ϲ� CROSS JOIN�� �Ȱ���.
select * from dept cross join emp; -- 4 * 14 = 56�� ������ �˻�
select * from emp cross join dept; -- 14 * 4 = 56�� ������ �˻�

-- ANSI INNER JOIN : � ���ΰ� ���� �ǹ̸� ������ �ִ� ���� ���
--Q. SCOTT����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�?
select ename, dname from emp inner join dept 
    on emp.deptno = dept.deptno where ename = 'SCOTT';
    
-- using�� �̿��ؼ� ����
select ename, dname from emp inner join dept 
    using(deptno) where ename = 'SCOTT';

-- ANSI NATURAL JOIN : � ���ΰ� ���� �ǹ̸� ������ �ִ� ���� ���
-- : DEPT�� EMP���̺� ������ ���� �÷��� ���ٴ� �ǹ̸� ������ ����
select ename, dname from emp natural join dept where ename = 'SCOTT';
    



