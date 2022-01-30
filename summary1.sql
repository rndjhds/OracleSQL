-- summary(2022_01_20 ~ 2022_01_24)

--  ���̺� ��� �˻�
-- ���� : select * from tab
select * from tab; -- ������ ������ �ִ� ���̺��̸�, Ÿ�Ե��� ������ش�

-- ���̺� ����
-- ���� : desc ���̺�� or describe ���̺��
desc dept;  -- ���̺��� �÷��� �÷���Ÿ���� ����Ѵ�.
describe dept;   -- ���̺��� �÷��� �÷���Ÿ���� ����Ѵ�.

-- ���̺��� ������ �˻�
-- ���� : select �÷��� from ���̺��
select * from dept; -- ���̺��� �Էµ� ������ ���
------------------------------------------------------------------------
-- tab�� sys������ ���ԵǾ������� ���Ǿ��̱� ������ sys.tab�̶�� �ᵵ�ǰ� �Ƚᵵ �ȴ�.
-- SQL���� ��.�ҹ��� ������ ���� �ʴ´�. ������ ���������� ����� ���� ��.�ҹ��� ������ ����� �Ѵ�.

-- ����Ŭ�� ������ Ÿ��
-- 1. ���� ������
-- number(n) : ���� n�ڸ����� ������ �� �ִ�.
-- number(n1, n2) : n1�� ��ü �ڸ���
--                : n2�� �Ҽ����� �Ҵ�� �ڸ���

-- 2. ���� ������
-- char() : ���� ���� ������ : �ִ� ���̴� 2000Byte���� ���� �����ϴ�.
-- char()�� ������ �����Ͱ� �۾Ƶ� ������ Byte�� ���̷� �����Ѵ�.
-- varchar2() : ���� ���� ������ : �ִ� ���� 4000Byte���� ���� �����ϴ�.
-- varchar2() : ������ Byte���� ������ �����Ͱ� ������ �������� ���̸�ŭ�� Byte�� �����Ѵ�.
-- long : �ִ� 2GB���� ���� �����ϴ�. ������ long������ ������ �÷��� �˻������ �������� ���Ѵ�.

-- 3. ��¥ ������
-- date : ��/��/�� ������ �����Ѵ�.
-- timestamp : ��/��/�� ��:��:��:��/1000 ������ �����Ѵ�.

-- select SQL�� 
select * from dept; -- dept�� ����� ������ ���

select loc, deptno, dname from dept; -- loc, deptno, dname ������ ����Ѵ�.

-- ��� ������ : +,-,*,/
select sal + comm from emp;
-- null���� ����� �Ǵ� ������ comm�� null�� �ִµ� null�� ��������� �� �� ���� �����̴�.
select sal - 100 from emp;
select sal * 100 from emp;
select sal / 100 from emp;

-- NULL
-- 1. �������� ���� ���� �ǹ�
-- 2. NULL ���� ��������� �� �� ����.

--Q. ������̺�(EMP)�� �Ҽӵ� ������� ������ ���غ���?
-- ���� = �޿�(SAL)* 12 + Ŀ�̼�(COMM)
select sal, sal * 12 + comm from emp; -- comm�� null�� �ֱ⶧���� ��������� �� �� ����.
-- �ذ���
-- NVL(�÷�, ��ȯ�� ��) : NULL���� �ٸ� ������ ��ȯ ���ִ� �Լ�
select sal, comm, sal*12+nvl(comm,0) from emp; -- comm�� null���� 0���� ��ȯ

-- ��Ī �ο��ϱ� : as "��Ī��"
select ename, sal*12+nvl(comm,0) as "Annsal" from emp; -- �⺻ ����
select ename, sal*12+nvl(comm,0) "Annsal" from emp; -- as ��������
select ename, sal*12+nvl(comm,0) as Annsal from emp; -- "" ��������
select ename, sal*12+nvl(comm,0) Annsal from emp; -- as, "" �Ѵ� ��������

-- ��Ī�� ���Ⱑ ���� ��쿡�� �ֵ���ǥ�� ������ �� ����.
select ename, sal*12+nvl(comm,0) Ann sal from emp;  -- ����� �����߻�
select ename, sal*12+nvl(comm,0) "Ann sal" from emp; 
select ename, sal*12+nvl(comm,0) "����" from emp; -- �ѱ� �Է� ����

