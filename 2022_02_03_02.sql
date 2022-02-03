--2022.02.03(��)

-- ��ü ����
--1. ���� ������ user01 �������� scott ���� ������ EMP���̺� ��ü�� ���� select ��ü
-- ������ �ο��غ���.
conn scott/tiger
grant select on emp to user01;

--2. user01 �������� ���� �� emp���̺� ��ü�� ���ؼ� select �غ���
conn user01/tiger
select * from emp;  -- �����߻�
select * from scott.emp; -- �˻� ������

--3. ��ü ���� ���
revoke select on emp from user01;

-- with grant option
-- : user02 �������� scott ���� ������ EMP ���̺� ��ü�� ���ؼ� select ��ü ������ 
-- �ο��Ҷ� with grant option�� �ٿ��� ������ �ο��Ǹ�, user02������ �ڱⰡ �ο�����
-- ��ü ������ ��3�� ����(user01)���� ��ο��� �� �ִ�.
--1. user02 �������� scott���� ������ EMP���̺� ��ü�� ���� select ��ü���� �ο�
conn scott/tiger
grant select on emp to user02 with grant option;

--2. user02 �������� ������, user01�������� �ڱⰡ �ο����� ��ü������ ��ο��� �Ѵ�.
conn user02/tiger
select * from scott.emp;

grant select on scott.emp to user01;

--3. user01 �������� ���� �� �˻� �غ���
conn user01/tiger
select * from scott.emp; -- �˻� ������

-----------------------------------------------------------------------------
-- ����� ���� �� ���� : �ѿ� ��ü���� �ο�
--1. �� ����
conn system/oracle
create role mrole02;

--2. ������ �ѿ� ��ü ������ �߰��Ѵ�.
conn scott/tiger
grant select on emp to mrole02;

--3. user05 �������� mrole02�� �ο��Ѵ�.
conn system/oracle
grant mrole02 to user05;

--4. user05 �������� ������ �˻��� �غ���
conn user05/tiger
select * from scott.emp;

------------------------------------------------------------------------------
-- ����Ʈ ���� �����Ͽ� ���� ����ڿ��� �ο��ϱ�
-- ����Ʈ �� = �ý��� ���� + ��ü ����

--1. ����Ʈ �� ����
conn system/oracle
create role def_role;

--2. ������ ��(def_role)�� �ý��� ���� �߰�
conn system/oracle
grant create session, create table to def_role;

--3. ������ ��(def_role)�� ��ü ���� �߰�
conn scott/tiger
grant select on emp to def_role;
grant update on emp to def_role;
grant delete on emp to def_role;

--4. role�� �����ϱ� ���� �Ϲ� ���� ����
conn system/oralce
create user usera1 identified by tiger;
create user usera2 identified by tiger;
create user usera3 identified by tiger;

--5. def_role�� ������ �������� �ο�
conn system/oracle
grant def_role to usera1;
grant def_role to usera2;
grant def_role to usera3;

--6. usera1 �������� ������ �˻�
conn usera1/tiger
select * from scott.emp;