-- 2022.02.04(��)

-- ���Ǿ�(synonym)
--1.����� ���Ǿ�
-- : ��ü�� ���� ���� ������ �ο����� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ����� �� �ִ�.

--2.���� ���Ǿ�
-- : DBA ������ ���� ����ڸ� ������ �� ������, ������ ����� �� �ִ�.

-- ���� ���Ǿ��� ��
-- sys.dual --> dual        select 10+20 from dual;
-- sys.tab --> tab          select * from tab;
-- sys.seq --> seq          select * from seq;

--------------------------------------------------------------------------------
-- ����� ���Ǿ� ����
--1. system �������� ������ ���̺� ����
conn system/oracle
create table systbl(ename varchar2(20));

--2. ������ ���̺��� ������ �߰�
conn system/oracle
insert into systbl values('��ȭ��');
insert into systbl values('ȫ�浿');

select * from systbl;

--3. scott �������� systbl ���̺��� ���� select ��ü������ �ο�
conn system/oracle
grant select on systbl to scott;

--4. scott �������� ������ �˻�
conn scott/tiger
select * from systbl; -- �����߻�
select * from system.systbl; -- �˻� ������

--5. scott �������� ���Ǿ ������ �� �ִ� ������ �ο��Ѵ�
conn system/oracle
grant create synonym to scott;

--6. scott�������� ������ ����� ���Ǿ� ���� : system.systbl --> systbl
conn scott/tiger
create synonym systblex for system.systbl;

--7. ���Ǿ� ���
conn scott/tiger
select * from user_synonyms;

--8. ���Ǿ �̿��ؼ� �˻�
conn scott/tiger
select * from system.systbl;
select * from systbl; -- ���Ǿ �̿��ؼ� �˻���(����� ���Ǿ�)

--9. ���Ǿ� ����
conn scott/tiger
-- ���� : drop synonym synonym_name;
drop synonym systbl;


-- ���� ���Ǿ�
--1. DBA �������� �����ؼ� ���� ���Ǿ ������ �� �ִ�.
--2. ���� ���Ǿ ���鶧�� public�� �ٿ��� ������ �� �ִ�.

-- ���� ���Ǿ� ����
conn system/oracle
create public synonym pubdept for scott.dept;

-- ���� ���Ǿ� ���
select * from dba_synonyms;

-- ���� ���Ǿ� ����
conn system/oracle
drop public synonym pubdept;

-------------------------------------------------------------------------------
-- PL/SQL

--Q. Hello World ~!! ���
set serveroutput on
begin   -- ����� ����
 DBMS_OUTPUT.PUT_LINE('Hello World~!!');
end;

-- ���� ����ϱ�
set SERVEROUTPUT ON
declare -- ����� ����
    vempno number(4);   -- ���� ���� : ��Į�� ����
    vename varchar2(10);
begin   -- ����� ����
    vempno := 7788; -- �������� ��.�ҹ��ڸ� �������� �ʴ´�.
    vename := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('���  /  �̸�');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '/' || VENAME);
end;    -- ����� ��

-- ����� �̸� �˻��ϱ� : ���۷��� ���� ����ϱ�
SET SERVEROUTPUT ON
declare
    vempno emp.empno%type; -- ���۷��� ����
    vename emp.ename%type;
begin
    select empno, ename into vempno, vename from emp where ename = 'SCOTT';
    DBMS_OUTPUT.put_line('��� / �̸�');
    DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename);
end;    

----------------------------------------------------------------------------
-- ���ǹ�(=���ù�)
--1. if ~ then ~ end if
--Q. SCOTT ����� �μ���ȣ�� �˻��ؼ� �μ����� ����ϴ� PL/SQL�� �ۼ�?
SET SERVEROUTPUT ON
declare -- ����� 
    vempno number(4);
    vename varchar2(20);
    vdeptno dept.deptno%type;
    vdname varchar2(20) := null;
begin   -- �����
    select empno,ename,deptno into vempno, vename, vdeptno from emp 
        where ename = 'SCOTT';
        
    if vdeptno = 10 then 
        vdname := 'ACCOUNTING';
    end if;
    if vdeptno = 20 then 
        vdname := 'RESEARCH';
    end if;
    if vdeptno = 30 then 
        vdname := 'SALES';
    end if;
    if vdeptno = 40 then 
        vdname := 'OPERATIONS';
    end if;
    DBMS_OUTPUT.PUT_LINE('��� / �̸� / �μ���');
    DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename || '/' || vdname);
end;
    
--Q. ��� ���̺����� SCOTT ����� ������ ���ϴ� PL/SQL�� �ۼ�?
SET SERVEROUTPUT ON
declare
    vemp emp%rowtype;   -- ���۷��� ����
    annsal number(7,2); -- ��Į�� ����  
