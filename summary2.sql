---- summary(2022_01_25 ~ 2022_01_26)

--4. ����ȯ �Լ� : to_char(), to_number(), t0_date()

-- 1. to_char() : ������, ��¥�� �����͸� ���������� ��ȯ�����ִ� �Լ��̴�.

--  1) ��¥�� �����͸� ���������� ��ȯ
--  ��¥��->������ : to_char(��¥ ������, '�������')
--Q. ���� �ý����� ��¥�� ��,��,��,��,��,��,���Ϸ� ���
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss day') from dual; -- 24�ð���
select to_char(sysdate, 'yyyy/mm/dd pm hh:mi:ss day') from dual; -- 12�ð���  ���� : pm ���� : am

--Q. ��� ���̺��� �� ������� �Ի����� ��,��,��,��,��,��,������ ����ϴ� SQL�� �ۼ�?
select ename, empno, deptno, to_char(hiredate, 'yyyy/mm/dd hh24:mi:ss day') from emp; 

--  2) ������ �����͸� ���������� ��ȯ
-- ������ -> ������  : to_char(���� ������, '���б�ȣ')
--Q. ���� 1230000�� 3�ڸ��� �ĸ��� �����ؼ� ���
select 1230000 from dual;

-- 0���� �ڸ����� �����ϸ�, �������� ���̰� 9�ڸ��� ���������� 0���� ä���.
select 1230000, to_char(1230000, '000,000,000') from dual;

-- 9�� �ڸ����� �����ϸ�, �������� ���̰� 9�ڸ��� ���� �ʾƵ� ä���� �ʴ´�.
select  1230000, to_char(1230000, '999,999,999') from dual;

--Q. ��� ���̺��� �� ������� �޿��� 3�ڸ��� �ĸ�(,)�� �����ؼ� ����ϴ� SQL�� �ۼ�?
select ename, sal, to_char(sal, '999,999,999') from emp;
select ename, sal, to_char(sal, '9,999') from emp;
select ename, sal, to_char(sal, 'L9,999') from emp; -- L�� ������ ��ȭ��ȣ�� ��Ÿ���ش�.
select ename, sal, to_char(sal, '9,999L') from emp;

--2. to_date() : ������ �����͸� ��¥������ ��ȯ �����ִ� �Լ�
-- ���� : to_date('����', '��¥ format')
--Q. 2022�� 1��1�� ���� ������� ����� �ϼ��� ���ϴ� SQL�� �ۼ�?
select sysdate - '2022/01/01' from dual; -- ���� �߻�

select sysdate - to_date('2022/01/01', 'yyyy/mm/dd') from dual;
select trunc(sysdate - to_date('2022/01/01', 'yyyy/mm/dd')) from dual;
select round(sysdate - to_date('2022/01/01', 'yyyy/mm/dd')) from dual;

--Q. 2022�� 12�� 25�� ũ������������ ���� �ϼ��� ���ϴ� SQL�� �ۼ�?
select to_date('2022/12/25', 'yyyy/mm/dd') - sysdate from dual;
select trunc(to_date('2022/12/25', 'yyyy/mm/dd') -sysdate) from dual;
select round(to_date('2022/12/25', 'yyyy/mm/dd') - sysdate) from dual;

--Q. ���� ���ᳯ¥ ���
select to_date('2022/06/08', 'yyyy/mm/dd') - sysdate from dual;
select trunc(to_date('2022/06/08', 'yyyy/mm/dd') - sysdate) from dual;
select round(to_date('2022/06/08', 'yyyy/mm/dd') - sysdate) from dual;

--3. to_number() : ������ �����͸� ���������� ��ȯ �����ִ� �Լ�
-- ���� : to_number('���� ������', '���б�ȣ')
select '20,000' - '10,000' from dual; -- �����߻� : ���ڳ����� ��������� �Ұ����ϴ�
select to_number('20,000', '99,999') - to_number('10,000', '99,999') from dual;
------------------------------------------------------------------------

-- nvl() : null���� �ٸ� ������ ��ȯ���ִ� �Լ�
-- 1. null���� �������� ���� ���� �ǹ�
-- 2. null���� �������(+,-,*,/)�� ���� �ʴ´�.

