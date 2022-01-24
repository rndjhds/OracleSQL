-- 2022.01.24(��)

-- null �� �˻�
-- EMP ���̺� : MGR�÷�, COMM�÷�

--Q. MGR�÷��� null���� �����͸� �˻�?
select ename, job, mgr from emp where mgr = null; -- �˻��ȵ�
select ename, job, mgr from emp where mgr = ''; --�˻��ȵ�

select ename, job, mgr from emp where mgr is null;

--Q. MGR�÷��� null���� �ƴ� �����͸� �˻�?
select ename, job, mgr from emp where mgr is not null;

--Q. COMM�÷��� null���� �����͸� �˻�?
select ename, job, mgr from emp where comm = null; -- �˻��ȵ�
select ename, job, mgr from emp where comm = ''; --�˻��ȵ�
select ename, job, mgr from emp where comm is null;

--Q. COMM�÷��� null���� �ƴ� �����͸� �˻�?
select ename, job, mgr from emp where comm is not null;

--����.
-- Q1. ������̺�(EMP)���� �Ի���(HIREDATE)�� 4�ڸ� ������ ���                                
--           �ǵ��� SQL���� �ۼ��ϼ���? (ex. 1980/01/01)

-- Q2. ������̺�(EMP)���� MGR�÷���  ����  null �� �������� MGR                              
--          �÷��� ����  CEO ��  ����ϴ� SQL���� �ۼ� �ϼ���?     


     Ans1. SQL> select  to_char(hiredate,'YYYY/MM/DD') from emp;

     Ans2. SQL> select ename, nvl(to_char(mgr,'9999'), 'CEO')  -- '9999'�� �ڸ� ���߱� ���ؼ� �� ���̴�.	         	                               
                    as	 MANAGER  from emp where mgr  is  null;
-------------------------------------------------------------------------------------------
-- ���� : order by �÷��� ���Ĺ��(asc or desc)
-- ���Ĺ�� : ��������(ascending), ��������(descending)

--           ��������                               ��������
--------------------------------------------------------------
-- ���� : ���� ���ں��� ū���� ������ ����(1,2,3...)    ū���ں��� ���� ���� ������(10,9,8..)
-- ���� : ������ ����(a,b,c..)                       �������� ����(z,y,x...)
-- ��¥ : ������¥ ������ ����                        ������¥ ������ ����
-- NULL : NULL ���� ���� �������� ���                NULL ���� ���� ���� ���

-- 1. ���� ������ ����
--Q. ��� ���̺��� �޿��� �������� �������� ����
select ename, sal from emp order by sal asc;

-- ���Ĺ��(asc, desc)�� �����Ǹ�, �⺻ ���Ĺ���� ������������ ������.
select ename, sal from emp order by sal; -- ���Ĺ��(asc) ����

--Q. ��� ���̺��� �޿��� �������� �������� ���� : ū���ں��� �������� ������ ����
select ename, sal from emp order by sal desc;

-- 2. ���� ������ ����
--Q. ��� ���̺��� ������� �������� �������� ���� :  ������ ����
select ename from emp order by ename asc;
select ename from emp order by ename;   -- ���Ĺ��(asc) ����

--Q. ��� ���̺��� ������� �������� �������� ���� : ���� ���� ����
select ename from emp order by ename desc;

-- 3. ��¥ ������ ����
--Q. ��� ���̺��� �Ի����� �������� �������� ���� :  ������¥ ������ ����
select hiredate from emp order by hiredate asc;

--Q. ��� ���̺��� �Ի����� �������� �������� ���� : ������¥ ������ ����
select hiredate from emp order by hiredate desc;

-- 4. NULL ����
--  1) �������� ���� : NULL ���� ���� �������� ���
--  2) �������� ���� : NULL ���� ���� ���� ���
--Q. MGR�÷��� �������� �������� ����
select mgr from emp order by mgr asc; -- NULL ���� ���� �������� ���

--Q. MGR�÷��� �������� �������� ����
select mgr from emp order by mgr desc; -- NULL ���� ���� ���� ���

--Q. COMM�÷��� �������� �������� ����
select comm from emp order by comm asc; -- NULL ���� ���� �������� ���

--Q. COMM�÷��� �������� �������� ����
select comm from emp order by comm desc; -- NULL ���� ���� �������� ���

-- ������ �����ϱ�
-- 1. �ѹ� ���������� ������ ����� ������ �����Ͱ� ���� ��쿡�� �ѹ� �� 
-- ������ �ؾ� �Ѵ�.
-- 2. �ι�° ���� ������ �ѹ� ���������� ������ ����� ���� �����͸� �ι�° 
-- ���� ������ ����޴´�.
-- 3. ��� �Խ����� ����� ��쿡 �ַ� ����Ѵ�.

--Q. ��� ���̺��� �޿��� �������� �������� ������ �Ѵ�. �̶� ������ �޿���
-- �޴� ������� ������� �������� �������� �����ؼ� ����ϴ� SQL�� �ۼ�
select ename, sal from emp order by sal desc; -- 3000(2��), 1250(2��)

select ename, sal from emp order by sal desc, ename asc;
                                 --ù��° ���� / �ι�° ����
                                 
-- ���� ����
--Q1. ��� ���̺��� �Ի����� �������� ������������ �����Ͽ� ����ϵ�, �����ȣ
--  �����, ����, �Ի��� �÷��� ����ϴ� SQL�� �ۼ�?
select empno, ename, job, hiredate from emp order by hiredate asc;

--Q2. ��� ���̺��� �����ȣ�� �������� ������������ �����Ͽ� �����ȣ��
-- ����� �÷��� ����ϴ� SQL�� �ۼ�?
select empno, ename from emp order by empno desc;

--Q3. �μ���ȣ�� ���� ������� �����ϵ�, ������ �μ����� ����� ����� ��쿡�� 
-- �ֱٿ� �Ի��� ������� �����ȣ, �Ի���, �����, �޿������� ����ϴ�
-- SQL�� �ۼ�?
select empno, hiredate, ename, sal, deptno from emp 
    order by deptno asc, hiredate desc;  


