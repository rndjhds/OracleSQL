---- summary(2022_01_25 ~ 2022_01_26)

--4. 형변환 함수 : to_char(), to_number(), t0_date()

-- 1. to_char() : 숫자형, 날짜형 데이터를 문자형으로 변환시켜주는 함수이다.

--  1) 날짜형 데이터를 문자형으로 변환
--  날짜형->문자형 : to_char(날짜 데이터, '출력형식')
--Q. 현재 시스템의 날짜를 년,월,일,시,분,초,요일로 출력
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss day') from dual; -- 24시간제
select to_char(sysdate, 'yyyy/mm/dd pm hh:mi:ss day') from dual; -- 12시간제  오후 : pm 오전 : am

--Q. 사원 테이블에서 각 사원들의 입사일을 년,월,일,시,분,초,요일을 출력하는 SQL문 작성?
select ename, empno, deptno, to_char(hiredate, 'yyyy/mm/dd hh24:mi:ss day') from emp; 

--  2) 숫자형 데이터를 문자형으로 변환
-- 숫자형 -> 문자형  : to_char(숫자 데이터, '구분기호')
--Q. 숫자 1230000을 3자리씩 컴마로 구분해서 출력
select 1230000 from dual;

-- 0으로 자리수를 지정하면, 데이터의 길이가 9자리가 되지않으면 0으로 채운다.
select 1230000, to_char(1230000, '000,000,000') from dual;

-- 9로 자리수를 지정하면, 데이터의 길이가 9자리가 되지 않아도 채우지 않는다.
select  1230000, to_char(1230000, '999,999,999') from dual;

--Q. 사원 테이블에서 각 사원들의 급여를 3자리씩 컴마(,)로 구분해서 출력하는 SQL문 작성?
select ename, sal, to_char(sal, '999,999,999') from emp;
select ename, sal, to_char(sal, '9,999') from emp;
select ename, sal, to_char(sal, 'L9,999') from emp; -- L은 국가의 통화기호를 나타내준다.
select ename, sal, to_char(sal, '9,999L') from emp;

--2. to_date() : 문자형 데이터를 날짜형으로 변환 시켜주는 함수
-- 형식 : to_date('문자', '날짜 format')
--Q. 2022년 1월1일 부터 현재까지 경과된 일수를 구하는 SQL문 작성?
select sysdate - '2022/01/01' from dual; -- 오류 발생

select sysdate - to_date('2022/01/01', 'yyyy/mm/dd') from dual;
select trunc(sysdate - to_date('2022/01/01', 'yyyy/mm/dd')) from dual;
select round(sysdate - to_date('2022/01/01', 'yyyy/mm/dd')) from dual;

--Q. 2022년 12월 25일 크리스마스까지 남은 일수를 구하는 SQL문 작성?
select to_date('2022/12/25', 'yyyy/mm/dd') - sysdate from dual;
select trunc(to_date('2022/12/25', 'yyyy/mm/dd') -sysdate) from dual;
select round(to_date('2022/12/25', 'yyyy/mm/dd') - sysdate) from dual;

--Q. 남은 수료날짜 계산
select to_date('2022/06/08', 'yyyy/mm/dd') - sysdate from dual;
select trunc(to_date('2022/06/08', 'yyyy/mm/dd') - sysdate) from dual;
select round(to_date('2022/06/08', 'yyyy/mm/dd') - sysdate) from dual;

--3. to_number() : 문자형 데이터를 숫자형으로 변환 시켜주는 함수
-- 형식 : to_number('문자 데이터', '구분기호')
select '20,000' - '10,000' from dual; -- 오류발생 : 문자끼리는 산술연산이 불가능하다
select to_number('20,000', '99,999') - to_number('10,000', '99,999') from dual;
------------------------------------------------------------------------

-- nvl() : null값을 다른 값으로 변환해주는 함수
-- 1. null값은 정해지지 않은 값을 의미
-- 2. null값은 산술연산(+,-,*,/)이 되지 않는다.