--Q. ��� ���̺� �ִ� �� ������� ������ ����ϴ� SQL�� �ۼ�?
-- ���� = �޿� * 12 + COMM
-- nvl(comm,0) : comm�� NULL���� �����͸� 0���� ��ȯ
select ename, sal * 12 + nvl(comm, 0) ���� from emp;
-----------------------------------------------------------

-- decode() : switch ~ case n ������ �����ϴ� 
-- ���� : decode(�÷���, ��1, ���1,
--                     ��2, ���2,
--                     ��3, ���3,
--                     .........)

--Q. ��� ���̺��� �μ���ȣ(deptno)�� �μ������� �ٲ㼭 ����ϴ� SQL�� �ۼ�?
select ename, deptno, decode(deptno, 10, 'ACCOUNTING',
                                     20, 'RESEARCH',
                                     30, 'SALES',
                                     40, 'OPERATIONS') as dname from emp;
------------------------------------------------------------------------------

-- case() : if ~ else if���� �����ϴ�
-- ���� : case when ����1 then ���1
--            when ����2 then ���2
--            else ���3
-- end

--Q. ��� ���̺��� �μ���ȣ(deptno)�� �μ������� �ٲ㼭 ����ϴ� SQL�� �ۼ�?
select ename, deptno, case when deptno = 10 then 'ACCOUNTING'
                           when deptno = 20 then 'RESEARCH'
                           when deptno = 30 then 'SALES'
                           when deptno = 40 then 'OPERATIONS'
                           end as dname from emp; -- dname�� ������� �÷���Ī
-- decode���� case�� �� ���� �����ڸ� �� �� �ִ�.
--------------------------------------------------------------------------------

-- �׷��Լ� : �ϳ� �̻��� ���� �׷����� ���� �����Ͽ� ����, ��� �� �ϳ��� ����� ��Ÿ����.
-- �׷��Լ� : �ϳ� �̻��� �����͸� �׷����� ��� ������ �����ϰ� �ϳ��� ����� ó�����ִ� �Լ�

-- sum() : ���� �����ִ� �Լ�
select sum(sal) from emp; -- �޿��� ��
select sum(comm) from emp; -- comm�� ��, null���� �����Ѵ�
select sum(ename) from emp;  -- �����߻�: ���ڵ����ʹ� ��������� �� �� ����.

select sum(sal), sum(comm) from emp; --�׷��Լ������� ��� �����ϴ�.
select sal, sum(sal) from emp;
-- ���� �߻� : �׷��Լ��� �ϳ��� ����� ó�������� sal�� 14���� ����� ����ϱ� ������ ������ �߻��Ѵ�.
-- �Ϲ� �÷��� �׷��Լ��� ���� ����� �� ����.

select sum(sal) from emp where deptno = 10; --8750
select sum(sal) from emp where deptno = 20; --10875
select sum(sal) from emp where deptno = 30; --9400
select sum(sal) from emp where deptno = 40; --null

-- avg() : ��հ��� �����ִ� �Լ�
select avg(sal) from emp;
select avg(sal), avg(comm) from emp;
select avg(sal), avg(comm) from emp where deptno = 10;
select avg(sal), avg(comm) from emp where deptno = 20;
select avg(sal), avg(comm) from emp where deptno = 30;

-- max() : �ִ밪�� �����ִ� �Լ�
select max(sal) from emp; -- 5000
select ename, mas(sal) from emp;
-- ���� �߻� : �׷��Լ��� �ϳ��� ����� ó�������� ename�� 14���� ����� ����ϱ� ������ ������ �߻��Ѵ�.
-- �Ϲ� �÷��� �׷��Լ��� ���� ����� �� ����.

select max(sal) from emp where deptno = 10; -- 5000
select max(sal) from emp where deptno = 20; -- 3000
select max(sal) from emp where deptno = 30; -- 2850

--Q. ��� ���̺��� ���� �ֱٿ� �Ի��� �Ի����� ����ϴ� SQL�� �ۼ�?
select max(hiredate) from emp; -- 87/07/13