-- Concatenation ������ : ||
-- : �÷��� ���ڿ��� ������ �� ���
select ename, ' is a ', job from emp; -- ������ �÷����� �ν��ؼ� 3���� �÷����� ���
select ename || ' is a ' || job from emp; -- �÷��� ���ڿ��� �����ؼ� �ϳ��� �÷����� ��µǼ� ���´�.

-- distinct : �ߺ����� �����ϰ� 1���� ���
select deptno from emp; -- �ߺ����� ������ ���
select distinct deptno from emp; -- �ߺ����� �����ϰ� 10, 20, 30 �ѹ��� ���

--Q. EMP���̺��� �� ������� JOB�� 1���� ����ϴ� SQL�� �ۼ��ϼ���?
select job from emp; -- �ߺ��� ������ ���
select distinct job from emp; -- �ߺ��� �����ϰ� �� ������ 1���� ���

--EMP���̺��� �� ������ �� ���ϱ�?
-- count(�÷���) : ������ ���� ���ϱ�
select count(*) from emp; -- 14��� : emp���̺��� �� 14���� �����͸� ������ �ִ�.
select count(*) from dept; -- 4��� : dept���̺��� �� 4���� �����͸� ������ �ִ�.
select count(job) from emp; -- 14���

--Q. ������̺�(EMP)���� �ߺ��� ������ JOB�� ������ ����ϴ� SQL�� �ۼ��ϼ���?
select count(distinct job) from emp; -- 5 ���
-------------------------------------------------------------------------
-- where ������ : �� ������(=, >, >=, <, <=, !=, ^=, <> )

-- 1. ���� ������ �˻�
-- Q. ������̺��� �޿��� 3000�̻� �޴� ����� �˻��ϴ� SQL�� �ۼ��ϼ���?
select * from emp where sal >= 3000;

--Q. �޿��� 3000�� ����� �˻��ϴ� SQL�� �ۼ��ϼ���?
select * from emp where sal = 3000;

--Q. �޿��� 3000�� �ƴ� ����� �˻��ϴ� SQL�� �ۼ��ϼ���?
select * from emp where sal != 3000;
select * from emp where sal ^= 3000;
select * from emp where sal <> 3000;

--Q. �޿��� 1500������ ����� �����ȣ, �����, �޿��� ����ϴ� SQL�� �ۼ��ϼ���?
select empno, ename, sal from emp where sal <= 1500;

-- 2. ���� ������ �˻�
--  1) ���� �����ʹ� ��.�ҹ��ڸ� �����Ѵ�!!!!!
--  2) ���� �����͸� �˻� �Ҷ��� ���ڿ� ��.�쿡 �ܵ���ǥ(')�� �ٿ����Ѵ�.
-- �ֵ���ǥ�� ���ϋ��� ��Ī �ο��� ���� ����.

--Q. ������̺��� ������� FORD�� ����� ������ �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename = 'FORD';

--Q. SCOTT����� �����ȣ, �����, �޿��� ����ϴ� SQL�� �ۼ�?
select empno, ename, sal from emp where ename = 'SCOTT';

--3. ��¥ ������ �˻�
-- 1) ��¥ �����͸� �˻��� �� ��¥, ��.�쿡 �ܵ���ǥ(')�� �ٿ��� �Ѵ�.
-- 2) ��¥ �����͸� ���� �� �� �����ڸ� ����Ѵ�.

--Q. 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where hiredate >= '82/01/01';
select * from emp where hiredate >= '1982/01/01';
select * from emp where hiredate >= '82/01/01' order by hiredate asc; -- �Ի����� �������� ����

----------------------------------------------------------------------------------
-- �� ������ : and, or, not

--1. and ������ : �� ���ǽ��� ��� �����ϴ� �����͸� �˻�
--Q. ������̺��� �μ���ȣ�� 10���̰�, JOB�� MANAGER�� ����� �˻��ϴ� SQL�� �ۼ�
select * from emp where deptno = 10 and job = 'MANAGER';

--2. or ������ : �� ���ǽ� �߿��� �Ѱ����� �����ص� �˻�
--Q. ������̺��� �μ���ȣ�� 10�� �̰ų�, JOB�� MANAGER�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where deptno = 10 or job = 'MANAGER';

