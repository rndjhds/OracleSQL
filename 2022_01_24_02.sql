-- 2022.01.24(월)

--SQL 함수
select * from dept;
select * from emp;
select 10+20 from dept; -- 4개 출력
select 10+20 from emp;  -- 14개 출력

-- dual 테이블
-- 1. sys 계정 소유의 테이블이고 공개 동의어로 설정 되어 있음
-- 2. dual 테이블은 공개가 되어 있기 때문에 누구나 사용 가능하다.
-- 3. dual 테이블은 데이터가 1개 밖에 없기 때문에, 연산 결과를 1번만 출력한다.


select 10+20 from dual; -- 1개 출력
select 10+20 from sys.dual; -- 원래소유자명.dual로 출력해야하지만 
                            -- 공개동의어 설정되어있어서 dual만 써도 출력 가능
desc dual;              -- dummy 컬럼 1개 존재
select * from dual;     -- X 데이터 1개 있음

select * from sys.tab;  -- 공개 동의어
select * from tab;

-- 1. 숫자 함수
-- abs() : 절대값을 구해주는 함수
select -10, abs(-10), abs(-20) from dual;
-- 함수명은 대.소문자를 구분하지 않는다.

-- floor() : 소숫점 이하를 버리는 역할 함수
select 34.5678, floor(34.5678) from dual;

-- round() : 특정 자리에서 반올림을 하는 역할
-- round(대상값, 자리수)  : 자리수가 지정되지 않을 시 소수 첫번째 자리에서 반올림해준다.
select 34.5678, round(34.5678) from dual; -- 35출력 : 소수 첫번째 자리에서 반올림
select 34.5678, round(34.5678, 2) from dual; -- 34.57출력 : 자리수 2로 지정해서 소수점 두번째 자리까지 출력
                                             -- 소수점 3번째 자리에서 반올림
select 34.5678, round(34.5678, -1) from dual; -- 30출력 : 자리수에 음수가 방향을 나타내고, 소수점 앞 1의 자리가 -1을 나타낸다.
select 34.5678, round(35.5678, -1) from dual; -- 40출력 : 자리수가 -1이기 때문에 일의 자리까지만 출력하고 일의자리에서 반올림을 한다.

-- trunc() : 특정 자리에서 잘라내는 역할 : 지정한 자리수에서 버림
select trunc(34.5678), trunc(34.5678, 2), trunc(34.5678, -1) from dual;
--           34출력            34.56출력        30출력

-- mod() : 나머지를 구해주는 함수
select mod(27, 2), mod(27, 5), mod(27, 7) from dual;
--         1출력        2출력       6출력

--Q. 사원 테이블에서 사원번호가 홀수인 사원들을 검색하는 SQL문 작성?
select * from emp where mod(empno, 2) != 0;
select * from emp where mod(empno, 2) = 1;
---------------------------------------------------------------------------------------------------------
-- 2. 문자 처리 함수

-- upper() : 대문자로 변환해주는 함수
select 'Welcome to Oracle', upper('Welcome to Oralce') from dual;

-- lower() : 소문자로 변환해주는 함수
select 'Welcome to Oralce', lower('welcome to Oracle') from dual;

-- initcap() : 각 단어의 첫글자를 대문자로 변환해주는 함수
select 'Welcome to Oralce', lower('welcome to Oracle') from dual;

--Q. 사원 테이블에서 job이 manager인 사원을 검색하는 SQL문 작성?
select empno, ename, job from emp where job = 'manager'; -- 검색안됨
select empno, ename, job from emp where lower(job) = 'manager';
select empno, ename, job from emp where job = upper('manager');

-- length() : 문자열의 길이를 구해주는 함수(글자수)
select length('oracle'), length('오라클') from dual;
--             6출력              3출력

-- lengthb() : 문자열의 길이를 바이트로 구해주는 함수
-- 영문 1글자 : 1Byte, 한글 1글자 : 3Byte : 오라클버전에 따라 한글의 Byte크기가 다르다.
select lengthb('oracle'), lengthb('오라클') from dual;
--              6출력               9출력
        
-- substr() : 문자열의 일부를 추출하는 함수이면서 문자처리 함수
-- 형식 : substr(대상 문자열, 시작위치, 추출할 문자 갯수)
-- 주의 사항 : 시작위치번호는 왼쪽기준으로 1번부터 시작한다.

select substr('Welcome to Oracle', 4, 3) from dual; -- com추출    4번부터 3개추출
select substr('Welcome to Oracle', -4, 3) from dual; -- acl추출 
-- 시작위치가 음수일경우 오른쪽 기준으로 -1부터 시작

