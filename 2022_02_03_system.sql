-- 2022.02.03(목)

-- 데이터베이스 보안을 위한 권한
--1. 시스템 권한
--2. 객체 권힌

-- 시스템 권한 : 데이터베이스 관리자(DBA)가 가지고 있는 권한
-- EX) create user, drop user,......

-- 시스템 관리자가 일반 사용자에게 부여하는 권한
-- ex) create session : 데이터베이스 접속 권한
--     create table : 테이블을 생성할 수 있는 권한
--     create view : 뷰를 생성할 수 있는 권한
--     create sequence : 시퀀스를 생성할 수 있는 권한
--     create procedure : 프로시저를 생성할 수 있는 권한

-- 새로운 계정 생성 : user01 / tiger
create user user01 identified by tiger;

-- 생성된 계정 목록 확인
select * from dba_users;

-- user01 계정에게 데이터베이스 접속 권한 부여 : create session
grant create session to user01;
grant create session, create table to user01;

-- with admin option
-- : grant 명령으로 권한을 부여 받을때 with admin option을 붙여서 권한이 부여되면,
-- 권한을 부여 받은 일반 계정은 자기가 부여 받은 권한을 제3의 계정에게 재 부여할 수 있다.

--1. 새로운 계정 생성 : user02/ tiger
create user user02 identified by tiger;

--2. 데이터베이스 권한 부여
grant create session to user02 with admin option;

--3. 제3의 계정 생성 : user03/tiger
create user user03 identified by tiger;

--4. user01 계정으로 접속후 user03계정에게 create session 권한 부여해보자
SQL> conn user01/tiger
SQL> grant create session to user03; -- 오류발생 

--5. user02 계정으로 접속후 user03계정에게 create session 권한 부여해보자.
SQL> conn user02/tiger
SQL> grant create session to user03;

--6. user03 계정은 user02 계정으로 부터 create session 권한을 부여 받았기 때문에
-- 데이터베이스 접속이 가능하다
SQL> conn user03/tiger
SQL> show user;

-------------------------------------------------------------------------
-- 롤(ROLE) : 여러가지 권한을 묶어 놓은 것

-- 오라클에서 기본적으로 제공되는 롤
-- ex) connect(8가지 권한), resource(20여개 권한), dba(130여개 권한)

--1. 새로운 계정 생성 : user04/tiger
create user user04 identified by tiger;

--2. 생성된 계정 확인
select * from dba_users;

--3. user04 계정에게 role 부여 : connect, resource 2가지 롤부여
grant connect, resource to user04;

--4. user04 계정으로 접속후 테이블 생성
conn user04/tiger
create table member(id varchar2(20), passwd varchar2(20));

-----------------------------------------------------------------------
-- 사용자 정의 롤 : 롤에 시스템을 권한을 부여
--1. 롤 생성
create role mrole;

--2. 생성된 롤에 시스템 권한을 추가한다.
grant create session, create table, create view to mrole;

--3. mrole을 적용하기 위한 계정 생성 : user05/tiger
create user user05 identified by tiger;

--4. user05계정에게 mrole을 부여한다.
grant mrole to user05;

--5. user05 계정으로 접속
conn user05/tiger

--------------------------------------------------------------------------
-- 사용자 정의 롤 생성 : 롤에 객체권한 부여
--1. 롤 생성
conn system/oracle
create role mrole02;

--2. 생성된 롤에 객체 권한을 추가한다.
conn scott/tiger
grant select on emp to mrole02;

--3. user05 계정에게 mrole02를 부여한다.
conn system/oracle
grant mrole02 to user05;

--4. user05 계정으로 접속후 검색을 해보자
conn user05/tiger
select * from scott.emp;

-- 롤 회수
-- 형식 : revoke 롤이름 from 사용자명;
conn system/oracle
revoke mrole from user05;
revoke mrole02 from user05;

-- 롤 삭제
conn system/oracle
drop role mrole;
drop role mrole02;

-------------------------------------------------------------------------------------
-- 디폴트 롤을 생성하여 여러 사용자에게 부여하기
-- 디폴트 롤 = 시스템 권한 + 객체 권한

--1. 디폴트 롤 생성
conn system/oracle
create role def_role;

--2. 생성된 롤(def_role)에 시스템 권한 추가
conn system/oracle
grant create session, create table to def_role;

--3. 생성된 롤(def_role)에 객체 권한 추가
conn scott/tiger
grant select on emp to def_role;
grant update on emp to def_role;
grant delete on emp to def_role;

--4. role을 적용하기 위한 일반 계정 생성
conn system/oralce
create user usera1 identified by tiger;
create user usera2 identified by tiger;
create user usera3 identified by tiger;

--5. def_role을 생성된 계정에게 부여
conn system/oracle
grant def_role to usera1;
grant def_role to usera2;
grant def_role to usera3;

--6. usera1 계정으로 접속후 검색
conn usera1/tiger
select * from scott.emp;

