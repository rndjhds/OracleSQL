-- 2022.02.07(월)

-- 자바 프로그램으로 프로시저 실행
-- 1.프로시저 실행
create or replace procedure del_all
is
begin
    delete from emp01;
end;

--2. emp01 테이블 생성
drop table emp01 purge;
create table emp01 as select * from emp;
select * from emp01;

--예2. 
--1. 프로시저 생성
create or replace procedure 
	del_ename(vename in emp01.ename%TYPE)
is
begin
     delete from emp01 where ename=vename;
end;

--2. 프로시저 목록 확인
select * from user_source;

--3. emp01테이블 생성
insert into emp01 select * from emp;
select * from emp01;

--예3. 
-- 저장 프로시정 생성
create or replace procedure sel_customer( 
    vname in customer.name%TYPE,
    vemail out customer.email%TYPE,
    vtel out customer.tel%TYPE)
is
begin
	select email, tel into vemail, vtel from customer
	where name = vname;
end;

--2. 저장 프로시저 목록 확인
select * from user_source;

--3. 바인드 변수 생성
variable var_email varchar2(20);
variable var_tel varchar2(20);

--4. 프로시저 실행
execute sel_customer('홍길동', :var_email, :var_tel);
exec sel_customer('홍길동', :var_email, :var_tel);
execute sel_customer('안화수', :var_email, :var_tel);
exec sel_customer('안화수', :var_email, :var_tel);

print var_email;
print var_tel;

---------------------------------------------------------------------------------------------
-- 저장 함수 
-- : 저장 함수는 저장 프로시저와 유사한 기능을 수행하지만, 실행 결과를 돌려주는 역할을 한다.
-- 저장 프로시저는 실행 결과를 돌려줘도 되고 안돌려줘도 된다.

--Q1. 사원 테이블에서 특정 사원의 급여를 200% 인상한 결과를 돌려주는 저장 함수 생성
--1. 저장 함수 생성
create or replace function cal_bonus(vempno in emp.empno%type)
    return number   -- 돌려줄 값의 자료형
is
    vsal number(7,2);    -- 로컬 변수
begin
    select sal into vsal from emp where empno = vempno;
    return vsal * 2;
end;

--2. 저장 함수 목록 확인
select * from user_source;

--3. 바인드 변수 생성
variable var_res number;

--4. 저장 함수 실행
execute :var_res := cal_bonus(7788);
exec :var_res := cal_bonus(7788);
execute :var_res := cal_bonus(7900);

print var_res;

-- 저장 함수를 SQL문에 포함해서 실행
select sal, cal_bonus(7788) from emp where empno = 7788;
select sal, cal_bonus(7900) from emp where empno = 7900;

--Q2. 사원명을 저장함수의 매개변수로 전달하여 해당 사원의 직급을 구해오는 저장함수 생성
--1. 저장 함수 생성
create or replace function job_emp(vename in emp.ename%type)
    return varchar2 -- 돌려줄 값의 자료형
is
    vjob emp.job%type;  -- 로컬 변수
begin
    select job into vjob from emp where ename = vename;
    return vjob;
end;

--2. 저장 함수 목록 확인
select * from user_source;

--3. 바인드 변수 생성
variable var_job varchar2(10);

--4. 저장 함수 실행
execute :var_job := job_emp('SCOTT');
execute :var_job := job_emp('KING');
print var_job;

-- 저장 함수를 SQL문에 포함해서 실행
select ename, job_emp('SCOTT') from emp where ename = 'SCOTT';
select ename, job_emp('KING') from emp where ename = 'KING';
-----------------------------------------------------------------------------------------------
-- 커서(cursor)
-- : 2개 이상의 데이터를 처리할 때 커서를 사용한다.
-- : 반복문과 같이 많이 쓰인다.
--Q1. 부서 테이블의 모든 데이터를 출력하기 위한 PL/SQL문 작성하세요.
--1. 저장 프로시저 생성
SET SERVEROUTPUT ON
create or replace procedure cursor_sample01
is
    vdept dept%rowtype; -- 로컬변수  dept테이블의 컬럼을 모두 참조
    
    cursor c1   -- 커서 선언
    is
    select * from dept;