--3. not ������ : ������ �ݴ�� �ٲ��ִ� ����
--Q. �μ���ȣ�� 10���� �ƴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where not deptno = 10; -- �� ������
select * from emp where deptno != 10; -- �� ������
select * from emp where deptno ^= 10; -- �� ������
select * from emp where deptno <> 10; -- �� ������

-- between and ������
-- : where �÷��� between ������ and ū��

--Q. �޿��� 2000���� 3000������ �޿��� �޴� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal >= 2000 and sal <= 3000;
select * from emp where sal between 2000 and 3000;

--Q. �޿��� 2000�̸��̰ų� 3000�ʰ��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal < 2000 or sal > 3000;
select * from emp where sal not between 2000 and 3000;

--Q. 1987�⵵�� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where hiredate >= '87/01/01' and hiredate <= '87/12/31';
select * from emp where hiredate between '87/01/01' and '87/12/31';
select * from emp where substr(hiredate,1,2) = '87';

-- in ������
-- : where �÷��� in(������1, ������2, ������3....)
--Q. Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where comm = 300 or comm = 500 or comm = 1400;
select * from emp where comm in(300, 500, 1400);

--Q. �����ȣ�� 7521�̰ų� 7654�̰ų� 7844�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where empno = 7521 or empno = 7654 or empno = 7844;
select * from emp where empno in(7521, 7654, 7844);
------------------------------------------------------------------------

-- like �����ڿ� ���ϵ� ī�� : �˻������ �����Ҷ� �����.
-- : where �÷��� like pattern

-- ���ϵ� ī��
-- 1. % : ���ڰ� ���ų�, �ϳ��̻��� ���ڿ� � ���� �͵� �������.
-- 2. _ : �ϳ��� ���ڿ� � ���� �͵� �������.

--Q. ������̺��� ������� �빮�� F�� �����ϴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like 'F%';

--Q. ������̺��� ������� N���� ������ ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '%N';

--Q. ������̺��� ������� A�� �����ϴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '%A%'; -- ���� ���� ���� ����

-- ����(_) ���ϵ� ī��
-- : �ϳ��� ���ڿ� ����� �͵� �������.
--Q. ��� �̸��� �ι��� ���ڰ� A�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '_A%';

--Q. ��� �̸��� ����° ���ڰ� A�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '__A%';

--Q. ��� �̸��� ������ 2��° ���ڰ� E�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '%E_';

-- not like ������
--Q. ����� A�� ���ԵǾ� ���� �ʴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename not like '%A%';
---------------------------------------------------------------------
--null �� �˻�
-- EMP ���̺� : MGR�÷�, COMM�÷�
-- ���� : where ������ �÷��� is null;

--Q. MGR�÷��� null���� �����͸� �˻��ϴ� SQL�� �ۼ�?
select * from emp where mgr is null;
--Q. MGR�÷��� null���� �ƴ� �����͸� �˻��ϴ� SQL�� �ۼ�? 
select * from emp where mgr is not null; -- not������ Ȱ��

--Q. COMM�÷��� null���� �����͸� �˻�
select * from emp where comm is null;

--Q. COMM�÷��� null���� �ƴ� �����͸� �˻�?
select * from emp where comm is not null;
-------------------------------------------------------------------------
-- ���� : order by �÷��� ���Ĺ��(asc, desc)
-- ���Ĺ�� : ��������(ascending), ��������(descending)

--                 ��������                     ��������
------------------------------------------------------
-- ���� : ���� ���ں��� ū���� ������ ����          ū���ں��� ���� ���� ������ ����
-- ���� : ������ ����                           ���� ���� ����
-- ��¥ : ������¥������ ����                     ������¥ ������ ����
-- NULL : NULL ���� ���� �������� ���            NULL���� ���� ���� ���

--1. ���� ������ ����
--Q. ��� ���̺��� �޿��� �������� �������� ����
select * from emp order by sal asc;

-- ���Ĺ���� �����Ǹ�, �⺻ ���Ĺ���� ������������ ������.
select * from emp order by sal; -- ���Ĺ��(asc)����

