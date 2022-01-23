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