--Q. 사원 테이블에 있는 각 사원들의 연봉을 계산하는 SQL문 작성?
-- 연봉 = 급여 * 12 + COMM
-- nvl(comm,0) : comm의 NULL값인 데이터를 0으로 변환
select ename, sal * 12 + nvl(comm, 0) 연봉 from emp;
-----------------------------------------------------------

-- decode() : switch ~ case n 구문과 유사하다 
-- 형식 : decode(컬럼명, 값1, 결과1,
--                     값2, 결과2,
--                     값3, 결과3,
--                     .........)

--Q. 사원 테이블에서 부서번호(deptno)를 부서명으로 바꿔서 출력하는 SQL문 작성?
select ename, deptno, decode(deptno, 10, 'ACCOUNTING',
                                     20, 'RESEARCH',
                                     30, 'SALES',
                                     40, 'OPERATIONS') as dname from emp;
------------------------------------------------------------------------------

-- case() : if ~ else if문과 유사하다
-- 형식 : case when 조건1 then 결과1
--            when 조건2 then 결과2
--            else 결과3
-- end

--Q. 사원 테이블에서 부서번호(deptno)를 부서명으로 바꿔서 출력하는 SQL문 작성?
select ename, deptno, case when deptno = 10 then 'ACCOUNTING'
                           when deptno = 20 then 'RESEARCH'
                           when deptno = 30 then 'SALES'
                           when deptno = 40 then 'OPERATIONS'
                           end as dname from emp; -- dname은 결과값의 컬럼별칭
-- decode보다 case가 더 많은 연산자를 쓸 수 있다.
--------------------------------------------------------------------------------

-- 그룹함수 : 하나 이상의 행을 그룹으로 묶어 연산하여 총합, 평균 등 하나의 결과로 나타낸다.
-- 그룹함수 : 하나 이상의 데이터를 그룹으로 묶어서 연산을 수행하고 하나의 결과로 처리해주는 함수

-- sum() : 합을 구해주는 함수
select sum(sal) from emp; -- 급여의 합
select sum(comm) from emp; -- comm의 합, null값은 제외한다
select sum(ename) from emp;  -- 오류발생: 문자데이터는 산술연산을 할 수 없다.

select sum(sal), sum(comm) from emp; --그룹함수끼리는 사용 가능하다.
select sal, sum(sal) from emp;
-- 오류 발생 : 그룹함수는 하나의 결과로 처리하지만 sal은 14개의 결과로 출력하기 때문에 오류가 발생한다.
-- 일반 컬럼은 그룹함수와 같이 사용할 수 없다.

select sum(sal) from emp where deptno = 10; --8750
select sum(sal) from emp where deptno = 20; --10875
select sum(sal) from emp where deptno = 30; --9400
select sum(sal) from emp where deptno = 40; --null

-- avg() : 평균값을 구해주는 함수
select avg(sal) from emp;
select avg(sal), avg(comm) from emp;
select avg(sal), avg(comm) from emp where deptno = 10;
select avg(sal), avg(comm) from emp where deptno = 20;
select avg(sal), avg(comm) from emp where deptno = 30;

-- max() : 최대값을 구해주는 함수
select max(sal) from emp; -- 5000
select ename, mas(sal) from emp;
-- 오류 발생 : 그룹함수는 하나의 결과로 처리하지만 ename은 14개의 결과로 출력하기 때문에 오류가 발생한다.
-- 일반 컬럼은 그룹함수와 같이 사용할 수 없다.

select max(sal) from emp where deptno = 10; -- 5000
select max(sal) from emp where deptno = 20; -- 3000
select max(sal) from emp where deptno = 30; -- 2850

--Q. 사원 테이블에서 가장 최근에 입사한 입사일을 출력하는 SQL문 작성?
select max(hiredate) from emp; -- 87/07/13