--Q. ������̺��� �޿��� �������� �������� ���� : ū���ں��� ���� ���ڼ����� ����
select * from emp order by sal desc;

--2. ���� ������ ����
--Q. ��� ���̺��� ������� �������� �������� ���� : ������ ����
select * from emp order by ename asc;
select * from emp order by ename;

--Q. ��� ���̺��� ������� �������� �������� ���� : ���� ���� ����
select * from emp order by ename desc;

--3. ��¥ ������ ����
--Q. ��� ���̺��� �Ի����� �������� �������� ���� : ������¥ ������ ����
select * from emp order by hiredate asc;

--Q. ��� ���̺��� �Ի����� �������� �������� ���� : ���� ��¥������ ����
select * from emp order by hiredate desc;

--4. NULL ����
-- 1) �������� ���� : NULL���� ���� �������� ���
-- 2) �������� ���� : NULL���� ���� ���� ���
--Q. MGR�÷��� �������� �������� ����
select * from emp order by mgr asc; -- NULL���� ���� �������� ���

--Q. MGR�÷��� �������� �������� ����
select * from emp order by mgr desc; -- NULL���� ���� ���� ���

--������ �����ϱ�
-- 1. �ѹ� �������� �� ������ ����� ������ �����Ͱ� ���� ��쿡�� �ѹ� �� ������ �ؾ� �Ѵ�.
-- 2. �ι�° ���� ������ �ѹ� ���������� ������ ����� ���� �����͸� �ι�° ���� ������ ����޴´�.
-- 3. ��� �Խ����� ����� ��쿡 �ַ� ����Ѵ�.
-- ���� : order by �÷���1 ���Ĺ��1, �÷���2 ���Ĺ��2

--Q. ��� ���̺��� �޿��� �������� �������� ������ �Ѵ�. �̋� ������ �޿��� �޴� ������� �������
-- �������� �������� �����ؼ� ����ϴ� SQL�� �ۼ�?
select * from emp order by sal desc, ename asc;
                        -- ù��° ����, �ι�° ����
                        
-- ���Ĺ���
--Q1. ��� ���̺��� �Ի����� �������� ������������ �����Ͽ� ����ϵ�, �����ȣ, �����, ����
-- �Ի��� �÷��� ����ϴ� SQL�� �ۼ�?
select empno, ename, job, hiredate from emp order by hiredate asc;

--Q2. ��� ���̺��� �����ȣ�� �������� ������������ �����Ͽ�, �����ȣ�� ����� �÷��� ����ϴ�
-- SQL�� �ۼ�?
select empno, ename from emp order by empno desc;

--Q3. �μ���ȣ�� ���� ������� ����ϵ�, ������ �μ����� ����� ����� ��쿡�� �ֱٿ� �Ի��� �������
-- �����ȣ, �Ի���, �����, �޿������� ����ϴ� SQL�� �ۼ�?
select empno, hiredate, ename, sal from emp order by deptno asc, hiredate desc;
-------------------------------------------------------------------------------------
-- dual ���̺�
-- 1. sys���� ������ ���̺��̰� �������Ǿ�� �����Ǿ� ����
-- 2. dual ���̺��� ������ �Ǿ��ֱ� ������ ������ ��� �����ϴ�.
-- 3. dual ���̺��� �����Ͱ� 1�� �ۿ� ���� ������, ���� ����� 1���� ����Ѵ�.

select 10+20 from dual; -- 1�� ���
select 10+20 from sys.dual; -- ���������ڸ�.dual�� ����ؾ������� �������Ǿ�� �����Ǿ� �־ 
                            -- dual�� �ᵵ ��� ����
--dual ���̺� ����
desc dual;  -- dummy �÷� 1�� ����
select * from dual; -- x������ 1�� ����
select * from tab;  -- tab�� �������Ǿ�

-- SQL�� �Լ� : �Լ����� ��.�ҹ��ڸ� �������� �ʴ´�.
-- 1. ���� �Լ�
-- abs() : ���밪�� �����ִ� �Լ�
select -10, abs(-10), abs(-20) from dual;

-- floor() : �Ҽ��� ���ϸ� ������ ���� �Լ�
select 34.5678, floor(34.5678) from dual;

