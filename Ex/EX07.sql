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


--sub Query --
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

--평균 급여보다 적게 받는 사람의 이름 급여를 출력                
select first_name, salary
from employees
where salary < (select AVG(salary)
                from employees)
order by salary desc;