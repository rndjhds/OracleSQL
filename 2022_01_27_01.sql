-- 2022.01.27(��)

-- Ʈ�����(Transaction)
--1. ������ �۾�����
--2. �������� �ϰ����� ���� �ϸ鼭, �����͸� ���������� �����ϱ� ���ؼ� ����Ѵ�.

-- TCL(Transaction Control Language)
-- commit : Ʈ������� ����
-- rollback : Ʈ������� ���
-- savepoint : ������ ����(������)�� �����ϴ� ����

--[�ǽ�]
drop table dept01 purge;
create table dept01 as select * from dept;  -- ���纻 ���̺� ���� (�� ���������� ���簡 �ȵȴ�)
select * from dept01;

-- rollback : Ʈ������� ���(������ ����)
delete from dept01;
rollback;

-- commit : Ʈ������� ����
delete from dept01 where deptno = 20;
commit; -- Ʈ����� ����
rollback; -- Ʈ������� ���� �Ǿ��� ������ ������ 20�� �����ʹ� �������� ���Ѵ�.
delete from dept01; -- �����ϰ� rollback�ϸ� ������ Ŀ������ ���ư���.
insert into dept01 values(50, 'development','seoul'); -- �߰��ϰ� rollback�ϸ� ������ Ŀ������ ���ư���.

-- �ڵ� Ŀ�� : �ڵ����� Ŀ���� ����
-- 1) �������� ���� : quit, exit, con.close()
-- 2) DDL(create, alter, rename, drop, truncate), DCL(grant,revoke)
--    ����� ����

--��1. DDL ��� ����(create)
select * from dept01; -- 10,30,40
delete from dept01 where deptno = 40; -- ���ο� �ŷ����� : 40�� ������ ����

create table dept03 as select * from dept; -- �ڵ� Ŀ�� ����(DDL)

rollback; -- DDL�������� ������ 40�� �����͸� �������� ���Ѵ�.

--��2.  DDL ��� ����(truncate)
--      DDL(truncate) : ������ ������ �� ����. �ڵ����� Ŀ���� �Ǳ� �����̴�.
--      DML(delete) : ������ ���� ����

select * from dept01; -- 10,30

delete from dept01 where deptno = 30; -- DML(delete)
rollback; -- ������ 30�� �����͸� �����Ѵ�.

truncate table dept01; -- �ڵ� Ŀ�� ����(DDL)
rollback; -- ������ dept01 ���̺��� �����͸� �������� ���Ѵ�.

-- �ڵ� �ѹ� : �ڵ����� �ѹ��� ����Ǵ°�
-- : ���������� ���� : ������ â�� �ݴ� ���, ��ǻ�Ͱ� �ٿ�Ǵ� ���

-- savepoint : �ӽ� �������� �����Ҷ� ����ϴ� ���

--[�ǽ�]
drop table dept01 purge;
--1. dept01 ���̺� ����
create table dept01 as select * from dept;
select * from dept01;

--2. 40�� �μ� ����
delete from dept01 where deptno = 40;

--3. commit ���� : Ʈ����� ����
commit;

--4. 30�� �μ� ����
delete from dept01 where deptno = 30;

--5. c1 ������ ����
savepoint c1;

--6. 20�� �μ� ����
delete from dept01 where deptno = 20;

--7. c2 ������ ����
savepoint c2;

--8. 10�� �μ� ����
delete from dept01 where deptno = 10;

--9. c2 ���������� ����
rollback to c2; -- 10�� �μ� ������
select * from dept01;

--10. c1�� ���������� ����
rollback to c1; -- 10, 20�� �μ� ������
select * from dept01;

--11. ���� Ʈ����� ���� ���ĸ� ����
rollback;   -- 10, 20, 30�� �μ� ������
select * from dept01;

---------------------------------------------------------------------------
-- ���Ἲ ��������
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���ؼ� ���̺��� ������ �� 
-- : �� �÷��� ���ؼ� �����ϴ� �������� ��Ģ�� ���Ѵ�.
-- ex) not null, unique, primary key(�⺻Ű), foreign key(�ܷ�Ű),
--     check, default etc

