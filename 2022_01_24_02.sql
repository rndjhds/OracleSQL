-- 2022.01.24(��)

--SQL �Լ�
select * from dept;
select * from emp;
select 10+20 from dept; -- 4�� ���
select 10+20 from emp;  -- 14�� ���

-- dual ���̺�
-- 1. sys ���� ������ ���̺��̰� ���� ���Ǿ�� ���� �Ǿ� ����
-- 2. dual ���̺��� ������ �Ǿ� �ֱ� ������ ������ ��� �����ϴ�.
-- 3. dual ���̺��� �����Ͱ� 1�� �ۿ� ���� ������, ���� ����� 1���� ����Ѵ�.


select 10+20 from dual; -- 1�� ���
select 10+20 from sys.dual; -- ���������ڸ�.dual�� ����ؾ������� 
                            -- �������Ǿ� �����Ǿ��־ dual�� �ᵵ ��� ����
desc dual;              -- dummy �÷� 1�� ����
select * from dual;     -- X ������ 1�� ����

select * from sys.tab;  -- ���� ���Ǿ�
select * from tab;

-- 1. ���� �Լ�
-- abs() : ���밪�� �����ִ� �Լ�
select -10, abs(-10), abs(-20) from dual;
-- �Լ����� ��.�ҹ��ڸ� �������� �ʴ´�.

-- floor() : �Ҽ��� ���ϸ� ������ ���� �Լ�
select 34.5678, floor(34.5678) from dual;

-- round() : Ư�� �ڸ����� �ݿø��� �ϴ� ����
-- round(���, �ڸ���)  : �ڸ����� �������� ���� �� �Ҽ� ù��° �ڸ����� �ݿø����ش�.
select 34.5678, round(34.5678) from dual; -- 35��� : �Ҽ� ù��° �ڸ����� �ݿø�
select 34.5678, round(34.5678, 2) from dual; -- 34.57��� : �ڸ��� 2�� �����ؼ� �Ҽ��� �ι�° �ڸ����� ���
                                             -- �Ҽ��� 3��° �ڸ����� �ݿø�
select 34.5678, round(34.5678, -1) from dual; -- 30��� : �ڸ����� ������ ������ ��Ÿ����, �Ҽ��� �� 1�� �ڸ��� -1�� ��Ÿ����.
select 34.5678, round(35.5678, -1) from dual; -- 40��� : �ڸ����� -1�̱� ������ ���� �ڸ������� ����ϰ� �����ڸ����� �ݿø��� �Ѵ�.

-- trunc() : Ư�� �ڸ����� �߶󳻴� ���� : ������ �ڸ������� ����
select trunc(34.5678), trunc(34.5678, 2), trunc(34.5678, -1) from dual;
--           34���            34.56���        30���

-- mod() : �������� �����ִ� �Լ�
select mod(27, 2), mod(27, 5), mod(27, 7) from dual;
--         1���        2���       6���

--Q. ��� ���̺��� �����ȣ�� Ȧ���� ������� �˻��ϴ� SQL�� �ۼ�?
select * from emp where mod(empno, 2) != 0;
select * from emp where mod(empno, 2) = 1;
---------------------------------------------------------------------------------------------------------
-- 2. ���� ó�� �Լ�

-- upper() : �빮�ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oracle', upper('Welcome to Oralce') from dual;

-- lower() : �ҹ��ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oralce', lower('welcome to Oracle') from dual;

-- initcap() : �� �ܾ��� ù���ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�
select 'Welcome to Oralce', lower('welcome to Oracle') from dual;

--Q. ��� ���̺��� job�� manager�� ����� �˻��ϴ� SQL�� �ۼ�?
select empno, ename, job from emp where job = 'manager'; -- �˻��ȵ�
select empno, ename, job from emp where lower(job) = 'manager';
select empno, ename, job from emp where job = upper('manager');

-- length() : ���ڿ��� ���̸� �����ִ� �Լ�(���ڼ�)
select length('oracle'), length('����Ŭ') from dual;
--             6���              3���

-- lengthb() : ���ڿ��� ���̸� ����Ʈ�� �����ִ� �Լ�
-- ���� 1���� : 1Byte, �ѱ� 1���� : 3Byte : ����Ŭ������ ���� �ѱ��� Byteũ�Ⱑ �ٸ���.
select lengthb('oracle'), lengthb('����Ŭ') from dual;
--              6���               9���
        
-- substr() : ���ڿ��� �Ϻθ� �����ϴ� �Լ��̸鼭 ����ó�� �Լ�
-- ���� : substr(��� ���ڿ�, ������ġ, ������ ���� ����)
-- ���� ���� : ������ġ��ȣ�� ���ʱ������� 1������ �����Ѵ�.

select substr('Welcome to Oracle', 4, 3) from dual; -- com����    4������ 3������
select substr('Welcome to Oracle', -4, 3) from dual; -- acl���� 
-- ������ġ�� �����ϰ�� ������ �������� -1���� ����

--Q. ��� ���̺��� �Ի���(hiredate)�� ��, ��, ���� �����ؼ� ����ϴ� SQL�� �ۼ�?
select substr(hiredate, 1,2) as "��",
       substr(hiredate, 4,2) as "��",
       substr(hiredate, 7,2) as "��" from emp;
       
--Q. ��� ���̺��� 87�⵵�� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where substr(hiredate,1,2) = '87'; -- ����ó���Լ��̱� ������ �ܵ���ǥ�� �����ش�.

--Q. ��� ���̺��� ������� E�� ������ ����� �˻��ϴ� SQL�� �ۼ�(2���� ���)
select * from emp where ename like '%E';
select * from emp where substr(ename, -1,1) = 'E';

-- instr() : Ư�� ������ ��ġ�� �����ִ� �Լ�
-- instr(���, ã�� ����) : ���� ���� ������ ������ ��ġ�� ã���ش�.
-- instr(���, ã�� ����, ���� ��ġ, ���° �߰�)

--Q ���� ���� ������ 'o'�� ��ġ�� ã���ش�.
select instr('Welcome to oracle', 'o') from dual;   -- 5���

--Q. 6�� ���Ŀ� 2��° �߰ߵ� 'o'�� ��ġ�� ã���ش�.
select instr('Welcome to oracle', 'o', 6, 2) from dual; -- 12���

--Q. ��� ���̺��� ������� 3��° �ڸ��� R�� �Ǿ��ִ� ����� �˻��ϴ� SQL�� �ۼ�?(3���� ���)
-- 3���� ��� : like������, substr(), instr()
select * from emp where ename like '__R%';
select * from emp where substr(ename, 3,1) = 'R';
select * from emp where instr(ename, 'R') = 3;
select * from emp where instr(ename, 'R', 3, 1) = 3;

-- lpad() / rpad() : Ư����ȣ�� ä���ִ� ����
select lpad('oracle', 20, '#') from dual;  -- ##############oracle ���
select rpad('oracle', 20, '#') from dual;  -- oracle############## ���

-- ltrim() : ���� ������ �����ϴ� �Լ�
-- rtrim() : ������ ������ �����ϴ� �Լ�
select '  Oracle   ', ltrim('  Oracle  ') from dual;
select rtrim('  Oracle  ') from dual;

-- trim() : ���ڿ� ��.���� ������ �����ϴ� �Լ�
--          Ư�� ���ڸ� �߶󳻴� �Լ�
select trim('  Oracle  ') from dual;
select trim('a' from 'aaaaaOracleaaaaa') from dual;
-------------------------------------------------------------------------------------------
-- 3. ��¥ �Լ�

-- sysdate : �ý����� ��¥�� �����ִ� �Լ� 
-- sysdate�� ()�� ����!!!
select sysdate from dual; -- 22/01/24

select sysdate-1 ����, sysdate ����, sysdate+1 ���� from dual;

--Q. ��� ���̺��� �� ������� ������� �ٹ��ϼ��� ���ϴ� SQL�� �ۼ�?
select sysdate-hiredate from emp;
select round(sysdate-hiredate) from emp; -- �Ҽ� 1°�ڸ����� �ݿø�
select trunc(sysdate-hiredate) from emp; -- �Ҽ��� �ڸ��� ����

-- months_between() : �� ��¥ ������ ����� ���� ���� �����ִ� �Լ�
-- months_between(date1, date2)
--Q. ��� ���̺��� �� ������� �ٹ��� ���� ���� ���ϴ� SQL�� �ۼ�?
select ename, sysdate, hiredate, months_between(sysdate, hiredate) from emp;

select months_between(sysdate, hiredate) from emp;
select round(months_between(sysdate, hiredate)) from emp;
select trunc(months_between(sysdate, hiredate)) from emp;

-- add_months() : Ư�� ��¥�� ����� ������ ��¥�� �����ִ� �Լ�
-- add_months(date, ������)
--Q. ��� ���̺��� �� ������� �Ի��� ��¥�� 6������ ����� ���ڸ� ���ϴ� SQL�� �ۼ�?
select ename, hiredate, add_months(hiredate, 6) from emp;
--Q. �԰����Ŀ� 6���� ����� ���ڸ� ���ϴ� SQL�� �ۼ�?
select add_months('21/12/21', 6) from dual;

-- next_day() : �ش� ������ ���� ����� ��¥�� �����ִ� �Լ�
-- next_day(date, ����)
--Q. ������ �������� ���� ����� ������� �������� ���ϴ� SQL�� �ۼ�?
select sysdate, next_day(sysdate, '�����') from dual;

-- last_day() : �ش� ���� ������ ��¥�� �����ִ� �Լ�
--Q. ��� ���̺��� �� ������� �Ի��� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select hiredate, last_day(hiredate) from emp;

--Q. �̹����� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select sysdate, last_day(sysdate) from dual;
select last_day('22/02/01') from dual;  --22/02/28

-- 4. ����ȯ �Լ