--Q1. 사원 테이블(EMP)에서 가장 최근에 입사한 사원명을 출력하는 SQL문을 작성하세요?
select ename, hiredate from emp where hiredate = (select max(hiredate) from emp);
--Q2. 사원 테이블(EMP)에서 최대 급여를 받는 사원명과 최대급여 금액을 출력하는 SQL문 작성 하세요?
select ename, sal from emp where sal = (select max(sal) from emp);

-- min() : 최소값을 구해주는 함수
select min(sal) from emp; -- 800
select min(sal) from emp where deptno = 10; -- 1300
select min(sal) from emp where deptno = 20; -- 800
select min(sal) from emp where deptno = 30; -- 950

--Q. 사원 테이블에서 가장 먼저 입사한 입사일을 구하는 SQL문 작성?
select min(hiredate) from emp; -- 80/12/17

select min(ename) from emp; -- ADAMS
select ename from emp order by ename asc; -- 오름차순 정렬(사전순 정렬)

select max(ename) from emp; -- WARD
select ename from emp order by ename desc; -- 내림차순 정렬(사전역순 정렬)

select sum(sal), avg(sal), max(sal), min(sal) from emp;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 10;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 20;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 30;

-- count() : 총 데이터 갯수를 구해주는 함수
select count(sal) from emp; -- 14
select count(mgr) from emp; -- 13 : null값은 counting을 하지 않는다.
select count(comm) from emp; -- 4 : null값은 counting을 하지 않는다.
select count(empno) from emp; -- 14 : empno컬럼은 기본키 제약조건이 설정되어 있다.
select count(*) from emp; -- 14

--Q. 사원 테이블에서 JOB갯수
select count(job) from emp; -- 14 : 중복 데이터도 counting한다
select job from emp;
select distinct(job) from emp; -- 중복행을 제거한 JOB출력
select count(distinct(job)) from emp; -- 중복행을 제거한 JOB의 갯수출력

--Q. 가장 최근에 입사한 사원의 입사일과 가장 먼저 입사한 사원의 입사일을 구하는 SQL문 작성?
select max(hiredate), min(hiredate) from emp;

--Q. 30번 부서 소속 사원 중에서 커미션을 받는 사원수를 구하는 SQL문 작성?
select count(comm) from emp where deptno = 30; -- count()는 null값을 세지 않는다.
-------------------------------------------------------------------------

-- group by
-- : 특정 컬럼을 기준으로 테이블에 존재하는 데이터를 그룹으로 구분하여 처리해주는 역할을 한다.

--Q. 각 부서(10,20,30)의 급여의 합, 평균급여, 최대급여, 최소급여를 구하는 SQL문 작성?
select deptno, sum(sal), avg(sal), max(sal), min(sal) from emp group by deptno;
-- 그룹함수와 일반컬럼은 같이 사용할 수 없지만, 예외적으로 group by 절에 사용되는 컬럼은
-- 예외적으로 그룹함수와 같이 사용할 수 있다.
select deptno, sum(sal), avg(sal), max(sal), min(sal) from emp 
    group by deptno order by deptno asc;

--Q. JOB컬럼을 기준으로 급여의 합, 평균급여, 최대급여, 최소급여를 구하는 SQL문 작성?
select job, sum(sal), avg(sal), max(sal), min(sal) from emp group by job;

--Q. 각 부서(10,20,30)별 사원수와 커미션을 받는 사원의 수를 구하는 SQL문 작성?
select deptno, count(*) 사원수, count(comm) 커미션 from emp group by deptno;

-- having 조건절
-- : group by 절이 사용되는 경우에 데이터 제한을 가하기 위해서는 where조건절 대신에
-- having 조건절을 사용해야 한다.

--Q. 각 부서별 평균급여 금액이 2000이상인 부서만 출력하는 SQL문 작성?
select deptno, avg(sal) from emp group by deptno having avg(sal) >= 2000;

