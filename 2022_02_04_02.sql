-- 2022.02.04(��)

-- ���� ���ν���

--[�ǽ�]
drop table emp01 purge;
create table emp01 as select * from emp; -- ���纻 ���̺� ����
select * from emp01;

--1. ���� ���ν��� ����
create or replace procedure del_all
is
begin
    delete from emp01;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
execute del_all;
exec del_all;

--4. ���ν��� ���� Ȯ��
select * from emp01;    -- ���ν����� ���ؼ� �����Ͱ� ��� ������

rollback;
insert into emp01 select * from emp;
----------------------------------------------------------------------
-- �Ű������� �ִ� ���ν���
--1.�Ű������� �ִ� ���ν��� ����
-- mode�� in,out, inout 3���� �ִ� 
-- mode�� �⺻���� in�̴�. ������ �Է��� �� ��� in�� ���������ϴ�
create or replace procedure del_ename(vename in emp01.ename%type)
is
begin
    delete from emp01 where ename = vename;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
exec del_ename('SCOTT');
execute del_ename('KING');
execute del_ename('SMITH');

--4. ���ν��� ���� Ȯ��
select * from emp01;

rollback;
---------------------------------------------------------------------
-- �Ű������� MODE�� in, out���� �Ǿ��ִ� ���ν���
-- in : �Ű������� ���� �޴� ����
-- out : �Ű������� ���� �����ִ� ����

--1. ���ν��� ����
-- �����ȣ�� ���ν����� �Ű������� ���� �޾Ƽ�, �� ����� �����,�޿�,��å�� ���ϴ� ���ν��� ����
create or replace procedure sal_empno(
          vempno in emp.empno%type,
          vename out emp.ename%type,
          vsal out emp.sal%type,
          vjob out emp.job%type )
is
begin
    select ename, sal, job into vename, vsal, vjob from emp 
        where empno = vempno;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ε� ���� : ���ν����� ���� ������ ����� �����޴� ����
-- ���ε� ������ ��Į���������� ���� ������ ������ ���۷��� �������� ���� ������ �����.
variable var_ename varchar2(12);
variable var_sal number;
variable var_job varchar2(10);

--4. ���ν��� ����
execute sal_empno(7788, :var_ename, :var_sal, :var_job);
execute sal_empno(7839, :var_ename, :var_sal, :var_job);

print var_ename;
print var_sal;
print var_job;

-----------------------------------------------------------------------------------
--Q. ��� ���̺����� ������� �˻��Ͽ� ����� ������ ���ؿ��� ���� ���ν����� ���� �ϼ���?


----------------------------------------------------------------------------
-- �ڹ� ���α׷����� ���ν��� ����
-- 1.���ν��� ����
create or replace procedure del_all
is
begin
    delete from emp01;
end;

--2. emp01 ���̺� ����
drop table emp01 purge;
create table emp01 as select * from emp;
select * from emp01;