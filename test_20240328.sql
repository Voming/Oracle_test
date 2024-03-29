--1
select * from job;
--2
select job_name from job;
--3
select * from department;
--4
select emp_name, email, phone, hire_date from employee;
--5
select hire_date, emp_name, salary from employee;
--6
SELECT
    emp_name,
    salary * 12 "연봉",
    floor(salary + nvl(bonus, 0)) * 12 "총수령액",
    floor((salary + nvl(bonus, 0)) * 12 -(salary * 12 * 0.03)) AS "실수령액"
FROM
    employee;
--7    
select emp_name, salary, hire_date, phone 
from employee
where sal_level = 'S1'; --대소문자 구분함
--8
select emp_name, salary, 
floor((salary + nvl(bonus, 0)) * 12 -(salary * 12 * 0.03)) "실수령액",
hire_date
from employee
where floor((salary + nvl(bonus, 0)) * 12 -(salary * 12 * 0.03)) >= 50000000;
--9
select * from employee 
where salary > 4000000 and job_code='J2';
--10
select emp_name, dept_code, hire_date
from employee
where (dept_code = 'D9' or dept_code = 'D5')
and hire_date <= to_date('02/01/01', 'YY/MM/DD');
--11
SELECT * FROM employee
where hire_date BETWEEN  to_date('1990/01/01', 'RR/MM/DD') 
and to_date('2001/01/01', 'YY/MM/DD');  --YY라고 스면 2000년대인줄 앎 / RR을 사용하면 1900년대
--12