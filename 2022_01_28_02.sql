-- 2022.01.28(��)

-- ��(view) : �⺻ ���̺��� �̿��ؼ� ������� ���� ���̺�

-- �ǽ��� ���� �⺻ ���̺� ���� : dept_copy, emp_copy

-- 2���� �⺻ ���̺� ����
create table dept_copy as select * from dept;
create table emp_copy as select * from emp;

-- �� ����
create view emp_view30
as
select empno, ename, deptno from emp_copy where deptno = 30; -- scott ������ view�� ������ ���ִ� ������ ��� �����߻�(insufficient privileges)
-- create view ���� �ο��� �����Ϸ�

-- �� Ȯ��
select * from tab;
select * from user_views;

select * from emp_view30;
desc emp_view30;

--Q. ��(EMP_VIEW30)�� insert�� �����͸� �Է� ���� ��쿡, �⺻ ���̺�(EMP_COPY)�� �����Ͱ� �Է� �ɱ��?
insert into emp_view30 values(1111, 'ȫ�浿', 30);

-- view�� �����Ͱ� �Է��� �Ǹ�, �⺻ ���̺��� �����Ͱ� �Էµȴ�.
select * from emp_view30;
select * from emp_copy;

-- �� ����
-- �ܼ��� : �ϳ��� �⺻ ���̺�� ������ ��
-- ���պ� : �������� �⺻ ���̺�� ������ ��

-- �ܼ���
--Q. �⺻ ���̺��� emp_copy�� �̿��ؼ� 20�� �μ��� �Ҽӵ� ������� ����� �̸�, 
--   �μ���ȣ, ���ӻ���� ����� ����ϱ� ���� ��(emp_view20)�� �����ϼ���?
create view emp_view20 
as 
select empno, ename, deptno, mgr from emp_copy where deptno = 20;

-- �� Ȯ��
select * from tab;
select * from user_views;
select * from emp_view20;

-- ���պ�
--Q. �� �μ���(�μ���) �ִ�޿��� �ּұ޿��� ����ϴ� �並 sal_view��� �̸����� �ۼ� �ϼ���?
create view sal_view 
as 
select dname, max(sal) MAX, min(sal) MIN from emp_copy, dept_copy
    where dept_copy.deptno = emp_copy.deptno group by dname;

-- �� Ȯ��
select * from tab;
select * from user_views;

-- �� ������ Ȯ��
select * from sal_view;

-- �� ����
--drop view ���̸�;
drop view sal_view;

-- �並 �����Ҷ� ���Ǵ� �ɼǵ�
--1. or replace �ɼ�
--  ������ �䰡 �������� ������ �並 �����ϰ�, ������ �̸��� ���� �䰡 �����ϸ� ���� ������ ���� �ϵ��� ����� �ִ� �ɼ�

select * from user_views;

--1) or replace �ɼǾ��� ������ ��(emp_view30)�� ���� : �����߻�
create view emp_view30
as
select empno, ename, deptno, sal, comm from emp_copy where deptno = 30;

--2) or replace �ɼ��� �ٿ��� ������ ��(emp_view30)�� ���� : ���� ������ ����
create or replace view emp_view30
as
select empno, ename, deptno, sal, comm from emp_copy where deptno = 30;

--3) �� Ȯ��
select * from user_views;

--2. with check option
-- : where �������� ���� ���� �������� ���ϵ��� ����� �ִ� �ɼ�
--1) with check option ������� ���� ���
create or replace view emp_view30
as
select empno, ename, deptno, sal, comm from emp_copy where deptno = 30;

--Q. emp_view30 �信�� �޿��� 1200�̻��� ������� �μ���ȣ�� 30������ 20������ ����?
select * from emp_view30;
update emp_view30 set deptno = 20 where sal >= 1200;

--2) with check option ����� ���
select * from emp_copy;
drop table emp_copy purge;
create table emp_copy as select * from emp;

create or replace view emp_view_chk30
as
select empno, ename, deptno, sal, comm from emp_copy 
    where deptno = 30 with check option; -- deptno = 30�� ���� �Ұ���
    
select * from emp_view_chk30;
select * from user_views;

--Q. emp_view_chk30 �信�� �޿��� 1200�̻��� ������� �μ���ȣ�� 30������ 20������ ����?
update emp_view_chk30 set deptno = 20 where sal >= 1200;

--3. with read only �ɼ�
-- : �並 ���ؼ� �⺻ ���̺��� � �÷��� ������ �������� ���ϵ��� ����� �ִ� �ɼ�

create or replace view view_read30 
as
select empno, ename, sal, comm, deptno from emp_copy
    where deptno = 30 with read only;
    
select * from tab;
select * from user_views;
select * from view_read30;

--Q. ������ ��(view_read30)�� ���� �غ���?
update view_read30 set sal =3000; 
-- �����߻� : with read only �ɼ� ������ ���� �ȵ�

-------------------------------------------------------------------------
-- rownum �÷�
--1. �������� ���� ������ ������ �ִ� ������ �÷��̴�.
--2. rownum ���� 1�� ���� �����Ѵ�.
--3. rownum ���� order by���� �����ϴ��� ���� �ٲ��� �ʴ´�.
--   rownum ���� �����ϱ� ���ؼ��� ���̺��� ���� �ؾߵȴ�.

select rownum, rowid, deptno, dname, loc from dept;
select rownum, ename, sal from emp;

select rownum, ename, sal from emp order by sal desc;

--Q1. ��� ���̺��� �Ի����� ���� ��� 5���� ���غ���?
--1) �Ի����� ���� ��������� ����(�Ի����� �������� �������� ����)
select empno, ename, hiredate from emp order by hiredate asc;

--2) �� ����
create or replace view hire_view
as
select empno, ename, hiredate from emp order by hiredate asc;

--3) �Ի����� ���� ��� 5�� ���
select rownum, empno, ename, hiredate from hire_view;

select rownum, empno, ename, hiredate from hire_view
    where rownum <= 5;
    
--4) �ζ��� ��(���������� ������� ��)
-- �Ի����� ���� ��� 5�� �˻�?
select rownum, ename, hiredate from (
    select * from emp order by hiredate asc)
where rownum <= 5;

-- �Ի����� 3 ~ 5��° ���� ����� �˻�?
select rnum, ename, hiredate from (
    select rownum rnum, ename, hiredate from( -- rownum �÷� ��Ī�ο�
        select * from emp order by hiredate asc))
where rnum >= 3 and rnum <= 5; 

--Q2. ��� ���̺��� �����ȣ(EMPNO)�� ���� ��� 5���� ���غ���?
--1) �����ȣ�� ���� ��������� ����
select rownum, empno, ename from emp order by empno asc;

--2) �� ����
create or replace view empno_view
as
select empno, ename from emp order by empno asc;

--3) �����ȣ�� ���� ��� 5�� ���
select rownum, empno, ename from empno_view;

select rownum, empno, ename from empno_view where rownum <= 5;

--4) �ζ��� ��
-- ��� ��ȣ�� ���� ��� 5�� �˻�?
select rownum, empno, ename from (
    select * from emp order by empno asc)
where rownum <= 5;

-- �����ȣ�� 3 ~ 5��° ���� ��� �˻�?
select rnum, empno, ename from (
    select rownum rnum, empno, ename from(
        select * from emp order by empno asc))
where rnum >= 3 and rnum <= 5;
where rnum between 3 and 5;

--Q3. ��� ���̺��� �޿��� ���� �޴� ��� 5�� �˻�?
--1) �޿��� ���� �޴� ��� ������ ���� (�޿��� �������� �������� ����)
select ename, sal from emp order by sal desc;

--2) �� ����
create or replace view sal_view 
as
select ename, sal from emp order by sal desc;

--3) �޿��� ���� �޴� ��� 5�� ���
select rownum, ename, sal from sal_view;

select rownum, ename, sal from sal_view where rownum <= 5;

--4) �ζ��� ��
-- �޿��� ���� �޴� ��� 5�� �˻�?
select rownum, ename, sal from (
    select * from emp order by sal desc)
where rownum <= 5;

-- �޿��� 3 ~ 5��° ���� �޴� ��� �˻�?
select rownum, ename, sal from (
    select * from emp order by sal desc)
where rownum between 3 and 5;   -- �˻� �ȵ�

select rownum, ename, sal from (
    select * from emp order by sal desc)
where rownum <= 5 and rownum >= 3;  -- �˻� �ȵ�

select rnum, ename, sal from (
    select rownum rnum, ename, sal from ( -- rownum �÷��� ��Ī �ο�
        select * from emp order by sal desc))
where rnum >=3 and rnum <=5;

--�÷����� �����ϰ� ó��
select rnum, ename, sal from (
    select rownum rnum, board. * from(
        select * from emp order by sal desc) board) -- ���������� ��Ī�ο�
where rnum >= 3 and rnum <= 5;  