begin
    select * into vemp from emp where ename = 'SCOTT';
    
    if vemp.comm is null then vemp.comm := 0;
    end if;
    
    annsal := vemp.sal * 12 + vemp.comm;
    DBMS_OUTPUT.PUT_LINE('��� / �̸� / ����');
    DBMS_OUTPUT.PUT_LINE(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;

--2. if ~ then ~ else ~ end if
--Q. ��� ���̺����� SCOTT ����� ������ ���ϴ� PL/SQL�� �ۼ�?
SET SERVEROUTPUT ON
declare
    vemp emp%rowtype;   -- ���۷��� ����
    annsal number(7,2); -- ��Į�� ����
begin
    select * into vemp from emp where ename = 'SCOTT';
    
    if vemp.comm is null then
        annsal := vemp.sal * 12;
    else 
        annsal := vemp.sal * 12 + vemp.comm;
    end if;
    
    DBMS_OUTPUT.PUT_LINE('��� / �̸� / ����');
    DBMS_OUTPUT.PUT_LINE(vemp.empno||'/'||vemp.ename||'/'||annsal);
end;

--3. if ~ then ~ elsif ~ else ~ end if
--Q. SCOTT����� �μ� ��ȣ�� �̿��ؼ� �μ����� ����ϴ� PL/SQL�� �ۼ�?
SET SERVEROUTPUT ON
declare
    vemp emp%rowtype; -- ���۷��� ����
    vdname varchar2(14);
begin
    select * into vemp from emp where ename = 'SCOTT';
    
    if vemp.deptno = 10 then vdname := 'ACCOUNTING';
    elsif vemp.deptno = 20 then vdname := 'RESEARCH';
    elsif vemp.deptno = 30 then vdname := 'SALES';
    elsif vemp.deptno = 40 then vdname := 'OPERATIONS';
    end if;
    
    DBMS_OUTPUT.PUT_LINE('��� / �̸� / �μ���');
    DBMS_OUTPUT.PUT_LINE(vemp.empno||'/'||vemp.ename||'/'||vdname);
end;
--------------------------------------------------------------------------------
-- �ݺ���
--1.Basic Loop�� 
--  loop
--     �ݺ� ����� ����;
--     ���ǽ� exit;
--  end loop;

--Q1. 1 ~ 5���� ���
SET SERVEROUTPUT ON
declare
    n number := 1;  -- ������ �ʱⰪ 1
begin
    loop
        DBMS_OUTPUT.PUT_LINE(n);
        n := n + 1;
        if n > 5 then exit;
        end if;
    end loop;
end;

--Q2. 1���� 10���� ���� ���ϴ� ���α׷� �ۼ�
SET SERVEROUTPUT ON
declare
    n number := 1;  -- ������ ���� ����
    s number := 0;  -- ���� ������ ����
begin
    loop
        s := s + n;
        n := n + 1;
        if n > 10 then exit;
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE('1~10������ ��:'||s);
end; 

--2. For Loop��
-- for ���� in ������..ū�� loop
--  �ݺ� ����� ����;
-- end loop;

--Q1. For Loop������ 1���� 5���� ���
SET SERVEROUTPUT ON
begin
    for n in 1..5 loop  -- �ڵ����� 1�� ����
        DBMS_OUTPUT.PUT_LINE (n);
    end loop;
end;

--Q2. For Loop������ 5���� 1���� ���
SET SERVEROUTPUT ON
begin
    for n in reverse 1..5 loop  -- �ڵ����� 1�� ����
        DBMS_OUTPUT.PUT_LINE (n);
    end loop;
end;

--Q3. For Loop���� �̿��ؼ� �μ� ���̺�(DEPT)�� ��� ������ ����ϴ� PL/SQL�� �ۼ��ϼ���?
SET SERVEROUTPUT ON
declare
    vdept dept%rowtype;
begin 
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������');
    for cnt in 1..4 loop
        select * into vdept from dept where deptno = 10 * cnt;
        DBMS_OUTPUT.PUT_LINE(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
end;

--3. While Loop�� 
-- while ���ǽ� loop
--  ����� ����;
-- end loop;
--Q1. while loop������ 1���� 5���� ���
SET SERVEROUTPUT ON
declare
    n number := 1;
begin 
    while n <= 5 loop
        DBMS_OUTPUT.PUT_LINE(n);
        n := n + 1;
    end loop;
end;

--Q2. while loop���� �̿��ؼ� ��(*)�� �ﰢ�� ������� ���
SET SERVEROUTPUT ON
declare
    c number := 1;
    str varchar2(100) := null;
begin
    while c<=10 loop
        str := str || '*';
        DBMS_OUTPUT.put_line(str);
        c := c + 1;
    end loop;
end;