--Q. 각 부서별 최대급여 금액이 2900 이상인 부서만 출력하는 SQL문 작성?
select deptno, max(sal) from emp group by deptno having max(sal) >= 2900;
-------------------------------------------------------------------------------------------

-- 조인(join)
-- : 2개 이상의 테이블을 결합해서 정보를 구해오는 것

--Q. SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성?
-- 사원은 emp테이블 부서명은 deptno테이블
-- 1. 사원 테이블(EMP)에서 SCOTT사원의 부서번호를 구한다.
select ename, deptno from emp where ename = 'SCOTT'; -- 20번 출력
-- 2. 부서 테이블(DEPT)에서 20번 부서의 부서명을 구한다.
select dname, deptno from dept where deptno = 20; -- RESEARCH

select ename, dname, emp.deptno from emp, dept where dept.deptno = emp. deptno and ename = 'SCOTT';

-- CROSS JOIN
-- 두개의 테이블을 조인하는걸 CROSS JOIN이라고 한다.
select * from dept, emp; -- 4 * 14 = 56개 데이터 검색
select * from emp, dept; -- 14 * 4 = 56개 데이터 검색

-- CROSS JOIN의 종류
--1. 등가 조인(Equi Join) -- 가장 많이 쓰이는 Join
--2. 비등가 조인(Non-Equi-Join)
--3. 자체 조인(Self Join)
--4. 외부 조인(Outer join)

-- 1. 등가 조인(Equi Join)
-- : 두 테이블에 동일한 컬럼을 기준으로 JOIN
select * from dept, emp where dept.deptno = emp.deptno; -- 14개 데이터 검색

--Q. SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성?
select ename, dname from dept, emp
    where dept.deptno = emp.deptno and ename = 'SCOTT';
    
-- 공통컬럼(deptno)은 테이블명.공통컬럼명 형식으로 출력해야 한다.
-- 공통컬럼이 아닌 컬럼들은 앞에 테이블명을 생략할 수 있다.
select deptno, ename, dname from dept,emp 
    where dept.deptno = emp.deptno and ename = 'SCOTT'; -- 오류발생
    
-- 해결
select emp.deptno, ename, dname from dept, emp
    where dept.deptno = emp.deptno and ename = 'SCOTT';
select dept.deptno, ename, dname from dept, emp
    where dept.deptno = emp.deptno and ename = 'SCOTT';    
    
-- 테이블에 별칭 부여하기
--1. 테이블에 대한 별칭이 부여된 다음부터는 테이블명을 사용할 수 없고, 별칭명만 사용해야 한다.
--2. 별칭명은 대.소문자 구분하지 않습니다.
--3. 공통컬럼(deptno)은 별칭명.공통컬럼명 형식으로 사용해야 한다. ex)D.deptno
--4. 공통컬럼이 아닌 컬럼들은 앞에 별칭명을 생략할 수 있다.

select D.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno = E.deptno and E.ename = 'SCOTT';
    
-- 별칭명은 대소문자를 구분하지 않는다.
select d.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno = E.deptno and E.ename = 'SCOTT';

-- 오류발생 : 별칭이 부여된 다음부터는 테이블명을 사용할 수 없다.
select DEPT.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno = E.deptno and E.ename = 'SCOTT';
    
-- 일반컬럼은 앞에 별칭명을 생략할 수 있다.
select D.deptno, ename, dname from dept D, emp E
    where D.deptno = E.deptno and E.ename = 'SCOTT';
    
-- 2. 비등가 조인(Non-Equi Join)
-- : 두 테이블에 동일한 컬럼없이 다른 조건을 사용하여 JOIN

--Q. 사원 테이블에 있는 각 사원들의 급여가 몇 등급인지를 출력하는 SQL문 작성?
-- EMP(SAL) - SALGRADE(GRADE)

select ename, sal, grade from emp, salgrade
    where sal >= losal and sal <= hisal;
    
select ename, sal, grade from emp, salgrade
    where sal between losal and hisal;

