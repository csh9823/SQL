---- * 전부 출력하기-----
select * 
from employees;

select * 
from departments;



------원하는 컬럼 선택해서 출력하기
select employee_id,
       first_name,
       last_name
from employees;

--------사원의 이름(fisrt_name)과 전화번호 입사일 연봉을 출력하세요
select first_name, phone_number, hire_date, salary
from employees;

--사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요

select first_name,
       last_name,
       salary,
       phone_number,
       email,
       hire_date
from employees;

--출력할 컬럼명 별명적용하기 출력 컬럼명 변경됨
SELECT  employee_id as empNo,
        first_name as "f-name" , -- 특수 문자 쓸경우 ""
        salary as "연 봉"  -- 띄어쓰기 할 경우 ""
FROM employees;
    
--예)--
select first_name as 이름,
       phone_number as 전화번호,
       salary as 급여,
       hire_date as 입사일
from employees;
--예2)--

--as 지워도 사용가능--
SELECT  employee_id 사원번호,
        first_name as "이름",
        last_name as 성,
        salary as 급여,
        phone_number as 전화번호,
        email as 이메일,
        hire_date as 입사일
from employees;

--연결 연산자(Concatenation)로 컬럼들 붙이기--

SELECT first_name,last_name -- 2개로 나눠서 출력
from employees;

SELECT first_name || last_name -- 하나로 붙어서 출력
from employees;


SELECT first_name || ' ' || last_name -- 사이 띄우기
from employees;

SELECT first_name || ' 입사일은 ' || hire_date
from employees;

SELECT first_name || ' ' || last_name NAME
from employees;

--산술 연산자 사용

SELECT  first_name,
        salary 월급,
        salary*12 연봉,
        (salary+300)*12
from employees;


--예제)

SELECT job_id
from employees;


SELECT job_id*12 --오류 나는 이유 숫자가 아니라서
from employees;

--비교 연산자 급여가 15000 이상인 사원들의 이름과 월급을 출력하세요--

SELECT  first_name,
        salary 
FROM employees
where salary >= 5000;

-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
SELECT first_name, hire_date
FROM employees
WHERE hire_date >= '07/01/01' ;

--이름이 Lex인 직원의 연봉을 출력하세요
SELECT salary
FROM employees
where first_name = 'Lex' ;

---조건이 2개이상 일때 한꺼번에 조회하기
--연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요--

select first_name, salary
from employees
where salary >= 14000 
and salary <= 17000;

--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요--

select first_name, hire_date
from employees
where hire_date >= '04/01/01' 
and hire_date <= '05/12/31';

--■ IN 연산자로 여러 조건을 검사하기--
SELECT  first_name,
        last_name,
        salary
FROM employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';

--같은 표현 다른 방법
select first_name,
       last_name,
       salary
from employees
where first_name in ('Neena', 'Lex', 'John');

--연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오--

SELECT first_name,
       last_name,
       salary
FROM employees
where salary in (2100, 3100, 4100, 5100);

--Like 연산자로 비슷한것들 모두 찾기 % : 임의의 길이의 문자열(공백 문자 가능)  _ : 한글자 길이 --

select first_name, last_name, salary
from employees
where first_name like 'L%';

--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요--
select first_name, last_name, salary
from employees
where first_name like '%am%';

--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요--
select first_name
from employees
where first_name like '_a%';

--이름의 네번째 글자가 a 인 사원의 이름을 출력하세--
select first_name
from employees
where first_name like '___a%';

--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요--
select first_name
from employees
where first_name like '__a_';

-- null을 포함한 산술식은 null(값*null은 null 산술식 전원 포함)--
SELECT first_name, salary,
       commission_pct,
       salary*commission_pct
from employees
where salary between 13000 and 15000;

--is null / is not null--
SELECT * 
FROM employees
where commission_pct is null; -- commission_pct = null 이렇게 쓰면 안됨 --

--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요--

SELECT  commission_pct,
        first_name,
        salary 
FROM employees
where commission_pct is not null;

-- 담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
SELECT  commission_pct,
        first_name,
        manager_id
FROM employees
where commission_pct is null 
and manager_id is null;

--ORDER BY 절 desc 내림차순 asc 오름차순--

SELECT * 
FROM employees
ORDER by salary desc
;

--order by asc 오름차순--
SELECT * 
FROM employees
ORDER by salary asc, first_name asc
;
--order by 오름차순 내림차순 섞어 쓰기--
SELECT * 
FROM employees
ORDER by salary asc, first_name DESC
;

SELECT * 
FROM employees
where salary >= 9000
ORDER by salary asc;

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요--
SELECT  department_id,
        salary,
        first_name
FROM employees
ORDER BY department_id asc
;

-- 급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요--

SELECT  salary,
        first_name
FROM employees
where salary >= 10000
ORDER BY salary DESC
;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요--

SELECT  department_id,
        salary,
        first_name
FROM employees
ORDER BY department_id asc, salary desc
;