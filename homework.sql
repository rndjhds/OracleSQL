--  Q1. 사원테이블(EMP)에서 입사일(HIREDATE)을 4자리 연도로 출력 
--      되도록 SQL문을 작성하세요? (ex. 1980/01/01)
select to_char(hiredate, 'YYYY-MM-DD') from emp;

--Q2. 사원테이블(EMP)에서 MGR컬럼의  값이  null 인 데이터의 MGR의 
--    값을  CEO 로  출력하는 SQL문을 작성 하세요?
select TO_CHAR(NULL) "Warehouse" from emp;

select * from emp;