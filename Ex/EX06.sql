/*
equi join
*/
SELECT  em.first_name,
        em.salary,
        de.department_id,
        de.department_name
FROM employees em, departments de
where em.department_id = de.department_id;

SELECT  first_name.
        salary,
        department_id
FROM employees;
    
SELECT *
from departments;

--예) 문제점 nill값이 안 나옴--
 
SELECT  em.first_name,
        de.department_name,
        jo.job_title
FROM employees em,departments de, jobs jo
where em.department_id  = de.department_id
and em.job_id = jo.job_id;

-- outer join > left outer join--

-- null 값도 표시가능--
SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
FROM employees em left outer join departments de --왼쪽을 기준으로 잡음
on em.department_id = de.department_id;

-- where로 left outer join과 같이 표시하기 --

-- 전체 출력--
select e.department_id, e.first_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--null 값만 출력 --
select e.department_id, e.first_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
and d.department_id is null;

-- right outer join--
SELECT
    * FROM employees em RIGHT OUTER JOIN departments de
    on em.department_id = de.department_id;


-- departments를 기준으로 잡아 사용되는 id와 employees에서 
--사용되지 않는 null id의 값을 더해서 출력됨 사용되지 않는건 null로 전부 표시 --
SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
FROM employees em RIGHT OUTER JOIN departments de
on em.department_id = de.department_id;

--where로 right outer join 표현하기--
SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
FROM employees em,departments de
where em.department_id(+) = de.department_id;

SELECT depar
FROM departments;

-- right outer join--> left outer join 바꾸기 --

SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_id
FROM departments de left outer join  employees em --방향만 바꿈--
    on de.department_id = em.department_id;
--같은 의미--
    SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_id
FROM departments de,employees em
where de.department_id = em.department_id(+);

--full outer join--
--where로 표현 불가능--
SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
FROM employees em full outer join departments de
on em.department_id = de.department_id;


-- self join --> 직원테이블 부서테이블 조인 문과 비교--
SELECT  em.employee_id,
        em.first_name,
        em.salary,
        em.phone_number,
        em.manager_id,
        ma.employee_id, -- ma는 매니저의 값만 출력--
        ma.first_name,
        ma.phone_number,
        ma.email
FROM employees em, employees ma -- 매니저 테이블을 기존 테이블을 꺼내 써서 만듬--
where em.manager_id = ma.employee_id; -- ma의 employee_id를 em의 manager_id로 변환


--잘 못된 셀프 조인 다른의미를 가진 두값을 조인할때--
SELECT  em.employee_id,
        em.first_name,
        em.salary,
        em.phone_number,
        lo.location_id,
        lo.city
FROM employees em, locations lo
where em.salary = lo.location_id;
