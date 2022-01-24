-- 2022.01.24(월)

-- null 값 검색
-- EMP 테이블 : MGR컬럼, COMM컬럼

--Q. MGR컬럼에 null값인 데이터를 검색?
select ename, job, mgr from emp where mgr = null; -- 검색안됨
select ename, job, mgr from emp where mgr = ''; --검색안됨

select ename, job, mgr from emp where mgr is null;

--Q. MGR컬럼에 null값이 아닌 데이터를 검색?
select ename, job, mgr from emp where mgr is not null;

--Q. COMM컬럼에 null값인 데이터를 검색?
select ename, job, mgr from emp where comm = null; -- 검색안됨
select ename, job, mgr from emp where comm = ''; --검색안됨
select ename, job, mgr from emp where comm is null;

--Q. COMM컬럼에 null값이 아닌 데이터를 검색?
select ename, job, mgr from emp where comm is not null;

--과제.
-- Q1. 사원테이블(EMP)에서 입사일(HIREDATE)을 4자리 연도로 출력                                
--           되도록 SQL문을 작성하세요? (ex. 1980/01/01)

-- Q2. 사원테이블(EMP)에서 MGR컬럼의  값이  null 인 데이터의 MGR                              
--          컬럼의 값을  CEO 로  출력하는 SQL문을 작성 하세요?     


     Ans1. SQL> select  to_char(hiredate,'YYYY/MM/DD') from emp;

     Ans2. SQL> select ename, nvl(to_char(mgr,'9999'), 'CEO')  -- '9999'는 자리 맞추기 위해서 쓴 값이다.	         	                               
                    as	 MANAGER  from emp where mgr  is  null;
-------------------------------------------------------------------------------------------
-- 정렬 : order by 컬럼명 정렬방식(asc or desc)
-- 정렬방식 : 오름차순(ascending), 내림차순(descending)

--           오름차순                               내림차순
--------------------------------------------------------------
-- 숫자 : 작은 숫자부터 큰숫자 순으로 정렬(1,2,3...)    큰숫자부터 작은 숫자 순으로(10,9,8..)
-- 문자 : 사전순 정렬(a,b,c..)                       사전역순 정렬(z,y,x...)
-- 날짜 : 빠른날짜 순으로 정렬                        늦은날짜 순으로 정렬
-- NULL : NULL 값이 가장 마지막에 출력                NULL 값이 가장 먼저 출력

-- 1. 숫자 데이터 정렬
--Q. 사원 테이블에서 급여를 기준으로 오름차순 정렬
select ename, sal from emp order by sal asc;

-- 정렬방식(asc, desc)이 생략되면, 기본 정렬방식이 오름차순으로 정렬함.
select ename, sal from emp order by sal; -- 정렬방식(asc) 생략

--Q. 사원 테이블에서 급여를 기준으로 내림차순 정렬 : 큰숫자부터 작은숫자 순으로 정렬
select ename, sal from emp order by sal desc;

-- 2. 문자 데이터 정렬
--Q. 사원 테이블에서 사원명을 기준으로 오름차순 정렬 :  사전순 정렬
select ename from emp order by ename asc;
select ename from emp order by ename;   -- 정렬방식(asc) 생략

--Q. 사원 테이블에서 사원명을 기준으로 내림차순 정렬 : 사전 역순 정렬
select ename from emp order by ename desc;

-- 3. 날짜 데이터 정렬
--Q. 사원 테이블에서 입사일을 기준으로 오름차순 정렬 :  빠른날짜 순으로 정렬
select hiredate from emp order by hiredate asc;

--Q. 사원 테이블에서 입사일을 기준으로 내림차순 정렬 : 늦은날짜 순으로 정렬
select hiredate from emp order by hiredate desc;

-- 4. NULL 정렬
--  1) 오름차순 정렬 : NULL 값이 가장 마지막에 출력
--  2) 내림차순 정렬 : NULL 값이 가장 먼저 출력
--Q. MGR컬럼을 기준으로 오름차순 정렬
select mgr from emp order by mgr asc; -- NULL 값이 가장 마지막에 출력

--Q. MGR컬럼을 기준으로 내림차순 정렬
select mgr from emp order by mgr desc; -- NULL 값이 가장 먼저 출력

--Q. COMM컬럼을 기준으로 오름차순 정렬
select comm from emp order by comm asc; -- NULL 값이 가장 마지막에 출력

--Q. COMM컬럼을 기준으로 내림차순 정렬
select comm from emp order by comm desc; -- NULL 값이 가장 마지막에 출력

-- 여러번 정렬하기
-- 1. 한번 정렬했을때 동일한 결과가 나오는 데이터가 있을 경우에는 한번 더 
-- 정렬을 해야 한다.
-- 2. 두번째 정렬 조건은 한번 정렬했을때 동일한 결과가 나온 데이터만 두번째 
-- 정렬 조건을 적용받는다.
-- 3. 댓글 게시판을 만드는 경우에 주로 사용한다.

--Q. 사원 테이블에서 급여를 기준으로 내림차순 정렬을 한다. 이때 동일한 급여를
-- 받는 사원들은 사원명을 기준으로 오름차순 정렬해서 출력하는 SQL문 작성
select ename, sal from emp order by sal desc; -- 3000(2명), 1250(2명)

select ename, sal from emp order by sal desc, ename asc;
                                 --첫번째 정렬 / 두번째 정렬
                                 
-- 정렬 문제
--Q1. 사원 테이블에서 입사일을 기준으로 오름차순으로 정렬하여 출력하되, 사원번호
--  사원명, 직급, 입사일 컬럼을 출력하는 SQL문 작성?
select empno, ename, job, hiredate from emp order by hiredate asc;

--Q2. 사원 테이블에서 사원번호를 기준으로 내림차순으로 정렬하여 사원번호와
-- 사원명 컬럼을 출력하는 SQL문 작성?
select empno, ename from emp order by empno desc;

--Q3. 부서번호가 빠른 사원부터 츨력하되, 동일한 부서내의 사원을 출력할 경우에는 
-- 최근에 입사한 사원부터 사원번호, 입사일, 사원명, 급여순으로 출력하는
-- SQL문 작성?
select empno, hiredate, ename, sal, deptno from emp 
    order by deptno asc, hiredate desc;  