-- round() : Ư�� �ڸ����� �ݿø��� �ϴ� ����
-- round(���, �ڸ���) : �ڸ����� �������� ���� �� �Ҽ� ù��° �ڸ����� �ݿø����ش�.
--                      �ڸ��������� �ڸ������� ���                    
select 34.5678, round(34.5678) from dual; -- 35��� : �ڸ����� ���������� �ʾƼ� �Ҽ� ù��° �ڸ����� �ݿø�����
select round(34.5678, 2) from dual; -- 34.57 ��� : �ڸ����� 2�� �����ؼ� ������ �ι�° �ڸ����� ���
                                    -- �Ҽ��� 3��° �ڸ����� �ݿø�
select round(34.5678, -1) from dual; -- 30��� : �ڸ����� ������ ������ ��Ÿ����, �Ҽ��� �� 1�� �ڸ��� -1�� ��Ÿ����. 
select round(35.5678, -1) from dual; -- 40��� : �ڸ����� -1�̱� ������ �����ڸ����� �ݿø��ϰ� ���� �ڸ����� ���

-- trunc() : Ư�� �ڸ����� �߶󳻴� ���� : ������ �ڸ������� ����
-- trunc(���, �ڸ���) : �ڸ����� �������� ���� �� �Ҽ� ù��° �ڸ����� �߶󳽴�.
--                      �ڸ��� ������ ������ �ڸ������� ���
select trunc(34.5678), trunc(34.5678, 2), trunc(34.5678, -1) from dual;
--            34���           34.56���            30���

-- mod() : �������� �����ִ� �Լ�
-- mod(���,��) : ��� / �� ���� ����
select mod(27, 2), mod(27, 5), mod(27, 7) from dual;
--          1���         2���     6���

--Q. ������̺��� �����ȣ�� Ȧ���� ������� �˻��ϴ� SQL�� �ۼ�?
select * from emp where mod(empno, 2) = 1;
select * from emp where mod(empno, 2) != 0;
--------------------------------------------------------------------------------
-- 2. ���� ó�� �Լ�

-- upper() : �빮�ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oracle', upper('Welcome to Oracle') from dual;

-- lower() : �ҹ��ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oracle', lower('Welcome to Oracle') from dual;

-- initcap() : �� �ܾ��� ù���ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oracle', initcap('Welcome to Oracle') from dual;

--Q. ��� ���̺��� job�� MANAGER�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where job = 'MANAGER';
select * from emp where job = upper('manager');
select * from emp where lower(job) = 'manager';

-- lengh() : ���ڿ��� ���̸� �����ִ� �Լ�(���ڼ�)
select length('oracle'), length('����Ŭ') from dual;   -- 6���, 3���

-- lengthb() : ���ڿ��� ���̸� ����Ʈ�� �����ִ� �Լ�(����Ŭ ������ ���� �ѱ��� Byteũ�Ⱑ �ٸ���.)
-- ���� 1���� : 1Byte, �ѱ� 1���� : 3Byte 
select lengthb('oracle'), lengthb('����Ŭ') from dual; -- 6���, 9���

-- substr() : ���ڿ��� �Ϻθ� �����ϴ� �Լ��̸鼭 ����ó�� �Լ�
-- ���� : substr(��� ���ڿ�, ������ġ, ������ ���� ����)
-- ���ǻ��� : ������ġ��ȣ�� ���ʱ������� 1�� ���� �����Ѵ�.
select substr('Welcome to Oracle', 4, 3) from dual; -- com���� 4������ 3�� ����
select substr('Welcome to Oracle', -4, 3) from dual; -- acl���� 
-- ������ġ�� ������ ��� ������ �������� -1���� ����

--Q. ��� ���̺��� �Ի����� ��,��,���� �����ؼ� ����ϴ� SQL�� �ۼ�?
select substr(hiredate,1,2) �� , substr(hiredate,4,2) ��, substr(hiredate,7,2) �� from emp;

--Q. ������̺��� ������� E�� ������ ����� �˻��ϴ� SQL�� �ۼ�(2���� ���)
select * from emp where substr(ename, -1,1) = 'E';
select * from emp where ename like '%E';

--instr() : Ư�� ������ ��ġ�� �����ִ� �Լ�
-- instr(���, ã�� ����) : ���� ���� ������ ������ ��ġ�� ã���ش�.
-- instr(���, ã�� ����, ���� ��ġ, ���° �߰�)