select e.ename, e.sal, s.grade from emp e, salgrade s
    where e.sal between s.losal and s.hisal;

--3. 자체 조인(Self Join)
-- : 한개의 테이블 내에서 컬럼과 컬럼 사이의 관계를 이용해서 조인

--Q. 자체조인(Self Join)을 이용해서 사원 테이블의 각 사원들의 사원명과 매니저(= 직속상관)를 출력하는 
-- SQL문 작성?
-- EMP(EMPNO) - EMP(MGR)

select employee.ename || '의 매니저는' || manager.ename
    from emp employee, emp manager
    where employee.mgr = manager.empno;

-- 13개 데이터 검색 결과가 출력된다.
-- KING 사원은 직속상관이 없기 때문에 출력되지 않는다.

--4. 외부 조인(Outer Join)
-- : 조인 조건을 만족하지 않는 데이터를 출력해주는 JOIN
-- 1) 테이블을 조인할때 어느 한쪽의 테이블에는 데이터가 존재하지만,
-- 다른 테이블에는 존재하지 않는 경우에, 그 데이터가 출력되지 않는 문제를 해결하기 위해서 
-- 사용되는 조인 방법
-- 2) 정보가 부족한 곳에 (+)를 추가한다.

--Q1. 위의 자체조인(Self Join)의 결과, KING사원은 직속상관이 없기 때문에 출력되지 않았는데
-- KING 사원도 외부조인을 이용해서 출력 하세요?
select employee.ename || '의 매니저는'|| manager.ename
    from emp employee, emp manager
    where employee.mgr = manager.empno(+); 
    
--Q2. 부서테이블(DEPT)의 40번 부서는 조인할 사원테이블(EMP)의 부서번호에는 나타나지 않지만, 40번
-- 부서의 부서명을 출력하는 SQL문 작성?
select ename, d.deptno, dname from dept d, emp e
    where d.deptno = e.deptno(+) order by deptno asc;

-------------------------------------------------------------------------------------
-- ANSI JOIN
-- : ANSI(미국 표준 협회) 표준안에 따라서 만들어진 JOIN 방법

-- ANSI CROSS JOIN : 일반 CROSS JOIN과 똑같다.
select * from dept cross join emp;  -- 4* 14 = 56개 데이터 검색
select * from emp cross join dept;  -- 14 * 4 = 56개 데이터 검색

-- ANSI INNER JOIN : 등가 조인과 같은 의미를 가지고 있는 조인 방법
--Q. SCOTT사원이 소속된 부서명을 출력하는 SQL문 작성?
select ename, dname from emp inner join dept
    on emp.deptno = dept.deptno where ename = 'SCOTT';

-- using을 이용해서 조인
select ename, dname from emp inner join dept
    using(deptno) where ename = 'SCOTT';
    
-- ANSI MATURAL JOIN : 등가 조인과 같은 의미를 가지고 있는 조인 방법
-- DEPT와 EMP테이블 사이의 공통 컬럼이 같다는 의미를 가지고 있음
select ename, dname from emp natural join dept where ename = 'SCOTT';

--Q1. 직급이 MANGER인 사원의 이름, 부서명을 출력하는 SQL문 작성하세요? (JOIN을 사용하여 처리)
select ename, dname, emp.deptno from emp, dept where emp.deptno = dept.deptno and job = 'MANAGER';
select ename, dname, emp.deptno from emp inner join dept on emp.deptno = dept.deptno where job = 'MANAGER';
select ename, dname, deptno from emp inner join dept using(deptno) where job = 'MANAGER';
select ename, dname, deptno from emp natural join dept where job = 'MANAGER';

--Q2. 매니저가 KING인 사원들의 이름과 직급을 출력하는 SQL문 작성?
select ename, job from emp where mgr = (select empno from emp where ename = 'KING');
select employee.ename, employee.job from emp employee, emp manager 
    where employee.mgr = manager.empno and manager.ename = 'KING'; -- Self Join
    