begin
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('------------------------');
    
    open c1;    -- 커서 열기
        loop
            fetch c1 into vdept.deptno, vdept.dname, vdept.loc; -- 인출
            exit when c1%notfound;  -- 커서가 가져올 데이터가 없을 때 true
            DBMS_OUTPUT.PUT_LINE(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
        end loop;
    close c1;
end;

--2. 프로시저 목록 확인
select * from user_source;

--3. 프로시저 실행
execute cursor_sample01;

--Q2. 부서 테이블의 모든 내용을 출력하기 : For Loop문으로 처리
--  1. open ~ fetch ~ close 없이 처리할 수 있다.
-- 2. for loop문을 사용하게 되면 각 반복문마다, cursor 열고, 각 행을 인출(fetch)하고, close로 커서를
-- 닫는 작업을 자동으로 처리해준다.

--1. 저장 프로시저 생성
create or replace procedure cursor_sample02
is
    vdept dept%rowtype; -- 로컬변수
    
    cursor c1   -- 커서 선언
    is
    select * from dept;
begin
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_LINE('------------------------');
    
    for vdept in c1 loop
        exit when c1%notfound;  -- 커서가 가져올 데이터가 없을 때 true
        DBMS_OUTPUT.PUT_LINE(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);    
    end loop;
end;

--2. 프로시저 목록 확인
select * from user_source;

--3. 프로시저 실행
execute cursor_sample02;

--Q3. 부서번호를 전달하여 해당 부서에 소속된 사원의 정보를 출력하는 프로시저를 커서를 이용해서 처리하세요?
--1. 저장 프로시저 생성
create or replace procedure info_emp(vdeptno in emp.deptno%type)
is
    vemp emp%rowtype;
    
    cursor c1
    is
    select * from emp where deptno = vdeptno;
begin
    DBMS_OUTPUT.PUT_LINE('부서번호 / 사원번호 / 사원명 / 직급 / 급여');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    
    for vemp in c1 loop
        exit when c1%notfound;
        DBMS_OUTPUT.put_line(vemp.deptno||'/'||vemp.empno||'/'||vemp.ename||'/'||vemp.job||'/'||vemp.sal);
    end loop;
end;

--2. 프로시저 목록 확인
select * from user_source;

--3. 프로시저 실행
execute info_emp(10);
execute info_emp(20);
execute info_emp(30);
execute info_emp(40);
-------------------------------------------------------------------------------------------------
-- 패키지(package) = 저장 함수 + 저장 프로시저

--1. 패키지 헤드 생성
create or replace package exam_pack
is
    function cal_bonus(vempno in emp.empno%type)    -- 저장 함수
        return number;
    procedure cursor_sample02;  -- 저장 프로시저
end;

--2. 패키지 바디 생성
create or replace package body exam_pack
is
    -- 저장 함수 : cal_bonus()
    function cal_bonus(vempno in emp.empno%type)
        return number   -- 돌려줄 값의 자료형
    is
        vsal number(7,2);    -- 로컬 변수
    begin
        select sal into vsal from emp where empno = vempno;
        return vsal * 2;
    end;
    -- 저장 프로시저 : cursor_sample02
    procedure cursor_sample02
    is
        vdept dept%rowtype; -- 로컬변수
    
        cursor c1   -- 커서 선언
        is
        select * from dept;
    begin
        DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
        DBMS_OUTPUT.PUT_LINE('------------------------');
    
        for vdept in c1 loop
            exit when c1%notfound;  -- 커서가 가져올 데이터가 없을 때 true
            DBMS_OUTPUT.PUT_LINE(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);    
        end loop;
    end;
    
end;

--3. 패키지 목록 확인
select * from user_source;

--4. 저장 프로시저 실행 : cursor_sample02
execute exam_pack.cursor_sample02;

--5. 저장 함수 실행 : cal_bonus()
-- 바인드 변수 생성
variable var_res number;

execute :var_res := exam_pack.cal_bonus(7788);
print var_res;

-- SQL문으로 저장함수 실행
select ename, exam_pack.cal_bonus(7788) from emp where empno = 7788;
--------------------------------------------------------------------------------------------
-- 트리거(trigger)

--Q1. 사원 테이블에서 사원이 등록되면, "신입사원이 입사했습니다."를 출력하는 트리거 생성 하세요?
--1. emp01 테이블 생성
drop table emp01 purge;
create table emp01( 
    empno number(4) primary key,    -- 부모키가 된다.
    ename varchar2(20),
    job varchar2(20));
select * from tab;

--2. 트리거 생성
create or replace trigger tgr_01
    after insert on emp01   -- 이벤트 발생
begin
    DBMS_Output.Put_Line('신입사원이 입사했습니다.');
end;

--3. 트리거 목록 확인
select * from user_triggers;

--4. 이벤트 발생 : emp01 테이블에 데이터 입력
SET SERVEROUTPUT ON
insert into emp01 values(1111, '홍길동', '개발자');
insert into emp01 values(1112, '홍길동', '개발자');
insert into emp01 values(1113, '홍길동', '개발자');


--Q2. 사원 테이블(EMP01)에 신입사원이 등록되면, 급여 테이블(SAL01)에 급여 정보를 자동으로 추가해주는
--  트리거를 생성 하세요?
--1. 사원 테이블 생성 : EMP01
delete from emp01;
commit;
select * from emp01;

--2. 급여 테이블 생성 : SAL01
create table sal01(
    salno number(4) primary key,    -- 기본키
    sal number(7,2),
    empno number(4) references emp01(empno));   -- 외래키(foreign key)

select * from tab;

--3. 시퀀스 생성
create sequence sal01_salno_seq;    -- 1부터 1씩 증가되는 시퀀스 생성됨

select * from user_sequences;

--4. 트리거 생성
create or replace trigger trg_02
    after insert on emp01   -- 이벤트 발생
    for each row    -- 행 레벨 트리거 
begin
    insert into sal01 values(sal01_salno_seq.nextval, 100, :new.empno); --:new는 임시 테이블 역할
end;                                                                    

--5. 트리거 목록 확인
select * from user_triggers;

--6. 이벤트 발생 : 회원가입
insert into emp01 values(1111, '홍길동', '개발자');
insert into emp01 values(1112, '안화수', '개발자');
insert into emp01 values(1113, '이순신', '개발자');

--7. 데이터 확인
select * from emp01;
select * from sal01;

--Q3. 회원정보가 삭제되면, 급여정보를 자동으로 삭제하는 트리거를 생성하세요.
delete from emp01 where empno =1111;    -- 삭제 안됨

--1. 트리거 생성
create or replace trigger trg_03
    after delete on emp01   -- 이벤트 발생
    for each row
begin
    delete from sal01 where empno = :old.empno;
end;

--2. 트리거 목록 확인
select * from user_triggers;

--3. 이벤트 발생
-- :사원 테이블(EMP01)의 사원번호 1111번 사원을 삭제(탈퇴)하면 연쇄적으로 급여 테이블(SAL01)의 급여
--  정보도 같이 삭제된다.
delete from emp01 where empno = 1111;
delete from emp01 where empno = 1112;
delete from emp01 where empno = 1113;

--4. 결과 확인
select * from emp01;
select * from sal01;