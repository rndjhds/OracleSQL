-- summary(2022_01_20 ~ 2022_01_24)

--  테이블 목록 검색
-- 형식 : select * from tab
select * from tab; -- 계정이 가지고 있는 테이블이름, 타입등을 출력해준다

-- 테이블 구조
-- 형식 : desc 테이블명 or describe 테이블명
desc dept;  -- 테이블의 컬럼명 컬럼의타입을 출력한다.
describe dept;   -- 테이블의 컬럼명 컬럼의타입을 출력한다.

-- 테이블의 데이터 검색
-- 형식 : select 컬럼명 from 테이블명
select * from dept; -- 테이블의 입력된 데이터 출력
------------------------------------------------------------------------
-- tab은 sys계정에 포함되어있지만 동의어이기 때문에 sys.tab이라고 써도되고 안써도 된다.
-- SQL문은 대.소문자 구분을 하지 않는다. 하지만 문자형으로 저장된 값은 대.소문자 구분을 해줘야 한다.

-- 오라클의 데이터 타입
-- 1. 숫자 데이터
-- number(n) : 정수 n자리까지 저장할 수 있다.
-- number(n1, n2) : n1은 전체 자리수
--                : n2는 소숫점에 할당된 자리수

-- 2. 문자 데이터
-- char() : 고정 길이 문자형 : 최대 길이는 2000Byte까지 저장 가능하다.
-- char()는 저장할 데이터가 작아도 설정된 Byte의 길이로 저장한다.
-- varchar2() : 가변 길이 문자형 : 최대 길이 4000Byte까지 저장 가능하다.
-- varchar2() : 설정한 Byte보다 저장할 데이터가 작으면 데이터의 길이만큼만 Byte를 저장한다.
-- long : 최대 2GB까지 저장 가능하다. 하지만 long형으로 설정된 컬럼은 검색기능을 지원하지 못한다.

-- 3. 날짜 데이터
-- date : 년/월/일 정보로 저장한다.
-- timestamp : 년/월/일 시:분:초:초/1000 정보로 저장한다.

-- select SQL문 
select * from dept; -- dept에 저장된 데이터 출력

select loc, deptno, dname from dept; -- loc, deptno, dname 순으로 출력한다.

-- 산술 연산자 : +,-,*,/
select sal + comm from emp;
-- null값이 출력이 되는 이유는 comm에 null이 있는데 null은 산술연산을 할 수 없기 때문이다.
select sal - 100 from emp;
select sal * 100 from emp;
select sal / 100 from emp;

-- NULL
-- 1. 정해지지 않은 값을 의미
-- 2. NULL 값은 산술연산을 할 수 없다.

--Q. 사원테이블(EMP)에 소속된 사원들의 연봉을 구해보자?
-- 연봉 = 급여(SAL)* 12 + 커미션(COMM)
select sal, sal * 12 + comm from emp; -- comm에 null이 있기때문에 산술연산을 할 수 없다.
-- 해결방법
-- NVL(컬럼, 변환될 값) : NULL값을 다른 값으로 변환 해주는 함수
select sal, comm, sal*12+nvl(comm,0) from emp; -- comm의 null값을 0으로 변환

-- 별칭 부여하기 : as "별칭명"
select ename, sal*12+nvl(comm,0) as "Annsal" from emp; -- 기본 형식
select ename, sal*12+nvl(comm,0) "Annsal" from emp; -- as 생략가능
select ename, sal*12+nvl(comm,0) as Annsal from emp; -- "" 생략가능
select ename, sal*12+nvl(comm,0) Annsal from emp; -- as, "" 둘다 생략가능

-- 별칭명에 띄어쓰기가 있을 경우에는 쌍따옴표를 생략할 수 없다.
select ename, sal*12+nvl(comm,0) Ann sal from emp;  -- 띄어쓰기로 오류발생
select ename, sal*12+nvl(comm,0) "Ann sal" from emp; 
select ename, sal*12+nvl(comm,0) "연봉" from emp; -- 한글 입력 가능

-- Concatenation 연산자 : ||
-- : 컬럼과 문자열을 연결할 때 사용
select ename, ' is a ', job from emp; -- 각각의 컬럼으로 인식해서 3개의 컬럼으로 출력
select ename || ' is a ' || job from emp; -- 컬럼과 문자열을 연결해서 하나의 컬럼으로 출력되서 나온다.

