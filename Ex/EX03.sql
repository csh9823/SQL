--그룹함수--

--평균 값--
select AVG(salary)
from employees;

--오류 발생 이유 avg는 1개의 로우 인데 first_name는 107개의 로우라서
select first_name, AVG(salary)
from employees;

--그룹함수 AVG() 평균 값 나타내기--
select AVG(salary) -- null을 제외하고 평균
from employees;

select  count(*),
        sum(salary),
        avg(nvl(salary,0)) -- null값을 0으로 포함해서 평균 구하기
from employees;

--그룹함수 - count() 함수에 입력되는 데이터의 총 건수를 구하는 함수 (*)= null 포함--
select  COUNT(*),   -- null 포함
        count(commission_pct), --null 제외
        count(department_id)
from employees;

--where 포함 16000이상이 로우만 출력--
select  COUNT(*)
from employees
where salary > 16000;

--부서 번호가 100번인 사람의 갯수--
select  COUNT(*)
from employees
where department_id = 100;

-- 그룹함수 sum() 입력된 데이터들의 합계 값을 구하는 함수--
select count(*), sum(salary)
from employees;

-- 그룹함수 - max() / min() --
select  count(*),
        max(salary),
        min(salary)
from employees;

--GROUP BY 절--
--같은 그룹이라 가능--
SELECT  avg(salary),
        department_id
FROM employees
GROUP BY department_id;

--다른 그룹이라 불 가능--
select department_id, job_id, count(*), sum(salary)
from employees
group by department_id;