--Q1. ��� ���̺�(EMP)���� ���� �ֱٿ� �Ի��� ������� ����ϴ� SQL���� �ۼ��ϼ���?
select ename, hiredate from emp where hiredate = (select max(hiredate) from emp);
--Q2. ��� ���̺�(EMP)���� �ִ� �޿��� �޴� ������ �ִ�޿� �ݾ��� ����ϴ� SQL�� �ۼ� �ϼ���?
select ename, sal from emp where sal = (select max(sal) from emp);

-- min() : �ּҰ��� �����ִ� �Լ�
select min(sal) from emp; -- 800
select min(sal) from emp where deptno = 10; -- 1300
select min(sal) from emp where deptno = 20; -- 800
select min(sal) from emp where deptno = 30; -- 950

--Q. ��� ���̺��� ���� ���� �Ի��� �Ի����� ���ϴ� SQL�� �ۼ�?
select min(hiredate) from emp; -- 80/12/17

select min(ename) from emp; -- ADAMS
select ename from emp order by ename asc; -- �������� ����(������ ����)

select max(ename) from emp; -- WARD
select ename from emp order by ename desc; -- �������� ����(�������� ����)

select sum(sal), avg(sal), max(sal), min(sal) from emp;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 10;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 20;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 30;

-- count() : �� ������ ������ �����ִ� �Լ�
select count(sal) from emp; -- 14
select count(mgr) from emp; -- 13 : null���� counting�� ���� �ʴ´�.
select count(comm) from emp; -- 4 : null���� counting�� ���� �ʴ´�.
select count(empno) from emp; -- 14 : empno�÷��� �⺻Ű ���������� �����Ǿ� �ִ�.
select count(*) from emp; -- 14

--Q. ��� ���̺��� JOB����
select count(job) from emp; -- 14 : �ߺ� �����͵� counting�Ѵ�
select job from emp;
select distinct(job) from emp; -- �ߺ����� ������ JOB���
select count(distinct(job)) from emp; -- �ߺ����� ������ JOB�� �������

--Q. ���� �ֱٿ� �Ի��� ����� �Ի��ϰ� ���� ���� �Ի��� ����� �Ի����� ���ϴ� SQL�� �ۼ�?
select max(hiredate), min(hiredate) from emp;

--Q. 30�� �μ� �Ҽ� ��� �߿��� Ŀ�̼��� �޴� ������� ���ϴ� SQL�� �ۼ�?
select count(comm) from emp where deptno = 30; -- count()�� null���� ���� �ʴ´�.
-------------------------------------------------------------------------

-- group by
-- : Ư�� �÷��� �������� ���̺� �����ϴ� �����͸� �׷����� �����Ͽ� ó�����ִ� ������ �Ѵ�.

--Q. �� �μ�(10,20,30)�� �޿��� ��, ��ձ޿�, �ִ�޿�, �ּұ޿��� ���ϴ� SQL�� �ۼ�?
select deptno, sum(sal), avg(sal), max(sal), min(sal) from emp group by deptno;
-- �׷��Լ��� �Ϲ��÷��� ���� ����� �� ������, ���������� group by ���� ���Ǵ� �÷���
-- ���������� �׷��Լ��� ���� ����� �� �ִ�.
select deptno, sum(sal), avg(sal), max(sal), min(sal) from emp 
    group by deptno order by deptno asc;

--Q. JOB�÷��� �������� �޿��� ��, ��ձ޿�, �ִ�޿�, �ּұ޿��� ���ϴ� SQL�� �ۼ�?
select job, sum(sal), avg(sal), max(sal), min(sal) from emp group by job;

--Q. �� �μ�(10,20,30)�� ������� Ŀ�̼��� �޴� ����� ���� ���ϴ� SQL�� �ۼ�?
select deptno, count(*) �����, count(comm) Ŀ�̼� from emp group by deptno;

-- having ������
-- : group by ���� ���Ǵ� ��쿡 ������ ������ ���ϱ� ���ؼ��� where������ ��ſ�
-- having �������� ����ؾ� �Ѵ�.

--Q. �� �μ��� ��ձ޿� �ݾ��� 2000�̻��� �μ��� ����ϴ� SQL�� �ۼ�?
select deptno, avg(sal) from emp group by deptno having avg(sal) >= 2000;

