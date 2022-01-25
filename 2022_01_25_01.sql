-- 2022.01.25(화)

-- 4. 형변환 함수 : to_char(), to_date(), to_number()

--1. to_char() : 숫자형, 날짜형 데이터를 문자형으로 변환시켜주는 함수이다.

-- 1) 날짜형 데이터를 문자형으로 변환
-- 날짜형->문자형 : to_char(날짜 데이터, '출력형식')
--Q. 현재 시스템의 날짜를 년,월,일,시,분,초,요일로 출력
select sysdate from dual; -- 22/01/25
select sysdate, to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss day') from dual; -- 24시간제
--                                  년  월 일   시 분  초  요일
select sysdate, to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual; -- 12시간제
--                                  년  월 일 오전 시 분 초 요일                 오후일시(am 대신 pm)

--Q. 사원 테이블에서 각 사원들의 입사일을 년,월,일,시,분,초,요일을 출력하는 SQL문 작성?
select ename ,hiredate, to_char(hiredate, 'yyyy-mm-dd hh24:mi:ss day') from emp;
select hiredate, to_char(hiredate, 'yyyy/mm/dd hh24:mi:ss day') from emp;

-- 2) 숫자형 데이터를 문자형으로 변환
-- 숫자형 -> 문자형 : to_char(숫자 데이터, 구분기호')
--Q. 숫자 1230000을 3자리씩 컴마로 구분해서 출력
select 1230000 from dual;

-- 0으로 자리수를 지정하면, 데이터의 길이가 9자리가 되지 않으면 0으로 채운다.
select 1230000, to_char(1230000, '000,000,000') from emp;

-- 9으로 자리수를 지정하면, 데이터의 길이가 9자리가 되지 않아도 채우지 않는다.
select 1230000, to_char(1230000, '999,999,999') from emp;

--Q. 사원테이블에서 각 사원들의 급여를 3자리씩 컴마(,)로 구분해서 출력하는 SQL문 작성?
select ename, sal, to_char(sal, '999,999,999') from emp;
select ename, sal, to_char(sal, '9,999') from emp;
select ename, sal, to_char(sal, 'L9,999') from emp; -- L은 국가의 통화기호를 나타내준다.
select ename, sal, to_char(sal, '9,999L') from emp;

--2. to_date() : 문자형 데이터을 날짜형으로 변환 시켜주는 함수
-- to_date('문자', '날짜 format')
--Q. 2022년 1월 1일부터 현재까지 경과된 일수를 구하는 SQL문 작성?
select sysdate - '2022/01/01' from dual; -- 오류발생

select sysdate - to_date('2022/01/01', 'yyyy/mm/dd') from dual;
select trunc(sysdate - to_date('2022/01/01', 'yyyy/mm/dd')) from dual;
select round(sysdate - to_date('2022/01/01', 'yyyy/mm/dd')) from dual;

--Q. 2022년 12월 25일 크리스마스까지 남은 일수를 구하는 SQL문 작성?
select '2022/12/25' - sysdate from dual; -- 오류발생
select to_date('2022/12/25', 'yyyy/mm,dd') - sysdate from dual;
select round(to_date('2022/12/25', 'yyyy/mm,dd') - sysdate) from dual;
select trunc(to_date('2022/12/25', 'yyyy/mm,dd') - sysdate) from dual;

--Q. 남은 수료날짜 계산
select to_date('2022/06/08', 'yyyy/mm/dd') -sysdate from dual;
select trunc(to_date('2022/06/08', 'yyyy/mm/dd') -sysdate) from dual;
select round(to_date('2022/06/08', 'yyyy/mm/dd') -sysdate) from dual;

--3. to_number() : 문자형 데이터를 숫자형으로 변환 시켜주는 함수
-- to_number('문자 데이터', '구분기호')
select '20,000' - '10,000' from dual; -- 오류발생 : 문자끼리는 산술연산 불가능
select to_number('20,000', '99,999') - to_number('10,000', '99,999') from dual;

--------------------------------------------------------------------------------------
-- nvl() : null값을 다른 값으로 변환해주는 함수
-- 1. null값은 정해지지 않은 값을 의미
-- 2. null값은 산술연산(+,-,/,*)이 되지 않는다.

--Q 사원 테이블에 있는 각 사원들의 연봉을 계산하는 SQL문 작성?
-- 연봉 = 급여(SAL) * 12 + COMM
-- nvl(comm, 0) : comm의 NULL값인 데이터를 0으로 변환
select ename, sal * 12 + nvl(comm, 0) as "연봉" from emp;
select ename, sal * 12 + nvl(comm, 0) 연봉 from emp; -- as와 쌍따옴표는 생략가능
---------------------------------------------------------------------------------------
-- decode() : switch ~ case n 구문과 유사
-- decode( 컬럼명, 값1, 결과1,
--                값2, 결과2,
--                값3, 결과3,
--                ..........)

--Q. 사원 테이블에서 부서번호(deptno)를 부서명으로 바꿔서 출력하는 SQL문 작성?
select ename, deptno, decode(deptno, 10, 'ACCOUNTING',
                                     20, 'RESEARCH',
                                     30, 'SALES',
                                     40, 'OPERATIONS') as dname from emp;
--------------------------------------------------------------------------------------------
-- case() : if ~ else if문과 유사
-- case when 조건1 then 결과1
--      when 조건2 then 결과2
--      else 결과3
-- end

--Q. 사원 테이블에서 부서번호(deptno)를 부서명으로 바꿔서 출력하는 SQL문 작성?
select ename, deptno, case when deptno=10 then 'ACCOUNTING'
                           when deptno=20 then 'RESEARCH'
                           when deptno=30 then 'SALES'
                           when deptno=40 then 'OPERATIONS'
                           end as dname from emp;
-- decode보다 case가 더 많은 연산자를 쓸 수 있다. 
--------------------------------------------------------------------------

-- 그룹함수 : 하나 이상의 행을 그룹으로 묶어 연산하여 총합, 평균 등 하나의 결과로 나타낸다.
-- 그룹함수 : 하나 이상의 데이터를 그룹으로 묶어서 연산을 수행하고
--          하나의 결과로 처리해주는 함수

-- sum() : 합을 구해주는 함수
select sum(sal) from emp; -- 급여의 합
select sum(comm) from emp; -- comm의 합, null값은 제외
select sum(ename) from emp; -- 오류발생 : 문자데이터는 산술연산을 할 수 없기 때문

select sum(sal), sum(comm) from emp; -- 그룹함수끼리 사용 가능함.
select sal, sum(sal) from emp; -- 오류발생 : 그룹함수는 하나의 결과로 처리하지만
--                                          sal은 14개를 출력해서 오류가 발생한다.
--                                          그룹함수와 일반컬럼은 같이 사용할 수 없다.

select sum(sal) from emp where deptno = 10; -- 8750
select sum(sal) from emp where deptno = 20; -- 10875
select sum(sal) from emp where deptno = 30; -- 9400
select sum(sal) from emp where deptno = 40; -- null

-- avg() : 평균값을 구해주는 함수
select avg(sal) from emp;
select avg(sal), avg(comm) from emp;
select sum(sal), avg(sal) from emp where deptno = 10;
select sum(sal), avg(sal) from emp where deptno = 20;
select sum(sal), avg(sal) from emp where deptno = 30;

-- max() : 최대값을 구해주는 함수
select max(sal) from emp; -- 5000
select ename, max(sal) from emp; -- 오류발생 : 그룹함수는 하나의 결과로 처리하지만
--                                            ename은 14개를 출력해서 오류가 발생한다.
--                                            그룹함수와 일반컬럼은 같이 사용할 수 없다.
select max(sal) from emp where deptno = 10; -- 5000
select max(sal) from emp where deptno = 20; -- 3000
select max(sal) from emp where deptno = 30; -- 2850

--Q. 사원 테이블에서 가장 최근에 입사한 입사일을 출력하는 SQL문 작성?
select max(hiredate) from emp; -- 87/07/13


--Q1. 사원 테이블(EMP)에서 가장 최근에 입사한 사원명을 출력 
--	  하는 SQL문을 작성 하세요?

--Q2. 사원 테이블(EMP)에서 최대 급여를 받는 사원명과 최대급여
--    금액을 출력하는 SQL문을 작성 하세요?
    
     Ans1. SQL> select ename, hiredate from emp where hiredate=
		(select max(hiredate) from emp);

     Ans2. SQL> select ename, sal from emp where sal=
		(select max(sal) from emp);

-- min() : 최소값을 구해주는 함수
select min(sal) from emp; -- 800
select min(sal) from emp where deptno = 10; -- 1300
select min(sal) from emp where deptno = 20; -- 800
select min(sal) from emp where deptno = 30; -- 950

--Q. 사원 테이블에서 가장 먼저 입사한 입사일을 구하는 SQL문 작성?
select min(hiredate) from emp; -- 80/12/17

select min(ename) from emp; -- ADAMS
select ename from emp order by ename asc;   -- 오름차순 정렬(사전순 정렬)

select max(ename) from emp; --WARD
select ename from emp order by ename desc;  -- 내림차순(사전역순 정렬)

select sum(sal), avg(sal), max(sal), min(sal) from emp;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 10;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 20;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 30;

-- count() : 총 데이터 갯수를 구해주는 함수
select count(sal) from emp; -- 14
select count(mgr) from emp; -- 13 : null값은 counting을 하지 않는다.
select count(comm) from emp; -- 4 : null값은 counting을 하지 않는다.
select count(empno) from emp; -- 14 : empno 컬럼은 기본키 제약조건이 설정되어 있다.
select count(*) from emp; -- 14 

--Q. 사원 테이블에서 JOB갯수
select count(job) from emp; -- 14 : 중복 데이터도 counting한다.
select job from emp;
select distinct job from emp; -- 중복행을 제거한 JOB출력

--중복행을 제거한 JOB의 갯수 구하기
select count(distinct job) from emp; -- 5

--Q. 가장 최근에 입사한 사원의 입사일과 가장 먼저 입사한 사원의 입사일을 구하는 SQL문 작성?
select max(hiredate) 최근입사, min(hiredate) 먼저입사 from emp;

--Q. 30번 부서 소속 사원 중에서 커미션을 받는 사원수를 구하는 SQL문 작성?
select count(comm) from emp where deptno = 30;

----------------------------------------------------------------------------------------
-- group by
-- : 특정 컬럼을 기준으로 테이블에 존재하는 데이터를 그룹으로 구분하여 처리해주는 역할을 한다.

--Q. 각 부서(10,20,30)의 급여의 합, 평균급여, 최대급여, 최소급여를 구하는 SQL문 작성?
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 10;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 20;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno = 30;

-- 그룹함수와 일반컬럼은 같이 사용할 수 없지만, 예외적으로 group by 절에
-- 사용되는 컬럼은 예외적으로 그룹함수와 같이 사용할 수 있다.
select deptno, sum(sal), avg(sal), max(sal), min(sal) from emp
group by deptno; -- deptno의 값으로 그룹을 만들고 나눔

select deptno, sum(sal), avg(sal), max(sal), min(sal) from emp
    group by deptno order by deptno asc;

--Q. JOB컬럼을 기준으로 급여의 합, 평균급여, 최대급여, 최소급여를 구하는 SQL문 작성?
select job, sum(sal), avg(sal), max(sal), min(sal) from emp 
    group by job; -- job의 값으로 그룹을 만들고 나눔
    
--Q. 각 부서(10,20,30)별 사원수와 커미션을 받는 사원의 수를 구하는 SQL문 작성?
select deptno, count(*) 사원수, count(comm)  커미션 from emp 
    group by deptno order by deptno asc;
    
-- having 조건절 
-- : group by절이 사용되는 경우에 데이터 제한을 가하기 위해서는 where조건절 
-- 대신에 having 조건절을 사용해야 한다.

--Q. 각 부서별 평균급여 금액이 2000 이상인 부서만 출력하는 SQL문 작성?
select deptno, avg(sal) from emp group by deptno;

select deptno, avg(sal) from emp group by deptno 
    where avg(sal) >= 2000; -- 오류발생
select deptno, avg(sal) from emp group by deptno 
    having avg(sal) >= 2000;
    
--Q. 각 부서별 최대급여 금액이 2900 이상인 부서만 출력하는 SQL문 작성?
select deptno, max(sal) from emp group by deptno;

select deptno, max(sal) from emp group by deptno;
    where max(sal) >= 2900; -- 오류발생
select deptno, max(sal) from emp group by deptno 
    having max(sal) >= 2900;