-- distinct : 중복행을 제거하고 1번만 출력
select deptno from emp; -- 중복행이 여러번 출력
select distinct deptno from emp; -- 중복행을 제거하고 10, 20, 30 한번씩 출력

--Q. EMP테이블에서 각 사원들의 JOB을 1번만 출력하는 SQL문 작성하세요?
select job from emp; -- 중복행 여러번 출력
select distinct job from emp; -- 중복행 제거하고 각 직업들 1번씩 출력

--EMP테이블의 총 데이터 수 구하기?
-- count(컬럼명) : 데이터 갯수 구하기
select count(*) from emp; -- 14출력 : emp테이블은 총 14개의 데이터를 가지고 있다.
select count(*) from dept; -- 4출력 : dept테이블은 총 4개의 데이터를 가지고 있다.
select count(job) from emp; -- 14출력

--Q. 사원테이블(EMP)에서 중복을 제거한 JOB의 갯수를 출력하는 SQL문 작성하세요?
select count(distinct job) from emp; -- 5 출력
-------------------------------------------------------------------------
-- where 조건절 : 비교 연산자(=, >, >=, <, <=, !=, ^=, <> )

-- 1. 숫자 데이터 검색
-- Q. 사원테이블에서 급여를 3000이상 받는 사원을 검색하는 SQL문 작성하세요?
select * from emp where sal >= 3000;

--Q. 급여가 3000인 사원을 검색하는 SQL문 작성하세요?
select * from emp where sal = 3000;

--Q. 급여가 3000이 아닌 사원을 검색하는 SQL문 작성하세요?
select * from emp where sal != 3000;
select * from emp where sal ^= 3000;
select * from emp where sal <> 3000;

--Q. 급여가 1500이하인 사원의 사원번호, 사원명, 급여를 출력하는 SQL문 작성하세요?
select empno, ename, sal from emp where sal <= 1500;

-- 2. 문자 데이터 검색
--  1) 문자 데이터는 대.소문자를 구분한다!!!!!
--  2) 문자 데이터를 검색 할때는 문자열 좌.우에 외따옴표(')를 붙여야한다.
-- 쌍따옴표를 붙일떄는 별칭 부여할 때만 쓴다.

--Q. 사원테이블에서 사원명이 FORD인 사원의 정보를 검색하는 SQL문 작성?
select * from emp where ename = 'FORD';

--Q. SCOTT사원의 사원번호, 사원명, 급여를 출력하는 SQL문 작성?
select empno, ename, sal from emp where ename = 'SCOTT';

--3. 날짜 데이터 검색
-- 1) 날짜 데이터를 검색할 때 날짜, 좌.우에 외따옴표(')를 붙여야 한다.
-- 2) 날짜 데이터를 비교할 때 비교 연산자를 사용한다.

--Q. 1982년 1월 1일 이후에 입사한 사원을 검색하는 SQL문 작성?
select * from emp where hiredate >= '82/01/01';
select * from emp where hiredate >= '1982/01/01';
select * from emp where hiredate >= '82/01/01' order by hiredate asc; -- 입사일을 오름차순 정렬

----------------------------------------------------------------------------------
-- 논리 연산자 : and, or, not

--1. and 연산자 : 두 조건식을 모두 만족하는 데이터를 검색
--Q. 사원테이블에서 부서번호가 10번이고, JOB이 MANAGER인 사원을 검색하는 SQL문 작성
select * from emp where deptno = 10 and job = 'MANAGER';

--2. or 연산자 : 두 조건식 중에서 한가지만 만족해도 검색
--Q. 사원테이블에서 부서번호가 10번 이거나, JOB이 MANAGER인 사원을 검색하는 SQL문 작성?
select * from emp where deptno = 10 or job = 'MANAGER';

--3. not 연산자 : 논리값을 반대로 바꿔주는 역할
--Q. 부서번호가 10번이 아닌 사원을 검색하는 SQL문 작성?
select * from emp where not deptno = 10; -- 논리 연산자
select * from emp where deptno != 10; -- 비교 연산자
select * from emp where deptno ^= 10; -- 비교 연산자
select * from emp where deptno <> 10; -- 비교 연산자