--Q. �� �μ��� �ִ�޿� �ݾ��� 2900 �̻��� �μ��� ����ϴ� SQL�� �ۼ�?
select deptno, max(sal) from emp group by deptno having max(sal) >= 2900;
-------------------------------------------------------------------------------------------

-- ����(join)
-- : 2�� �̻��� ���̺��� �����ؼ� ������ ���ؿ��� ��

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�?
-- ����� emp���̺� �μ����� deptno���̺�
-- 1. ��� ���̺�(EMP)���� SCOTT����� �μ���ȣ�� ���Ѵ�.
select ename, deptno from emp where ename = 'SCOTT'; -- 20�� ���
-- 2. �μ� ���̺�(DEPT)���� 20�� �μ��� �μ����� ���Ѵ�.
select dname, deptno from dept where deptno = 20; -- RESEARCH

select ename, dname, emp.deptno from emp, dept where dept.deptno = emp. deptno and ename = 'SCOTT';

-- CROSS JOIN
-- �ΰ��� ���̺��� �����ϴ°� CROSS JOIN�̶�� �Ѵ�.
select * from dept, emp; -- 4 * 14 = 56�� ������ �˻�
select * from emp, dept; -- 14 * 4 = 56�� ������ �˻�

-- CROSS JOIN�� ����
--1. � ����(Equi Join) -- ���� ���� ���̴� Join
--2. �� ����(Non-Equi-Join)
--3. ��ü ����(Self Join)
--4. �ܺ� ����(Outer join)

-- 1. � ����(Equi Join)
-- : �� ���̺� ������ �÷��� �������� JOIN
select * from dept, emp where dept.deptno = emp.deptno; -- 14�� ������ �˻�

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�?
select ename, dname from dept, emp
    where dept.deptno = emp.deptno and ename = 'SCOTT';
    
-- �����÷�(deptno)�� ���̺��.�����÷��� �������� ����ؾ� �Ѵ�.
-- �����÷��� �ƴ� �÷����� �տ� ���̺���� ������ �� �ִ�.
select deptno, ename, dname from dept,emp 
    where dept.deptno = emp.deptno and ename = 'SCOTT'; -- �����߻�
    
-- �ذ�
select emp.deptno, ename, dname from dept, emp
    where dept.deptno = emp.deptno and ename = 'SCOTT';
select dept.deptno, ename, dname from dept, emp
    where dept.deptno = emp.deptno and ename = 'SCOTT';    
    
-- ���̺� ��Ī �ο��ϱ�
--1. ���̺� ���� ��Ī�� �ο��� �������ʹ� ���̺���� ����� �� ����, ��Ī�� ����ؾ� �Ѵ�.
--2. ��Ī���� ��.�ҹ��� �������� �ʽ��ϴ�.
--3. �����÷�(deptno)�� ��Ī��.�����÷��� �������� ����ؾ� �Ѵ�. ex)D.deptno
--4. �����÷��� �ƴ� �÷����� �տ� ��Ī���� ������ �� �ִ�.

select D.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno = E.deptno and E.ename = 'SCOTT';
    
-- ��Ī���� ��ҹ��ڸ� �������� �ʴ´�.
select d.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno = E.deptno and E.ename = 'SCOTT';

-- �����߻� : ��Ī�� �ο��� �������ʹ� ���̺���� ����� �� ����.
select DEPT.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno = E.deptno and E.ename = 'SCOTT';
    
-- �Ϲ��÷��� �տ� ��Ī���� ������ �� �ִ�.
select D.deptno, ename, dname from dept D, emp E
    where D.deptno = E.deptno and E.ename = 'SCOTT';
    
-- 2. �� ����(Non-Equi Join)
-- : �� ���̺� ������ �÷����� �ٸ� ������ ����Ͽ� JOIN

--Q. ��� ���̺� �ִ� �� ������� �޿��� �� ��������� ����ϴ� SQL�� �ۼ�?
-- EMP(SAL) - SALGRADE(GRADE)

select ename, sal, grade from emp, salgrade
    where sal >= losal and sal <= hisal;
    
select ename, sal, grade from emp, salgrade
    where sal between losal and hisal;

select e.ename, e.sal, s.grade from emp e, salgrade s
    where e.sal between s.losal and s.hisal;