--Q. ���� ���� ������ 'o'�� ��ġ�� ã���ش�.
select instr('Welcome to Oracle', 'o') from dual; -- 5���

--Q. 6�� ���Ŀ� 2��° �߰ߵ� 'o'�� ��ġ�� ã���ش�.
select instr('Welcome to oracle', 'o', 6, 2) from dual; -- 12���

--Q. ������̺��� ������� 3��° �ڸ��� R�� �Ǿ��ִ� ����� �˻��ϴ� SQL�� �ۼ�?(3���� ���)
select * from emp where ename like '__R%';
select * from emp where substr(ename,3,1) ='R';
select * from emp where instr(ename, 'R') = 3;
select * from emp where instr(ename, 'R',3,1) = 3;

--lpad() / rpad() : Ư����ȣ�� ä���ִ� ����
-- ���� : lpad(���, ���ڸ���, Ư����ȣ)
select lpad('oracle', 20, '#') from dual; -- �� 20�ڸ��� oracle���� #���� ä���� 
select rpad('oracle', 20, '#') from dual; -- �� 20�ڸ��� oracle���� #���� ä����

-- ltrim() : ���� ������ �����ϴ� �Լ�
-- rtrim() : ������ ������ �����ϴ� �Լ�
select '  Oracle  ', ltrim('  Oracle  ') from dual;
select rtrim('  Oracle  ') from dual;

-- trim() : ���ڿ� ��.���� ������ �����ϴ� �Լ�
--          ��󰪿��� Ư�� ���ڸ� �߶󳻴� �Լ� : trim(Ư������ from ���)
select trim('  Oracle  ') from dual;
select trim('a' from 'aaaaaOracleaaaaa') from dual;
----------------------------------------------------------------------------------
-- 3. ��¥ �Լ�

-- sysdate : �ý����� ��¥�� �����ִ� �Լ�
-- sysdate�� ()�� ����!!!
select sysdate from dual;

select sysdate-1 ����, sysdate ����, sysdate+1 ���� from dual;
-- sysdate�� ���ϱ�, ���Ⱑ �����ϴ�

--Q. ��� ���̺��� �� ������� ������� �ٹ��ϼ��� ���ϴ� SQL�� �ۼ�?
select ename, sysdate - hiredate �ٹ��ϼ� from emp;
select ename, round(sysdate - hiredate) �ٹ��ϼ� from emp; -- �Ҽ� 1��° �ڸ����� �ݿø�
select ename, trunc(sysdate - hiredate) �ٹ��ϼ� from emp; -- �Ҽ��� ����

-- months_between() : �� ��¥ ������ ����� ���� ���� �����ִ� �Լ�
-- ���� : months_between(date1, date2)
--Q. ��� ���̺��� �� ������� �ٹ��� ���� ���� ���ϴ� SQL�� �ۼ�?
select ename, months_between(sysdate, hiredate) �ٹ����� from emp;
select ename, round(months_between(sysdate, hiredate))�ٹ����� from emp;
select ename, trunc(months_between(sysdate, hiredate)) �ٹ����� from emp;

-- add_months() : Ư�� ��¥�� ����� ������ ��¥�� �����ִ� �Լ�
-- ���� : add_months(date1, ������)
--Q. ��� ���̺��� �� ������� �Ի��� ��¥�� 6������ ����� ���ڸ� ���ϴ� SQL�� �ۼ�?
select ename, add_months(hiredate, 6) from emp;
--Q. �԰����Ŀ� 6���� ����� ���ڸ� ���ϴ� SQL�� �ۼ�?
select add_months('21/12/21', 6) from dual;

-- next_day() : �ش� ������ ���� ����� ��¥�� �����ִ� �Լ�(�̷�) 
-- ���� : next_day(date, ����) 
--Q. ������ �������� ���� ����� ������� �������� ���ϴ� SQL�� �ۼ�?
select next_day(sysdate, '������') from dual;

-- last_day() : �ش� ���� ������ ��¥�� �����ִ� �Լ�
--Q. ��� ���̺��� �� ������� �Ի��� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select last_day(hiredate) from emp;

--Q. �̹����� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select sysdate, last_day(sysdate) from dual;
