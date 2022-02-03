--2022.02.03(목)

-- 객체 권한
--1. 새로 생성된 user01 계정에게 scott 계정 소유의 EMP테이블 객체에 대한 select 객체
-- 궈한을 부여해보자.
conn scott/tiger
grant select on emp to user01;

--2. user01 계정으로 접속 후 emp테이블 객체에 대해서 select 해보자
conn user01/tiger
select * from emp;  -- 오류발생
select * from scott.emp; -- 검색 가능함

--3. 객체 권한 취소
revoke select on emp from user01;

-- with grant option
-- : user02 계정에게 scott 계정 소유의 EMP 테이블 객체에 대해서 select 객체 권한을 
-- 부여할때 with grant option을 붙여서 권한이 부여되면, user02계정은 자기가 부여받은
-- 객체 권한을 제3의 계정(user01)에게 재부여할 수 있다.
--1. user02 계정에게 scott계정 소유의 EMP테이블 객체에 대한 select 객체권한 부여
conn scott/tiger
grant select on emp to user02 with grant option;

--2. user02 계정으로 접속후, user01계정에게 자기가 부여받은 객체권한을 재부여를 한다.
conn user02/tiger
select * from scott.emp;

grant select on scott.emp to user01;

--3. user01 계정으로 접속 후 검색 해보자
conn user01/tiger
select * from scott.emp; -- 검색 가능함

-----------------------------------------------------------------------------
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

------------------------------------------------------------------------------
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