--3. ��ü ����(Self Join)
-- : �Ѱ��� ���̺� ������ �÷��� �÷� ������ ���踦 �̿��ؼ� ����

--Q. ��ü����(Self Join)�� �̿��ؼ� ��� ���̺��� �� ������� ������ �Ŵ���(= ���ӻ��)�� ����ϴ� 
-- SQL�� �ۼ�?
-- EMP(EMPNO) - EMP(MGR)

select employee.ename || '�� �Ŵ�����' || manager.ename
    from emp employee, emp manager
    where employee.mgr = manager.empno;

-- 13�� ������ �˻� ����� ��µȴ�.
-- KING ����� ���ӻ���� ���� ������ ��µ��� �ʴ´�.

--4. �ܺ� ����(Outer Join)
-- : ���� ������ �������� �ʴ� �����͸� ������ִ� JOIN
-- 1) ���̺��� �����Ҷ� ��� ������ ���̺��� �����Ͱ� ����������,
-- �ٸ� ���̺��� �������� �ʴ� ��쿡, �� �����Ͱ� ��µ��� �ʴ� ������ �ذ��ϱ� ���ؼ� 
-- ���Ǵ� ���� ���
-- 2) ������ ������ ���� (+)�� �߰��Ѵ�.

--Q1. ���� ��ü����(Self Join)�� ���, KING����� ���ӻ���� ���� ������ ��µ��� �ʾҴµ�
-- KING ����� �ܺ������� �̿��ؼ� ��� �ϼ���?
select employee.ename || '�� �Ŵ�����'|| manager.ename
    from emp employee, emp manager
    where employee.mgr = manager.empno(+); 
    
--Q2. �μ����̺�(DEPT)�� 40�� �μ��� ������ ������̺�(EMP)�� �μ���ȣ���� ��Ÿ���� ������, 40��
-- �μ��� �μ����� ����ϴ� SQL�� �ۼ�?
select ename, d.deptno, dname from dept d, emp e
    where d.deptno = e.deptno(+) order by deptno asc;

-------------------------------------------------------------------------------------
-- ANSI JOIN
-- : ANSI(�̱� ǥ�� ��ȸ) ǥ�ؾȿ� ���� ������� JOIN ���

-- ANSI CROSS JOIN : �Ϲ� CROSS JOIN�� �Ȱ���.
select * from dept cross join emp;  -- 4* 14 = 56�� ������ �˻�
select * from emp cross join dept;  -- 14 * 4 = 56�� ������ �˻�

-- ANSI INNER JOIN : � ���ΰ� ���� �ǹ̸� ������ �ִ� ���� ���
--Q. SCOTT����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�?
select ename, dname from emp inner join dept
    on emp.deptno = dept.deptno where ename = 'SCOTT';

-- using�� �̿��ؼ� ����
select ename, dname from emp inner join dept
    using(deptno) where ename = 'SCOTT';
    
-- ANSI MATURAL JOIN : � ���ΰ� ���� �ǹ̸� ������ �ִ� ���� ���
-- DEPT�� EMP���̺� ������ ���� �÷��� ���ٴ� �ǹ̸� ������ ����
select ename, dname from emp natural join dept where ename = 'SCOTT';

--Q1. ������ MANGER�� ����� �̸�, �μ����� ����ϴ� SQL�� �ۼ��ϼ���? (JOIN�� ����Ͽ� ó��)
select ename, dname, emp.deptno from emp, dept where emp.deptno = dept.deptno and job = 'MANAGER';
select ename, dname, emp.deptno from emp inner join dept on emp.deptno = dept.deptno where job = 'MANAGER';
select ename, dname, deptno from emp inner join dept using(deptno) where job = 'MANAGER';
select ename, dname, deptno from emp natural join dept where job = 'MANAGER';

--Q2. �Ŵ����� KING�� ������� �̸��� ������ ����ϴ� SQL�� �ۼ�?
select ename, job from emp where mgr = (select empno from emp where ename = 'KING');
select employee.ename, employee.job from emp employee, emp manager 
    where employee.mgr = manager.empno and manager.ename = 'KING'; -- Self Join
    
