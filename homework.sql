--  Q1. 사원테이블(EMP)에서 입사일(HIREDATE)을 4자리 연도로 출력 
--      되도록 SQL문을 작성하세요? (ex. 1980/01/01)
select to_char(hiredate, 'YYYY-MM-DD') hiredate  from emp;

-- 해결방법 : hiredate는 date형식이기 때문에 문자형으로 바꿔주고 원하는 형태로 출력

--Q2. 사원테이블(EMP)에서 MGR컬럼의  값이  null 인 데이터의 MGR의 
--    값을  CEO로  출력하는 SQL문을 작성 하세요?
select nvl(to_char(mgr), 'CEO') mgr from emp;
-- 해결방법 : mgr을 문자형으로 바꾸고 nvl로 null값을 ceo로변형

-- number형을 varchar2의 형식으로 바꾸기 위해서는 to_char을 쓰면된다.
-- to_char는 숫자를 문자로 형변환 해주는 함수이다.

select * from emp;

--     Q1. 사원 테이블(EMP)에서 가장 최근에 입사한 사원명을 출력 하는 
--           SQL문을 작성 하세요?
select ename from emp where hiredate = (select max(hiredate) from emp); -- 서브쿼리를 이용해서 풀이
--     Q2. 사원 테이블(EMP)에서 최대 급여를 받는 사원명과 최대급여
--           금액을 출력하는 SQL문을 작성 하세요?
select ename, sal from emp where sal = (select max(sal) from emp);  -- 서브쿼리를 이용해서 풀이

-- 서브쿼리 : 하나의 select문장의 절 안에 포함된 또 하나의 select 문장이다.
-- 서브쿼리는 비교 연산자(=,>,>=,<,<=,<>)의 오른쪽에 기술해야 하고 반드시 괄호로 둘러쌓아야 한다.