--1. not null ��������
-- : null ���� ������� �ʴ´�.
-- �ݵ�� ���� �Է� �ؾ� �Ѵ�.

--[�ǽ�]
drop table emp02 purge;
select * from tab;

create table emp02(
    empno number(4) not null,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2));
    
select * from emp02;
desc emp02;

-- �������ǿ� ������� �ʴ� ������ �Է�
insert into emp02 values(1111, 'ȫ�浿', 'MANAGER', 30);

-- ��������(NOT NULL)�� ����Ǳ� ������ ������ �Էµ��� �ʴ´�.
-- empno�� ename�� NOT NULL�̱� ������ NULL�� �ԷµǸ� �ȵȴ�.
insert into emp02 values(NULL, NULL, 'SALESMAN', 30); 
insert into emp02(job, deptno) values('SALESMAN', 30);



--2. unique ��������
-- : ������ ���� �Է��� �� �ִ�.
-- : �ߺ��� ���� �Է��� �� ����
-- : null ���� �Է��� �� �ִ�.

drop table emp03 purge;

create table emp03(
    empno number(4) unique,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2));
    
select * from tab;
select * from emp03;

-- �������� ������ �Է�
insert into emp03 values(1111, 'ȫ�浿', '������', 10);

-- unique �������ǿ� ���� 
insert into emp03 values(1111, 'ȫ�浿', '������', 10);
-- empno�� unique�� ���� �Ǿ��� ������ ���� �߻�

-- NULL ���� �Է� ������
insert into emp03 values(NULL, 'ȫ�浿', '������', 20);
insert into emp03 values(NULL, '��ȭ��', '������', 20);

--3. primary key (�⺻Ű)
--   primary key = not null + unique
--   �ݵ�� �ߺ����� �ʴ� ���� �Է� �ؾߵȴ�.
--   ex) �μ����̺�(DEPT) - deptno(pk)
--       ������̺�(EMP) - empno (pk)

--      �Խ���(board) - ��ȣ(no) primary key
--      ȸ������(member) - ���̵�(id) pk

select * from dept;
insert into dept values(10, '���ߺ�', '����'); -- unique �������� ����
insert into dept values(NULL, '���ߺ�', '����'); -- NOT NULL �������� ����
-- DEPT ���̺��� DEPTNO �÷��� primary key ���������� �����Ǿ� �ֱ� ������
-- �ߺ��� ���� NULL���� �Է��� �� ����.

select * from emp;
insert into emp(empno, ename) values(7788, 'ȫ�浿'); -- unique �������� ����
insert into emp(empno, ename) values(NULL, 'ȫ�浿'); -- NOT NULL �������� ����

drop table emp05 purge;
create table emp05(
    empno number(4) primary key,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2));
    
select * from emp05;
desc emp05;
insert into emp05 values(1111, 'ȫ�浿', '������', 20); -- �������� ������ �Է�
insert into emp05 values(1111, 'ȫ�浿', '������', 20); -- unique �������� ����
insert into emp05 values(NULL, 'ȫ�浿', '������', 20); -- NOT NULL �������� ����

-- �������� �̸�(constraint_name)�� �����ؼ� ���̺� ���� 
-- �������� �̸��� �����ϴ� ���� : ���̺��� ���������� �����ϱ� ���ؼ� �������ش�.
-- �̸����� : ���̺��_�÷���_�������Ǿ�� (������� �̸� ���� ��Ģ)
drop table emp04 purge;
CREATE TABLE EMP04( 
EMPNO NUMBER(4) CONSTRAINT EMP04_EMPNO_UK UNIQUE, 
ENAME VARCHAR2(10) CONSTRAINT EMP04_ENAME_NN NOT NULL, 
JOB VARCHAR2(9),
DEPTNO NUMBER(2)
);

select * from emp04;

-- �������� Ȯ���ϱ�
desc user_constraints;
select * from user_constraints;


create sequence seq
    start with 1
    increment by 1
    maxvalue 100000
    nocycle;