--Q3. SCOTT�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ����ϴ� SQL�� �ۼ�?
select ename, loc from emp, dept where emp.deptno = dept.deptno   
    and emp.deptno = (select deptno from emp where ename = 'SCOTT');

-- ANSI OUTER JOIN
-- ���� : select * from table1 [left, right, full] outer join table2;

-- 1. dept01 ���̺� ����
create table dept01(deptno number(2), dname varchar2(14));
insert into dept01 values(10, 'ACCOUTING');
insert into dept01 values(20, 'RESEARCH');
select * from dept01;

-- 2. dept02 ���̺� ����
create table dept02(deptno number(2), dname varchar2(14));
insert into dept02 values(10, 'ACCOUNTING');
insert into dept02 values(30, 'SALES');
select * from dept02;

--3. left outer join : dept01 ���̺� ������ ��µ�
select * from dept01 left outer join dept02 using(deptno);

--4. right outer join : dept02 ���̺� ������ ��µ�
select * from dept01 right outer join dept02 using(deptno);

--5. full outer join : dept01, dept02 ���̺� ��� ������ ��µ�
select * from dept01 full outer join dept02 using(deptno);

----------------------------------------------------------------------------------
-- ���� ����

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�?
select dname from dept where deptno = (select deptno from emp where ename = 'SCOTT');

-- join���� ���ϱ�
select dname from emp, dept where emp.deptno = dept.deptno and ename = 'SCOTT';
select dname from emp inner join dept on emp.deptno = dept.deptno where ename = 'SCOTT';
select dname from emp inner join dept using(deptno) where ename = 'SCOTT';
select dname from emp natural join dept where ename = 'SCOTT';

--1. ������ ��������
-- 1) ���������� �˻������ 1���� ��ȯ�Ǵ� ����
-- 2) ���������� where ���������� �񱳿����ڸ� ��밡��(=,>,>=,<,<=,!=)

--Q. ��� ���̺��� ���� �ֱٿ� �Ի��� ������� ����ϴ� SQL�� �ۼ�?
select hiredate, ename from emp where hiredate = (select max(hiredate) from emp);

--Q. ��� ���̺��� �ִ�޿��� �޴� ������ �ִ�޿� �ݾ��� ����ϴ� SQL�� �ۼ�?
select ename, sal from emp where sal = (select max(sal) from emp);

--Q. ���ӻ��(MGR)�� KING�� ����� ������ �޿��� ����ϴ� SQL�� �ۼ�?
select ename, sal from emp where mgr = (select empno from emp where ename = 'KING');

--2. ������ ��������
-- 1) ������������ ��ȯ�Ǵ� �˻������ 2�� �̻��� ��������
-- 2) ���������� where ���������� ������ ������(in,all,any..)�� ����ؾ� �Ѵ�.

-- <in������>
-- : ���������� �˻� ��� �߿��� �ϳ��� ��ġ�Ǹ� ���� �ȴ�.

--Q. �޿��� 3000�̻� �޴� ����� �Ҽӵ� �μ��� ������ �μ����� �ٹ��ϴ� ������� ������ ����ϴ� SQL�� �ۼ�?
select ename, sal, deptno from emp where deptno in (select distinct deptno from emp where sal >= 3000);

--<all ������>
-- : ���� ������ �� ������ ���������� �˻������ ��� ���� ��ġ�ϸ� ���� �ȴ�.

--Q. 30�� �μ��� �Ҽӵ� ����߿��� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ����� �̸��� �޿��� ����ϴ� 
--   SQL�� �ۼ�?
select ename, sal from emp where sal > (select max(sal) from emp where deptno = 30); 
select ename, sal from emp where sal > all(select sal from emp where deptno = 30);

--<any ������>
-- : ���������� �� ������ ���������� �˻� ����� �ϳ��̻��� ��ġ�Ǹ� ���� �ȴ�.

--Q. �μ���ȣ�� 30���� ������� �޿��� ���� ���� �޿�(950)���� ���� �޿��� �޴� ������ �޿��� ����ϴ� SQL�� �ۼ�?
select ename, sal from emp where sal > (select min(sal) from emp where deptno = 30);
select ename, sal from emp where sal > any(select sal from emp where deptno = 30);