--Q. 사원 테이블에서 입사일(hiredate)을 년, 월, 일을 추출해서 출력하는 SQL문 작성?
select substr(hiredate, 1,2) as "년",
       substr(hiredate, 4,2) as "월",
       substr(hiredate, 7,2) as "일" from emp;
       
--Q. 사원 테이블에서 87년도에 입사한 사원을 검색하는 SQL문 작성?
select * from emp where substr(hiredate,1,2) = '87'; -- 문자처리함수이기 때문에 외따옴표로 감싸준다.

--Q. 사원 테이블에서 사원명이 E로 끝나는 사원을 검색하는 SQL문 작성(2가지 방법)
select * from emp where ename like '%E';
select * from emp where substr(ename, -1,1) = 'E';

-- instr() : 특정 문자의 위치를 구해주는 함수
-- instr(대상, 찾을 문자) : 가장 먼저 나오는 문자의 위치를 찾아준다.
-- instr(대상, 찾을 문자, 시작 위치, 몇번째 발견)

--Q 가장 먼저 나오는 'o'의 위치를 찾아준다.
select instr('Welcome to oracle', 'o') from dual;   -- 5출력

--Q. 6번 이후에 2번째 발견된 'o'의 위치를 찾아준다.
select instr('Welcome to oracle', 'o', 6, 2) from dual; -- 12출력

--Q. 사원 테이블에서 사원명의 3번째 자리가 R로 되어있는 사원을 검색하는 SQL문 작성?(3가지 방법)
-- 3가지 방법 : like연산자, substr(), instr()
select * from emp where ename like '__R%';
select * from emp where substr(ename, 3,1) = 'R';
select * from emp where instr(ename, 'R') = 3;
select * from emp where instr(ename, 'R', 3, 1) = 3;

-- lpad() / rpad() : 특정기호로 채워주는 역할
select lpad('oracle', 20, '#') from dual;  -- ##############oracle 출력
select rpad('oracle', 20, '#') from dual;  -- oracle############## 출력

-- ltrim() : 왼쪽 공백을 삭제하는 함수
-- rtrim() : 오른쪽 공백을 삭제하는 함수
select '  Oracle   ', ltrim('  Oracle  ') from dual;
select rtrim('  Oracle  ') from dual;

-- trim() : 문자열 좌.우의 공백을 삭제하는 함수
--          특정 문자를 잘라내는 함수
select trim('  Oracle  ') from dual;
select trim('a' from 'aaaaaOracleaaaaa') from dual;
-------------------------------------------------------------------------------------------
-- 3. 날짜 함수

-- sysdate : 시스템의 날짜를 구해주는 함수 
-- sysdate는 ()가 없다!!!
select sysdate from dual; -- 22/01/24

select sysdate-1 어제, sysdate 오늘, sysdate+1 내일 from dual;

--Q. 사원 테이블에서 각 사원들의 현재까지 근무일수를 구하는 SQL문 작성?
select sysdate-hiredate from emp;
select round(sysdate-hiredate) from emp; -- 소수 1째자리에서 반올림
select trunc(sysdate-hiredate) from emp; -- 소수점 자리를 버림

-- months_between() : 두 날짜 사이의 경과된 개월 수를 구해주는 함수
-- months_between(date1, date2)
--Q. 사원 테이블에서 각 사원들의 근무한 개월 수를 구하는 SQL문 작성?
select ename, sysdate, hiredate, months_between(sysdate, hiredate) from emp;

select months_between(sysdate, hiredate) from emp;
select round(months_between(sysdate, hiredate)) from emp;
select trunc(months_between(sysdate, hiredate)) from emp;

-- add_months() : 특정 날짜에 경과된 개월의 날짜를 구해주는 함수
-- add_months(date, 개월수)
--Q. 사원 테이블에서 각 사원들의 입사한 날짜에 6개월이 경과된 일자를 구하는 SQL문 작성?
select ename, hiredate, add_months(hiredate, 6) from emp;
--Q. 입과한후에 6개월 경과된 일자를 구하는 SQL문 작성?
select add_months('21/12/21', 6) from dual;

-- next_day() : 해당 요일의 가장 가까운 날짜를 구해주는 함수
-- next_day(date, 요일)
--Q. 오늘을 기준으로 가장 가까운 토요일이 언제인지 구하는 SQL문 작성?
select sysdate, next_day(sysdate, '토요일') from dual;

-- last_day() : 해당 달의 마지막 날짜를 구해주는 함수
--Q. 사원 테이블에서 각 사원들이 입사한 달의 마지막 날짜를 구하는 SQL문 작성?
select hiredate, last_day(hiredate) from emp;

--Q. 이번달의 가장 마지막 날짜를 구하는 SQL문 작성?
select sysdate, last_day(sysdate) from dual;
select last_day('22/02/01') from dual;  --22/02/28

-- 4. 형변환 함수