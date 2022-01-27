-- 2022.01.27(목)

-- 트랜잭션(Transaction)
--1. 논리적인 작업단위
--2. 데이터의 일관성을 유지 하면서, 데이터를 안정적으로 복구하기 위해서 사용한다.

-- TCL(Transaction Control Language)
-- commit : 트랜잭션을 종료
-- rollback : 트랜잭션을 취소
-- savepoint : 복구할 시점(저장점)을 지정하는 역할

--[실습]
drop table dept01 purge;
create table dept01 as select * from dept;  -- 복사본 테이블 생성 (단 제약조건은 복사가 안된다)
select * from dept01;

-- rollback : 트랜잭션을 취소(데이터 복구)
delete from dept01;
rollback;

-- commit : 트랜잭션을 종료
delete from dept01 where deptno = 20;
commit; -- 트랜잭션 종료
rollback; -- 트랜잭션이 종료 되었기 때문에 삭제된 20번 데이터는 복구하지 못한다.
delete from dept01; -- 삭제하고 rollback하면 마지막 커밋으로 돌아간다.
insert into dept01 values(50, 'development','seoul'); -- 추가하고 rollback하면 마지막 커밋으로 돌아간다.

-- 자동 커밋 : 자동으로 커밋이 수행
-- 1) 정상적인 종료 : quit, exit, con.close()
-- 2) DDL(create, alter, rename, drop, truncate), DCL(grant,revoke)
--    명령이 수행

--예1. DDL 명령 실행(create)
select * from dept01; -- 10,30,40
delete from dept01 where deptno = 40; -- 새로운 거래시작 : 40번 데이터 삭제

create table dept03 as select * from dept; -- 자동 커밋 수행(DDL)

rollback; -- DDL실행으로 삭제된 40번 데이터를 복구하지 못한다.

--예2.  DDL 명령 실행(truncate)
--      DDL(truncate) : 데이터 복구할 수 없다. 자동으로 커밋이 되기 때문이다.
--      DML(delete) : 데이터 복구 가능

select * from dept01; -- 10,30

delete from dept01 where deptno = 30; -- DML(delete)
rollback; -- 삭제된 30번 데이터를 복구한다.

truncate table dept01; -- 자동 커밋 수행(DDL)
rollback; -- 삭제된 dept01 테이블의 데이터를 복구하지 못한다.

-- 자동 롤백 : 자동으로 롤백이 수행되는것
-- : 비정상적인 종료 : 강제로 창을 닫는 경우, 컴퓨터가 다운되는 경우

-- savepoint : 임시 저장점을 지정할때 사용하는 명령

--[실습]
drop table dept01 purge;
--1. dept01 테이블 생성
create table dept01 as select * from dept;
select * from dept01;

--2. 40번 부서 삭제
delete from dept01 where deptno = 40;

--3. commit 수행 : 트랜잭션 종료
commit;

--4. 30번 부서 삭제
delete from dept01 where deptno = 30;

--5. c1 저장점 생성
savepoint c1;

--6. 20번 부서 삭제
delete from dept01 where deptno = 20;

--7. c2 저장점 생성
savepoint c2;

--8. 10번 부서 삭제
delete from dept01 where deptno = 10;

--9. c2 저장점까지 복구
rollback to c2; -- 10번 부서 복구됨
select * from dept01;

--10. c1번 저장점까지 복구
rollback to c1; -- 10, 20번 부서 복구됨
select * from dept01;

--11. 이전 트랜잭션 종료 이후를 복구
rollback;   -- 10, 20, 30번 부서 복구됨
select * from dept01;

---------------------------------------------------------------------------
-- 무결성 제약조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해서 테이블을 생성할 때 
-- : 각 컬럼에 대해서 정의하는 여러가지 규칙을 말한다.
-- ex) not null, unique, primary key(기본키), foreign key(외래키),
--     check, default etc

--1. not null 제약조건
-- : null 값을 허용하지 않는다.
-- 반드시 값을 입력 해야 한다.

--[실습]
drop table emp02 purge;
select * from tab;

create table emp02(
    empno number(4) not null,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2));
    
select * from emp02;
desc emp02;

-- 제약조건에 위배되지 않는 데이터 입력
insert into emp02 values(1111, '홍길동', 'MANAGER', 30);

-- 제약조건(NOT NULL)에 위배되기 때문에 데이터 입력되지 않는다.
-- empno와 ename는 NOT NULL이기 떄문에 NULL이 입력되면 안된다.
insert into emp02 values(NULL, NULL, 'SALESMAN', 30); 
insert into emp02(job, deptno) values('SALESMAN', 30);



--2. unique 제약조건
-- : 유일한 값만 입력할 수 있다.
-- : 중복된 값을 입력할 수 없다
-- : null 값은 입력할 수 있다.

drop table emp03 purge;

create table emp03(
    empno number(4) unique,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2));
    
select * from tab;
select * from emp03;

-- 정상적인 데이터 입력
insert into emp03 values(1111, '홍길동', '개발자', 10);

-- unique 제약조건에 위배 
insert into emp03 values(1111, '홍길동', '개발자', 10);
-- empno가 unique에 위배 되었기 때문에 오류 발생

-- NULL 값은 입력 가능함
insert into emp03 values(NULL, '홍길동', '개발자', 20);
insert into emp03 values(NULL, '안화수', '개발자', 20);

--3. primary key (기본키)
--   primary key = not null + unique
--   반드시 중복되지 않는 값을 입력 해야된다.
--   ex) 부서테이블(DEPT) - deptno(pk)
--       사원테이블(EMP) - empno (pk)

--      게시판(board) - 번호(no) primary key
--      회원관리(member) - 아이디(id) pk

select * from dept;
insert into dept values(10, '개발부', '서울'); -- unique 제약조건 위배
insert into dept values(NULL, '개발부', '서울'); -- NOT NULL 제약조건 위배
-- DEPT 테이블의 DEPTNO 컬럼은 primary key 제약조건이 설정되어 있기 때문에
-- 중복된 값과 NULL값을 입력할 수 없다.

select * from emp;
insert into emp(empno, ename) values(7788, '홍길동'); -- unique 제약조건 위배
insert into emp(empno, ename) values(NULL, '홍길동'); -- NOT NULL 제약조건 위배

drop table emp05 purge;
create table emp05(
    empno number(4) primary key,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2));
    
select * from emp05;
desc emp05;
insert into emp05 values(1111, '홍길동', '개발자', 20); -- 정상적인 데이터 입력
insert into emp05 values(1111, '홍길동', '개발자', 20); -- unique 제약조건 위배
insert into emp05 values(NULL, '홍길동', '개발자', 20); -- NOT NULL 제약조건 위배

-- 제약조건 이름(constraint_name)을 설정해서 테이블 생성 
-- 제약조건 이름을 설정하는 이유 : 테이블에서 제약조건을 삭제하기 위해서 설정해준다.
-- 이름설정 : 테이블명_컬럼명_제약조건약어 (평균적인 이름 설정 규칙)
drop table emp04 purge;
CREATE TABLE EMP04( 
EMPNO NUMBER(4) CONSTRAINT EMP04_EMPNO_UK UNIQUE, 
ENAME VARCHAR2(10) CONSTRAINT EMP04_ENAME_NN NOT NULL, 
JOB VARCHAR2(9),
DEPTNO NUMBER(2)
);

select * from emp04;

-- 제약조건 확인하기
desc user_constraints;
select * from user_constraints;


create sequence seq
    start with 1
    increment by 1
    maxvalue 100000
    nocycle;