-- between and 연산자
-- : where 컬럼명 between 작은값 and 큰값

--Q. 급여를 2000에서 3000사이의 급여를 받는 사원을 검색하는 SQL문 작성?
select * from emp where sal >= 2000 and sal <= 3000;
select * from emp where sal between 2000 and 3000;

--Q. 급여가 2000미만이거나 3000초과인 사원을 검색하는 SQL문 작성?
select * from emp where sal < 2000 or sal > 3000;
select * from emp where sal not between 2000 and 3000;

--Q. 1987년도에 입사한 사원을 검색하는 SQL문 작성?
select * from emp where hiredate >= '87/01/01' and hiredate <= '87/12/31';
select * from emp where hiredate between '87/01/01' and '87/12/31';
select * from emp where substr(hiredate,1,2) = '87';

-- in 연산자
-- : where 컬럼명 in(데이터1, 데이터2, 데이터3....)
--Q. 커미션이 300이거나 500이거나 1400인 사원을 검색하는 SQL문 작성?
select * from emp where comm = 300 or comm = 500 or comm = 1400;
select * from emp where comm in(300, 500, 1400);

--Q. 사원번호가 7521이거나 7654이거나 7844인 사원을 검색하는 SQL문 작성?
select * from emp where empno = 7521 or empno = 7654 or empno = 7844;
select * from emp where empno in(7521, 7654, 7844);
------------------------------------------------------------------------

-- like 연산자와 와일드 카드 : 검색기능을 구현할때 사용함.
-- : where 컬럼명 like pattern

-- 와일드 카드
-- 1. % : 문자가 없거나, 하나이상의 문자에 어떤 값이 와도 상관없다.
-- 2. _ : 하나의 문자에 어떤 값이 와도 상관없다.

--Q. 사원테이블에서 사원명이 대문자 F로 시작하는 사원을 검색하는 SQL문 작성?
select * from emp where ename like 'F%';

--Q. 사원테이블에서 사원명이 N으로 끝나는 사원을 검색하는 SQL문 작성?
select * from emp where ename like '%N';

--Q. 사원테이블에서 사원명이 A를 포함하는 사원을 검색하는 SQL문 작성?
select * from emp where ename like '%A%'; -- 가장 많이 쓰는 형식

-- 언드바(_) 와일드 카드
-- : 하나의 문자에 어떤값이 와도 상관없다.
--Q. 사원 이름의 두번쨰 글자가 A인 사원을 검색하는 SQL문 작성?
select * from emp where ename like '_A%';

--Q. 사원 이름의 세번째 글자가 A인 사원을 검색하는 SQL문 작성?
select * from emp where ename like '__A%';

--Q. 사원 이름이 끝에서 2번째 글자가 E인 사원을 검색하는 SQL문 작성?
select * from emp where ename like '%E_';

-- not like 연산자
--Q. 사원명에 A가 포함되어 있지 않는 사원을 검색하는 SQL문 작성?
select * from emp where ename not like '%A%';
---------------------------------------------------------------------
--null 값 검색
-- EMP 테이블 : MGR컬럼, COMM컬럼
-- 형식 : where 조건절 컬럼명 is null;

--Q. MGR컬럼에 null값인 데이터를 검색하는 SQL문 작성?
select * from emp where mgr is null;
--Q. MGR컬럼에 null값이 아닌 데이터를 검색하는 SQL문 작성? 
select * from emp where mgr is not null; -- not연산자 활용

--Q. COMM컬럼에 null값인 데이터를 검색
select * from emp where comm is null;

--Q. COMM컬럼에 null값이 아닌 데이터를 검색?
select * from emp where comm is not null;
-------------------------------------------------------------------------
-- 정렬 : order by 컬럼명 정렬방식(asc, desc)
-- 정렬방식 : 오름차순(ascending), 내림차순(descending)

--                 오름차순                     내림차순
------------------------------------------------------
-- 숫자 : 작은 숫자부터 큰숫자 순으로 정렬          큰숫자부터 작은 숫자 순으로 정렬
-- 문자 : 사전순 정렬                           사전 역순 정렬
-- 날짜 : 빠른날짜순으로 정렬                     늦은날짜 순으로 정렬
-- NULL : NULL 값이 가장 마지막에 출력            NULL값이 가장 먼저 출력

