/************************
*join
*************************/

--카티젼 프로덕트(Cartesian Product)
--col:15  row:2889
select *
from employees, departments;

select  em.employee_id,
        em.first_name,
        em.salary,
        de.department_name,
        em.department_id,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id;


select  em.first_name,
        de.department_name,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and   em.job_id = jo.job_id
order by em.first_name asc
;


select  count(*)
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and   em.job_id = jo.job_id





-- c11 r107 
select  employee_id,
        first_name,
        salary,
        job_id,
        department_id
from employees; 

--c04  r27
select *
from departments;


select *
from jobs;