--Q3. SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하는 SQL문 작성?
select ename, loc from emp, dept where emp.deptno = dept.deptno   
    and emp.deptno = (select deptno from emp where ename = 'SCOTT');

-- ANSI OUTER JOIN
-- 형식 : select * from table1 [left, right, full] outer join table2;

-- 1. dept01 테이블 생성
create table dept01(deptno number(2), dname varchar2(14));
insert into dept01 values(10, 'ACCOUTING');
insert into dept01 values(20, 'RESEARCH');
select * from dept01;

-- 2. dept02 테이블 생성
create table dept02(deptno number(2), dname varchar2(14));
insert into dept02 values(10, 'ACCOUNTING');
insert into dept02 values(30, 'SALES');
select * from dept02;

--3. left outer join : dept01 테이블 정보만 출력됨
select * from dept01 left outer join dept02 using(deptno);

--4. right outer join : dept02 테이블 정보만 출력됨
select * from dept01 right outer join dept02 using(deptno);

--5. full outer join : dept01, dept02 테이블 모든 정보가 출력됨
select * from dept01 full outer join dept02 using(deptno);

----------------------------------------------------------------------------------
-- 서브 쿼리

--Q. SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성?
select dname from dept where deptno = (select deptno from emp where ename = 'SCOTT');

-- join으로 구하기
select dname from emp, dept where emp.deptno = dept.deptno and ename = 'SCOTT';
select dname from emp inner join dept on emp.deptno = dept.deptno where ename = 'SCOTT';
select dname from emp inner join dept using(deptno) where ename = 'SCOTT';
select dname from emp natural join dept where ename = 'SCOTT';

--1. 단일행 서브쿼리
-- 1) 서브쿼리의 검색결과가 1개만 반환되는 쿼리
-- 2) 메인쿼리의 where 조건절에서 비교연산자만 사용가능(=,>,>=,<,<=,!=)

--Q. 사원 테이블에서 가장 최근에 입사한 사원명을 출력하는 SQL문 작성?
select hiredate, ename from emp where hiredate = (select max(hiredate) from emp);

--Q. 사원 테이블에서 최대급여를 받는 사원명과 최대급여 금액을 출력하는 SQL문 작성?
select ename, sal from emp where sal = (select max(sal) from emp);

--Q. 직속상관(MGR)이 KING인 사원의 사원명과 급여를 출력하는 SQL문 작성?
select ename, sal from emp where mgr = (select empno from emp where ename = 'KING');

--2. 다중행 서브쿼리
-- 1) 서브쿼리에서 반환되는 검색결과가 2개 이상인 서브쿼리
-- 2) 메인쿼리의 where 조건절에서 다행중 연산자(in,all,any..)를 사용해야 한다.

-- <in연산자>
-- : 서브쿼리의 검색 결과 중에서 하나라도 일치되면 참이 된다.

--Q. 급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원들의 정보를 출력하는 SQL문 작성?
select ename, sal, deptno from emp where deptno in (select distinct deptno from emp where sal >= 3000);

--<all 연산자>
-- : 메인 쿼리의 비교 조건이 서브쿼리의 검색결과와 모든 값이 일치하면 참이 된다.

--Q. 30번 부서에 소속된 사원중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 사원의 이름과 급여를 출력하는 
--   SQL문 작성?
select ename, sal from emp where sal > (select max(sal) from emp where deptno = 30); 
select ename, sal from emp where sal > all(select sal from emp where deptno = 30);

--<any 연산자>
-- : 메인쿼리의 비교 조건이 서브쿼리의 검색 결과와 하나이상이 일치되면 참이 된다.

--Q. 부서번호가 30번인 사원들의 급여중 가장 낮은 급여(950)보다 높은 급여를 받는 사원명과 급여를 출력하는 SQL문 작성?
select ename, sal from emp where sal > (select min(sal) from emp where deptno = 30);
select ename, sal from emp where sal > any(select sal from emp where deptno = 30);