--1. 숫자 데이터 정렬
--Q. 사원 테이블에서 급여를 기준으로 오름차순 정렬
select * from emp order by sal asc;

-- 정렬방식이 생략되면, 기본 정렬방식이 오름차순으로 정렬함.
select * from emp order by sal; -- 정렬방식(asc)생략

--Q. 사원테이블에서 급여를 기준으로 내림차순 정렬 : 큰숫자부터 작은 숫자순으로 정렬
select * from emp order by sal desc;

--2. 문자 데이터 정렬
--Q. 사원 테이블에서 사원명을 기준으로 오름차순 정렬 : 사전순 정렬
select * from emp order by ename asc;
select * from emp order by ename;

--Q. 사원 테이블에서 사원명을 기준으로 내림차순 정렬 : 사전 역순 정렬
select * from emp order by ename desc;

--3. 날짜 데이터 정렬
--Q. 사원 테이블에서 입사일을 기준으로 오름차순 정렬 : 빠른날짜 순으로 정렬
select * from emp order by hiredate asc;

--Q. 사원 테이블에서 입사일을 기준으로 내림차순 정렬 : 늦은 날짜순으로 정렬
select * from emp order by hiredate desc;

--4. NULL 정렬
-- 1) 오름차순 정렬 : NULL값이 가장 마지막에 출력
-- 2) 내림차순 정렬 : NULL값이 가장 먼저 출력
--Q. MGR컬럼을 기준으로 오름차순 정렬
select * from emp order by mgr asc; -- NULL값이 가장 마지막에 출력

--Q. MGR컬럼을 기준으로 내림차순 정렬
select * from emp order by mgr desc; -- NULL값이 가장 먼저 출력

--여러번 정렬하기
-- 1. 한번 정렬했을 때 동일한 결과가 나오는 데이터가 있을 경우에는 한번 더 정렬을 해야 한다.
-- 2. 두번째 정렬 조건은 한번 정렬했을때 동일한 결과가 나온 데이터만 두번째 정렬 조건을 적용받는다.
-- 3. 댓글 게시판을 만드는 경우에 주로 사용한다.
-- 형식 : order by 컬럼명1 정렬방식1, 컬럼명2 정렬방식2

--Q. 사원 테이블에서 급여를 기준으로 내림차순 정렬을 한다. 이떄 동일한 급여를 받는 사원들은 사원명을
-- 기준으로 오름차순 정렬해서 출력하는 SQL문 작성?
select * from emp order by sal desc, ename asc;
                        -- 첫번째 정렬, 두번째 정렬
                        
-- 정렬문제
--Q1. 사원 테이블에서 입사일을 기준으로 오름차순으로 정렬하여 출력하되, 사원번호, 사원명, 직급
-- 입사일 컬럼을 출력하는 SQL문 작성?
select empno, ename, job, hiredate from emp order by hiredate asc;

--Q2. 사원 테이블에서 사원번호를 기준으로 내림차순으로 정렬하여, 사원번호와 사원명 컬럼을 출력하는
-- SQL문 작성?
select empno, ename from emp order by empno desc;

--Q3. 부서번호가 빠른 사원부터 출력하되, 동일한 부서내의 사원을 출력할 경우에는 최근에 입사한 사원부터
-- 사원번호, 입사일, 사원명, 급여순으로 출력하는 SQL문 작성?
select empno, hiredate, ename, sal from emp order by deptno asc, hiredate desc;
-------------------------------------------------------------------------------------
-- dual 테이블
-- 1. sys계정 소유의 테이블이고 공개동의어로 설정되어 있음
-- 2. dual 테이블은 공개가 되어있기 때문에 누구나 사용 가능하다.
-- 3. dual 테이블은 데이터가 1개 밖에 없기 때문에, 연산 결과가 1번만 출력한다.

select 10+20 from dual; -- 1개 출력
select 10+20 from sys.dual; -- 원래소유자명.dual로 출력해야하지만 공개동의어로 설정되어 있어서 
                            -- dual만 써도 출력 가능
--dual 테이블 구조
desc dual;  -- dummy 컬럼 1개 존재
select * from dual; -- x데이터 1개 존재
select * from tab;  -- tab도 공개동의어

