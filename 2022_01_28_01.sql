-- 2022.01.28(금)

--4. foreign key(외래키)
-- DEPT(부모 테이블) - deptno(pk) : 10, 20, 30, 40
-- EMP(자식 테이블) - deptno(fk) : 10, 20, 30

--1) 사원테이블(EMP)의 deptno 컬럼이 foreign key 제약조건이 설정되어 있다.
--2) foreign key 제약조건이 가지고 있는 의미는 부모(DEPT)의 부모키(deptno)의 값만 참조할 수 있다.
--3) 부모키가 되기 위한 조건은 primary key, unique 제약조건으로 설정되어 있어야 한다.

--Q. 사원테이블(EMP)에 새로운 사원정보를 등록 해보자?
-- 외래키는 부모키(DEPT -deptno)안에 있는 값(10, 20, 30, 40)만 참조할 수 있다.
insert into emp(empno, deptno) values(1111, 50); -- 제약조건 위배

--[실습]
drop table emp06 purge;
create table emp06(
    empno  number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(10),
    deptno number(2) references dept(deptno));
    
select * from emp06;
insert into emp06 values(1111, '홍길동', '개발자', 10);
insert into emp06 values(1112, '홍길동', '개발자', 20);
insert into emp06 values(1113, '홍길동', '개발자', 30);
insert into emp06 values(1114, '홍길동', '개발자', 40);
insert into emp06 va1ues(1115, '홍길동', '개발자', 50); -- 제약조건 위배

--5. check 제약조건
-- : 데이터가 입력될때 특정 조건을 만족하는 데이터만 입력되도록 만들어 주는 제약조건

create table emp07(
    empno number(4) primary key,
    ename varchar2(10) not null,
    sal number(7,2) check(sal between 500 and 5000),  -- sal : 500~5000
    gender varchar2(1) check(gender in('M','F')));    -- gender : 'M' OR 'F'
    
select * from emp07;
insert into emp07 values(1111, '홍길동', 3000, 'M'); -- 정상적인 데이터 입력
insert into emp07 values(1112, '홍길동', 8000, 'M'); -- check 제약조건 위배
insert into emp07 values(1113, '홍길동', 5000, 'm'); -- check 제약조건 위배

--6. default 제약조건
-- default 제약조건이 설정된 컬럼ㅇ에 값이 입력되지 않으면 default로 설정된 값이 자동으로 입력된다.

drop table dept01 purge;
create table dept01(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13) default 'SEOUL');
    
select * from dept01;
insert into dept01 values(10,'ACCOUNTING', 'NEW YORK');
insert into dept01(deptno, dname) values(20, 'RESEARCH');

----------------------------------------------------------------------------------------------
-- 제약 조건 설정 방식 : 평소에는 2방식 모두 가능하다. 
--1. 컬럼레벨 방식으로 제약조건 설정
--2. 테이블레벨 방식으로 제약조건 설정

--1. 컬럼레벨 방식으로 제약조건 설정
drop table emp01 purge;

create  table  emp01(	
	empno  number(4)  primary  key,
	ename  varchar2(15)  not null,
	job  varchar2(10)  unique,
 	deptno  number(4)  references  dept(deptno) );

--2. 테이블레벨 방식으로 제약조건 설정
drop table emp02 purge;

create table emp02(
    empno number(4),
    ename varchar2(15) not null,
    job varchar2(10),
    deptno number(4),
    primary key(empno),
    unique(job),
    foreign key(deptno) references dept(deptno));
    
-- 제약 조건을 설정할 때 테이블 레벨 방식만 가능한 경우
--1. 기본키를 복합키로 사용하는 경우
--   2개 이상의 컬럼을 기본키로 설정하는 경우
--2. alter table 로 제약 조건을 추가할 경우

--1. 2개 이상의 컬럼을 기본키로 설정하는 경우
drop table member01 purge;

--1) 컬럼레벨 방식으로 2개의 컬럼을 primary key로 설정
create table member01(
    id varchar2(20) primary key,
    passwd varchar2(20) primary key); -- 테이블 생성안됨
    
--2) 테이블레벨 방식으로 2개의 컬럼을 primary key로 설정
create table member01(
    id varchar2(20),
    passwd varchar2(20),
    primary key(id, passwd)); -- 테이블 생성됨
    
--2. alter table로 제약 조건을 추가할 경우
drop table emp01 purge;

-- 제약조건이 없는 테이블 생성
create table emp01(
    empno number(4),
    ename varchar2(15),
    job varchar2(10),
    deptno number(2));
    
-- primary key 제약조건 추가 : empno
alter table emp01 add primary key(empno);

-- not null 제약조건 추가 : ename
alter table emp01 modify ename not null;

-- unique 제약조건 추가 : job
alter table emp01 add unique(job);

-- foreign key 제약조건 추가 : deptno
alter table emp01 add foreign key(deptno) references dept(deptno);

-- 제약조건 제거
-- 형식 : alter table 테이블명 drop constraint constraint_name;

-- primary key 제약조건 제거
alter table emp01 drop constraint SYS_C007035;  -- SYS_C007035는 primary key의 이름
alter table emp01 drop primary key

-- not null 제약조건 제거
alter table emp01 drop constraint SYS_C007036;

-- unique 제약조건 제거
alter table emp01 drop constraint SYS_C007037;
alter table emp01 drop unique(job);

-- foreign key 제약조건 제거
alter table emp01 drop constraint SYS_C007038;

------------------------------------------------------------------------------------------
-- 제약 조건의 활성화 / 비활성화
--1. 부모 테이블 생성
drop table dept01 purge;
create table dept01(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13));
    
insert into dept01 values(10, 'ACCOUNTING', 'NEW YORK');
select * from dept01;

--2. 자식 테이블 생성
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(10) not null, 
    job varchar2(10) unique,
    deptno number(2) references dept01(deptno) on delete cascade);
    
insert into emp01 values(1111, '홍길동', '개발자', 10);
select * from emp01;

--3. 부모 테이블의 데이터 삭제
delete from dept01; -- 자식테이블(EMP01)에서 참조하고 있기 때문에 삭제 안됨.

-- 부모 테이블(DEPT01) 데이터를 삭제하기 위해서는 자식 테이블(EMP01)의
-- foreign key 제약조건을 비활성활 시키면, 부모 테이블의 데이터를 삭제할 수 있다.

-- 자식 테이블(EMP01)의 foreign key 제약조건을 비활성화 시켜보자?
-- 형식 : alter table 테이블명 disable constraint constraint_name
alter table emp01 disable constraint SYS_C007043;

--cf. foreign key 제약조건을 활성화
alter table emp01 enable constraint SYS_C007043;

-- cascade
-- : cascade 옵션을 붙여서 부모 테이블(DEPT01)의 제약조건을 비활성화 시키면, 
-- 참조하고 있는 자식 테이블(EMP01)의 foreign key 제약조건도 같이 비활성화 된다.
alter table dept01 disable constraint SYS_C007039 cascade;

--2. cascade 옵션을 붙여서 부모테이블(DEPT01)의 primary key 제약조건을 제거하면, 
--   참조하고 있는 자식 테이블(EMP01)의 foreign key 제약조건도 같이 제거 해준다.
alter table dept01 drop primary key cascade;