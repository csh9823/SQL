--단일행 함수--
--문자함수 – INITCAP(컬럼명)--
SELECT  email,
        email,
        department_id
FROM employees
where department_id = 100
;
--영어의 첫 글자만 대문자로 출력하고 나머지는 전부 소문자로 출력하는 함수--
SELECT  email,
        initcap(email) "앞 에만 대문자",
        department_id
FROM employees
where department_id = 100
;

--문자함수 – INITCAP(컬럼명) LOWER(컬럼명) / UPPER(컬럼명) • 입력되는 값을 전부 소문자/대문자로 변경하는 함수--
SELECT  first_name,
        lower(first_name) 소문자, --소문자 출력--
        upper(first_name) 대문자
FROM employees
where department_id = 100
;
--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수) 주어진 문자열에서 특정길이의 문자열을 구하는 함수--

SELECT  first_name,
        substr(first_name, 1 ,3) "첫번째 부터 3번째까지",
        substr(first_name, -3 ,2) "끝에서 3째부터2째까지"
from employees
where department_id = 100
;

--■ 문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) / RPAD(컬럼명, 자리수, ‘채울문자’)--
select  first_name,
        lpad(first_name,10,'*'), --10글짜 만들기 10글자 미만 일 경우 나머지 왼쪽부터 *추력
        rpad(first_name,10,'*')  --10글짜 만들기 10글자 미만 일 경우 나머지 오른쪽부터 *추력
from employees;

--문자함수 – REPLACE (컬럼명, 문자1, 문자2)--

--컬럼명에서 문자1을 문자2로 바꾸는 함수--
select  first_name,
        replace(first_name, 'a', '*') --a를 *로 바꾸기--
from employees
where department_id =100;

-- 응용 자릿수 정해서 *로 바꾸기--
select  first_name,
        replace(first_name, 'a', '*'), --a를 *로 바꾸기--
        replace(first_name, substr(first_name, 2, 3), '*') --앞에서 2번째 부터 뒤에서 3번째 까지 *로 출력--
from employees
where department_id =100;

--숫자함수 – ROUND(숫자, 출력을 원하는 자리수)--
--주어진 숫자를 반올림 하는 함수--
select  round(123.346, 2) "r2",
        round(123.646, 0) "r0",
        round(123.346, -1) "r-1",
        round(123.346, -2) "r-2",
        round(123.346, -3) "r-3"
from dual; -- 가상의 테이블 --

--■ 숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) --
--주어진 숫자의 버림을 하는 함수--
select trunc(123.346, 2) "r2",
trunc(123.456, 0) "r0",
trunc(123.456, -1) "r-1"
from dual;

--날짜함수 – SYSDATE()--

select sysdate
from dual;


select  sysdate,
        hire_date,
        months_between(sysdate, hire_date)
from employees
where department_id = 100;

--■ TO_CHAR(숫자, ‘출력모양’) 숫자형문자형으로 변환하기--

select  first_name,
        salary,
        salary*12,
        to_char(salary*12, '$999999'), --to_char(salary*12, '$999999' --> 9숫자는 자릿수  8 7 다른 수 쓰면 오류남 부족하면 #으로 나옴 최대한 많이 줄 것)
        to_char(salary*12, '00000999999'),
        to_char(salary*12, '999999999'),
        to_char(salary*12, '9999999.99'),
        to_char(salary*12, '999,999,999')
from employees
where department_id = 100;

--변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로 변환하기--
select  sysdate,
        to_char(sysdate,'yy'), -- 기준 21/12/16 표현 21--
        to_char(sysdate,'yyyy'), -- 기준 21/12/16 표현 2021--
        to_char(sysdate, 'MM'), -- 기준 21/12/16 표현 12--
        to_char(sysdate, 'DD'), -- 기준 21/12/16 표현 16--
        to_char(sysdate, 'HH'),  -- 시간 표현 현재 시간 시
        to_char(sysdate, 'MI'), -- 현재 시간 분
        to_char(sysdate, 'SS'), -- 현재 시간 초
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') -- 원하는 문자는 “년” 형태로쌍따옴표로 추가 가능 --
 from dual;
 
select  sysdate,
        to_char(sysdate, 'DD'), -- 기준 21/12/16 표현 16--
        hire_date,
        to_char(hire_date, 'MM')
 from employees;

--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)--

SELECT  first_name,
        commission_pct,
        nvl(commission_pct,0), --null이면 0 표시
        nvl2(commission_pct,100,0) --null이 아니면 100 null이면 0
FROM employees;

SELECT * FROM employees;