-- SQL문 함수 : 함수명은 대.소문자를 구분하지 않는다.
-- 1. 숫자 함수
-- abs() : 절대값을 구해주는 함수
select -10, abs(-10), abs(-20) from dual;

-- floor() : 소숫점 이하를 버리는 역할 함수
select 34.5678, floor(34.5678) from dual;

-- round() : 특정 자리에서 반올림을 하는 역할
-- round(대상값, 자리수) : 자리수가 지정되지 않을 시 소수 첫번째 자리에서 반올림해준다.
--                      자리수지정시 자리수까지 출력                    
select 34.5678, round(34.5678) from dual; -- 35출력 : 자리수를 지정해주지 않아서 소수 첫번째 자리에서 반올림해줌
select round(34.5678, 2) from dual; -- 34.57 출력 : 자리수를 2로 지정해서 소주점 두번째 자리까지 출력
                                    -- 소수점 3번째 자리에서 반올림
select round(34.5678, -1) from dual; -- 30출력 : 자리수에 음수가 방향을 나타내고, 소수점 앞 1의 자리가 -1을 나타낸다. 
select round(35.5678, -1) from dual; -- 40출력 : 자리수가 -1이기 때문에 일의자리에서 반올림하고 일의 자리까지 출력

-- trunc() : 특정 자리에서 잘라내는 역할 : 지정한 자리수에서 버림
-- trunc(대상값, 자리수) : 자리수가 지정되지 않을 시 소수 첫번째 자리에서 잘라낸다.
--                      자리수 지정시 지정된 자리수까지 출력
select trunc(34.5678), trunc(34.5678, 2), trunc(34.5678, -1) from dual;
--            34출력           34.56출력            30출력

-- mod() : 나머지를 구해주는 함수
-- mod(대상값,값) : 대상값 / 값 으로 설정
select mod(27, 2), mod(27, 5), mod(27, 7) from dual;
--          1출력         2출력     6출력

--Q. 사원테이블에서 사원번호가 홀수인 사원들의 검색하는 SQL문 작성?
select * from emp where mod(empno, 2) = 1;
select * from emp where mod(empno, 2) != 0;
--------------------------------------------------------------------------------
-- 2. 문자 처리 함수

-- upper() : 대문자로 변환해주는 함수
select 'Welcome to Oracle', upper('Welcome to Oracle') from dual;

-- lower() : 소문자로 변환해주는 함수
select 'Welcome to Oracle', lower('Welcome to Oracle') from dual;

-- initcap() : 각 단어의 첫글자를 대문자로 변환해주는 함수
select 'Welcome to Oracle', initcap('Welcome to Oracle') from dual;

--Q. 사원 테이블에서 job이 MANAGER인 사원을 검색하는 SQL문 작성?
select * from emp where job = 'MANAGER';
select * from emp where job = upper('manager');
select * from emp where lower(job) = 'manager';

-- lengh() : 문자열의 길이를 구해주는 함수(글자수)
select length('oracle'), length('오라클') from dual;   -- 6출력, 3출력

-- lengthb() : 문자열의 길이를 바이트로 구해주는 함수(오라클 버전에 따라 한글의 Byte크기가 다르다.)
-- 영문 1글자 : 1Byte, 한글 1글자 : 3Byte 
select lengthb('oracle'), lengthb('오라클') from dual; -- 6출력, 9출력

-- substr() : 문자열의 일부를 추출하는 함수이면서 문자처리 함수
-- 형식 : substr(대상 문자열, 시작위치, 추출한 문자 갯수)
-- 주의사항 : 시작위치번호는 왼쪽기준으로 1번 부터 시작한다.
select substr('Welcome to Oracle', 4, 3) from dual; -- com추출 4번부터 3개 추출
select substr('Welcome to Oracle', -4, 3) from dual; -- acl추출 
-- 시작위치가 음수일 경우 오른쪽 기준으로 -1부터 시작

--Q. 사원 테이블에서 입사일을 년,월,일을 추출해서 출력하는 SQL문 작성?
select substr(hiredate,1,2) 년 , substr(hiredate,4,2) 월, substr(hiredate,7,2) 일 from emp;

--Q. 사원테이블에서 사원명이 E로 끝나는 사원을 검색하는 SQL문 작성(2가지 방법)
select * from emp where substr(ename, -1,1) = 'E';
select * from emp where ename like '%E';

