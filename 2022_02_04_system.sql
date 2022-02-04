-- 2022.02.04(금)

-- 동의어(synonym)
--1.비공개 동의어
-- : 객체에 대한 접근 권한을 부여받은 사용자가 정의한 동의어로 해당 사용자만 사용할 수 있다.

--2.공개 동의어
-- : DBA 권한을 가진 사용자만 생성할 수 있으며, 누구나 사용할 수 있다.

-- 공개 동의어의 예
-- sys.dual --> dual        select 10+20 from dual;
-- sys.tab --> tab          select * from tab;
-- sys.seq --> seq          select * from seq;

--------------------------------------------------------------------------------
-- 비공개 동의어 예제
--1. system 계정으로 접속후 테이블 생성
conn system/oracle
create table systbl(ename varchar2(20));

--2. 생성된 테이블에 데이터 추가
conn system/oracle
insert into systbl values('안화수');
insert into systbl values('홍길동');

select * from systbl;

--3. scott 계정에게 systbl 테이블에 대한 select 객체권한을 부여
conn system/oracle
grant select on systbl to scott;

--4. scott 계정으로 접속후 검색
conn scott/tiger
select * from systbl; -- 오류발생
select * from system.systbl; -- 검색 가능함

--5. scott 계정에게 동의어를 생성할 수 있는 권한을 부여한다
conn system/oracle
grant create synonym to scott;

--6. scott계정으로 접속후 비공개 동의어 생성 : system.systbl --> systbl
conn scott/tiger
create synonym systblex for system.systbl;

--7. 동의어 목록
conn scott/tiger
select * from user_synonyms;

--8. 동의어를 이용해서 검색
conn scott/tiger
select * from system.systbl;
select * from systbl; -- 동의어를 이용해서 검색함(비공개 동의어)

--9. 동의어 삭제
conn scott/tiger
-- 형식 : drop synonym synonym_name;
drop synonym systbl;


-- 공개 동의어
--1. DBA 계정으로 접속해서 공개 동의어를 생성할 수 있다.
--2. 공개 동의어를 만들때는 public을 붙여서 생성할 수 있다.

-- 공개 동의어 생성
conn system/oracle
create public synonym pubdept for scott.dept;

-- 공개 동의어 목록
select * from dba_synonyms;

-- 공개 동의어 삭제
conn system/oracle
drop public synonym pubdept;