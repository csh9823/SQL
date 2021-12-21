-- 11000 초과 출력--
SELECT  first_name,
        salary
from employees
where salary > 11000;

--딘의 급여--
SELECT  first_name,
        salary
from employees
where first_name = 'Den';


-- 단일행 sub Query(단일행) --
--위 두개를 합친거  뜻 딘의 월급의 초과인 사람을 출력--
SELECT  first_name,
        salary
from employees
where salary > (SELECT salary
                 FROM employees
                 where first_name = 'Den');

--급여를 가장 적게 받는 사람의 이름 급여 사원번호는?--
select first_name, salary, employee_id
from employees
where salary = (select min(salary)
                from employees);

--평균 급여보다 적게 받는 사람의 이름 급여를 출력 • 연산자 : = , > , >=, < , <=, <>(같지않다)            
select first_name, salary
from employees
where salary < (select AVG(salary)
                from employees)
order by salary desc;

--SubQuery 다중행 IN--
--부서 번호가 110인 직원의 급여와 같은 모든 직원의 사번 이름 급여를 출력하세요--
SELECT  employee_id,
        first_name,
        salary,
        department_id
FROM employees
where salary in (select salary
                 from employees
                 where department_id = 110);              
--1. 부서번호가 110인 직원의 급여리스트를 구한다--
SELECT  employee_id,
        first_name,
        salary,
        department_id
FROM employees
where department_id = 110;
--2. 급여가 12008, 8300 인 직원의 리스트를 구한다--
SELECT  employee_id,
        first_name,
        salary,
        department_id
FROM employees
where salary = 12008
or salary = 8300;

--다른 표현 IN쓰기 --
SELECT  employee_id,
        first_name,
        salary,
        department_id
FROM employees
where salary IN(12008,8300);

--1,2의 두식을 조합한다--
SELECT  employee_id,
        first_name,
        salary,
        department_id
FROM employees
where salary in (select salary
                 from employees
                 where department_id = 110);
                
--예제 각 부서별로 최고급여를 받는 사원을 출력하세요 null은 포함x--
SELECT  department_id,
        salary,
        first_name,
        salary
FROM employees
where (department_id, salary) IN( SELECT department_id,
                                  max(salary)
                                  from employees
                                  GROUP by department_id);
-- 그룹 별(부서별) 최고급여 (사람 first_name는 표현 할 수 없다)--
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

-- any (or) 연산자--
-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의
--사번,이름,급여를 출력하세요.(or연산---> 8300보다 큰)

--1. 부서번호가 110인 직원의 급여 12008 8300 --

SELECT salary
FROM employees
where department_id = 110;

--2. 부서번호가 110인 (12008, 8300) 보다 급여가 큰 직원리스트(사번,이름,급여)를 출력
SELECT  employee_id,
        first_name,
        salary
FROM employees
where salary > 12008
or salary > 8300 ;

-- 조합 --
SELECT  employee_id,
        first_name,
        salary
FROM employees
where salary > any( SELECT salary  
                    FROM employees
                    where department_id = 110); -- salary에 110 id가 110인 급여 값을 넣어주고(12008,8300) 두 값을 or한다--
                                                -- ex)where salary > 12008
                                                --    or salary > 8300 ;


--ALL (and) --
--부서번호가 110인 직원의 급여 보다 큰 모든 직원의
--사번, 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)
select first_name, salary
from employees
where salary > all (  select salary
                      from employees
                      where department_id = 110); -- salary에 110 id가 110인 급여 값을 넣어주고(12008,8300) 두 값을 or한다--
                                                  -- ex) where salary > 12008
                                                  --     and salary > 8300 ;
--1. 부서번호가 110인 직원의 급여 12008 8300 --

SELECT salary
FROM employees
where department_id = 110;

--2. 부서번호가 110인 부서번호가 110인 (12008, 8300) 보다 급여가 큰 직원리스트(사번,이름,급여)를 출력
SELECT  employee_id,
        first_name,
        salary
FROM employees
where salary > 12008
and salary > 8300 ;

--조합--
select first_name, salary
from employees
where salary > all (  select salary
                      from employees
                      where department_id = 110); -- salary에 110 id가 110인 급여 값을 넣어주고(12008,8300) 두 값을 or한다--
                                                  -- ex) where salary > 12008
                                                  --     and salary > 8300 ;
                                                  


--*************************************************************************************
--*************************************************************************************
--*************************************************************************************

--조건절에서 비교 vs 테이블에서 조인--

--각 부서별로 최고급여를 받는 사원을 출력하세요--
select  department_id,
        employee_id,
        first_name,
        salary
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary)
                                          from employees
                                          group by department_id);
                                          
-- 테이블 서브쿼리 --
--각 부서별 최고급여를 받는 사원을 출력 --> join 에 이용할 테이블로 사용예정

SELECT  department_id,
        max(salary)
FROM employees
GROUP BY department_id;

select  em.department_id,
        em.employee_id,
        em.first_name,
        em.salary
from employees em, (select department_id,
                          max(salary) "접근코드" -- 별명 꼭 줘야 접근가능--
                   from employees
                   group by department_id) ms 
where em.department_id = ms.department_id
and em.salary = ms."접근코드";

--01 각 부서별 최고 급여 리스트
SELECT  department_id,
        max(salary)
FROM employees
GROUP BY department_id;