--instr() : 특정 문자의 위치를 구해주는 함수
-- instr(대상, 찾을 문자) : 가장 먼저 나오는 문자의 위치를 찾아준다.
-- instr(대상, 찾을 문자, 시작 위치, 몇번째 발견)

--Q. 가장 먼저 나오는 'o'의 위치를 찾아준다.
select instr('Welcome to Oracle', 'o') from dual; -- 5출력

--Q. 6번 이후에 2번째 발견된 'o'의 위치를 찾아준다.
select instr('Welcome to oracle', 'o', 6, 2) from dual; -- 12출력

--Q. 사원테이블에서 사원명의 3번째 자리가 R로 되어있는 사원을 검색하는 SQL문 작성?(3가지 방법)
select * from emp where ename like '__R%';
select * from emp where substr(ename,3,1) ='R';
select * from emp where instr(ename, 'R') = 3;
select * from emp where instr(ename, 'R',3,1) = 3;

--lpad() / rpad() : 특정기호로 채워주는 역할
-- 형식 : lpad(대상값, 총자리수, 특정기호)
select lpad('oracle', 20, '#') from dual; -- 총 20자리로 oracle옆에 #으로 채워줌 
select rpad('oracle', 20, '#') from dual; -- 총 20자리로 oracle옆에 #으로 채워줌

-- ltrim() : 왼쪽 공백을 삭제하는 함수
-- rtrim() : 오른쪽 공백을 삭제하는 함수
select '  Oracle  ', ltrim('  Oracle  ') from dual;
select rtrim('  Oracle  ') from dual;

-- trim() : 문자열 좌.우의 공백을 삭제하는 함수
--          대상값에서 특정 문자를 잘라내는 함수 : trim(특정문자 from 대상값)
select trim('  Oracle  ') from dual;
select trim('a' from 'aaaaaOracleaaaaa') from dual;
----------------------------------------------------------------------------------
-- 3. 날짜 함수

-- sysdate : 시스템의 날짜를 구해주는 함수
-- sysdate는 ()가 없다!!!
select sysdate from dual;

select sysdate-1 어제, sysdate 오늘, sysdate+1 내일 from dual;
-- sysdate는 더하기, 빼기가 가능하다

--Q. 사원 테이블에서 각 사원들의 현재까지 근무일수를 구하는 SQL문 작성?
select ename, sysdate - hiredate 근무일수 from emp;
select ename, round(sysdate - hiredate) 근무일수 from emp; -- 소수 1번째 자리에서 반올림
select ename, trunc(sysdate - hiredate) 근무일수 from emp; -- 소수점 버림

-- months_between() : 두 날짜 사이의 경과된 개월 수를 구해주는 함수
-- 형식 : months_between(date1, date2)
--Q. 사원 테이블에서 각 사원들의 근무한 개월 수를 구하는 SQL문 작성?
select ename, months_between(sysdate, hiredate) 근무개월 from emp;
select ename, round(months_between(sysdate, hiredate))근무개월 from emp;
select ename, trunc(months_between(sysdate, hiredate)) 근무개월 from emp;

-- add_months() : 특정 날짜에 경과된 개월의 날짜를 구해주는 함수
-- 형식 : add_months(date1, 개월수)
--Q. 사원 테이블에서 각 사원들의 입사한 날짜에 6개월이 경과된 일자를 구하는 SQL문 작성?
select ename, add_months(hiredate, 6) from emp;
--Q. 입과한후에 6개월 경과된 일자를 구하는 SQL문 작성?
select add_months('21/12/21', 6) from dual;

-- next_day() : 해당 요일의 가장 가까운 날짜를 구해주는 함수(미래) 
-- 형식 : next_day(date, 요일) 
--Q. 오늘을 기준으로 가장 가까운 토요일이 언제인지 구하는 SQL문 작성?
select next_day(sysdate, '수요일') from dual;

-- last_day() : 해당 달의 마지막 날짜를 구해주는 함수
--Q. 사원 테이블에서 각 사원들이 입사한 달의 마지막 날짜를 구하는 SQL문 작성?
select last_day(hiredate) from emp;

--Q. 이번달의 가장 마지막 날짜를 구하는 SQL문 작성?
select sysdate, last_day(sysdate) from dual;
