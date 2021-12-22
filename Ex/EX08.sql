-- rownum : 질의의 결과에 가상으로 부여되는 Oracle의 가상(Pseudo)의 Column (일렬번호)--
-- 급여를 가장 많이 받는 5명의 직원의 이름을 추력하시오.--

/*
오류 뜨는 잘못된 예
SELECT max(salary)
FROM employees;

SELECT first_name,
        salary
FROM employees
    where salary = (SELECT max(salary)
                    from employees);
*/

-- 01. rownum 이해--
SELECT  ROWNUM,
        first_name,
        salary
FROM employees;

SELECT  ROWNUM,
        first_name,
        salary
FROM employees
where salary >= 10000;

--02. 급여순으로 정렬  -- rownum 꼬여버림
--  정렬이 가장 나중에 실행됨--
SELECT  ROWNUM,
        first_name,
        salary
FROM employees
ORDER by salary desc;

-- rownum이 없을시 제대로 정렬--
SELECT  first_name,
        salary
FROM employees
ORDER by salary desc;

-- rownum 제대로 출력하기 from에 정렬된 값(식 테이블)을 넣어줌--
SELECT  ROWNUM, --순서 2--
        first_name,
        salary
FROM (
      SELECT  first_name, --제일 먼저 실행되서 불러옴 순서 1--
              salary
      FROM employees
      ORDER by salary desc);
      
-- 급여를 가장 많이 받는 5명의 직원의 이름을 출력하세요--

-- where ROWNUM <= 5에 and를 주고 두식을 입력하면 출력 안됨 --
-- 올바른 예 --
SELECT  ru, /*순서2 */
        first_name,
        salary
FROM (
      SELECT  ROWNUM ru,
              first_name, 
              salary,
              hire_date
      FROM( SELECT  first_name,
                    salary,
                    hire_date
            FROM employees
            ORDER by salary desc))
where ru <= 5; /*순서3*/

--잘못 된 예--
SELECT  ROWNUM, /* 순서2 순서1 rownum은 시작조건이 1부터 시작해서 1 2 3 4로 올라가는데 조건식이 2번부터 시작하면 1의 시작이 안되서 실행이 안됨 */
        first_name,
        salary
FROM (
      SELECT   
              first_name, /*순서1 */
              salary,
              hire_date
      FROM( SELECT  first_name,
                    salary,
                    hire_date
            FROM employees
            ORDER by salary desc))
where ROWNUM >= 5; /*순서3 이유 rownum의 값이 순서2 에서 실행되서 안됨 1순서에 row가 없어서*/

-- 해결 법--
-- 테이블 값에 별명 따로 줘서 출력하기--
SELECT  ru, /*순서 2 */
        fname,
        sa,
        da
FROM (
      SELECT  ROWNUM ru,  /*순서1 rownum을 불러오는 테이블에 생성해 1~~~마지막 값 을 미리 줌 별명 주는 이유 순서2에서rownum을 쓸시 순서 1에서 가져오는게 아닌 순서2에서 rownum을 사용한다로 인식*/
              first_name fname, 
              salary sa,
              hire_date da
      FROM( SELECT  first_name,
                    salary,
                    hire_date
            FROM employees
            ORDER by salary desc))
where ru <= 7
and ru >= 3; /*순서3 순서1에 있는 row를 가져와서 실행되서 가능*/
-- 테이블 자체에 이름 하나만 주고 출력하기 --
SELECT  o.ru, /*순서 2 */
        o.first_name,
        o.salary,
        o.hire_date
FROM (
      SELECT  ROWNUM ru,  /*순서 1 rownum을 불러오는 테이블에 생성해 1~~~마지막 값 을 미리 줌*/
              first_name, 
              salary,
              hire_date
      FROM( SELECT  first_name,
                    salary,
                    hire_date
            FROM employees
            ORDER by salary desc)) o
where o.ru >= 3
and o.ru <= 7;

-- 07년에 입사한 직원중에서 급여가 많은 직원 3~7의 이름 급여 입사일은?
SELECT  o.ru, /*순서 2 */
        o.first_name,
        o.salary,
        o.hire_date
FROM (
      SELECT  ROWNUM ru,  /*순서 1 rownum을 불러오는 테이블에 생성해 1~~~마지막 값 을 미리 줌*/
              first_name, 
              salary,
              hire_date
      FROM( SELECT  first_name,
                    salary,
                    hire_date
            FROM employees
            where  hire_date >= '07/01/14'
                   and hire_date <= '07/12/19'
            ORDER by salary desc)) o
where o.ru >= 3
and o.ru <= 7;

-- like 써서 확인하기--
SELECT  o.ru, /*순서 2 */
        o.first_name,
        o.salary,
        o.hire_date
FROM (
      SELECT  ROWNUM ru,  /*순서 1 rownum을 불러오는 테이블에 생성해 1~~~마지막 값 을 미리 줌*/
              first_name, 
              salary,
              hire_date
      FROM( SELECT  first_name,
                    salary,
                    hire_date
            FROM employees
            where  hire_date LIKE  '07%'
            ORDER by salary desc)) o
where o.ru >= 3
and o.ru <= 7;
--07년에 입사한 사원--
SELECT hire_date
FROM employees
where hire_date like '07%'
ORDER by hire_date DESC;

--07년에 입사한 직원중에서 급여가 많은 직원 3~7의 이름 급여 입사일+부서명은--
select  ort.rn,
        ort.first_name,
        ort.salary,
        ort.hire_date,
        ort.department_name
from (select rownum rn,
             ot.first_name,
             ot.salary,
             ot.hire_date,
             ot.department_name
      from (select  emp.first_name,
                    emp.salary,
                    emp.hire_date,
                    dep.department_name
            from employees emp, departments dep      ---(0) 부서명 때문에 조인
            where emp.department_id = dep.department_id(+)
            and hire_date >= '07/01/01'
            and hire_date < '08/01/01' 
            order by salary desc) ot     ----(1)
      ) ort   ----(2)
where ort.rn >= 3   ----(3)
and ort.rn <=7