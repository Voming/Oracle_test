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
select emp_name from employee where emp_name like '%연';
--13
select emp_name, phone from employee where phone not like '010%';
--14
select * from employee 
where email like '____#_%' escape '#' 
and dept_code in ('D9', 'D6') 
and hire_date BETWEEN  to_date('1990/01/01', 'RR/MM/DD') 
and to_date('2000/12/01', 'YY/MM/DD')
and salary >= 2700000;
--15
select emp_name, substr(emp_no, 0,2) "생년", substr(emp_no, 3,2) "생월", substr(emp_no, 4,2) "생일"
from employee;
--16
select emp_name, rpad(substr(emp_no, 0,7) ,13, '*') from employee;
--17
select emp_name, trunc ((sysdate - hire_date ) + 1 ) "근무일수1",
abs(trunc ((hire_date - sysdate ) + 1 ) )"근무일수2"
from employee;
--18
select * from employee where mod(to_number(substr(emp_no, 12,1)),2) != 0;
--19
select *
from employee
where trunc((( sysdate - hire_date ) + 1 ) / 365 ) > 20;
--20
select emp_name, TO_CHAR(SALARY, 'L999,999,999') from employee;
--21
select emp_name, dept_code, to_char(to_date(substr(emp_no, 0,6),'YYMMDD'), 'YY"년"MM"월"DD"일"' ) 생년월일, 
TRUNC(MONTHS_BETWEEN(sysdate, 19||to_date(substr(emp_no, 0,6),'YYMMDD'))/12) 만나이
from employee;
--22
select emp_id, emp_name, dept_code, decode(dept_code, 'D5', '총무부', 'D6', '기획부', 'D9', '영업부') 
from employee where dept_code in('D5','D6','D9') order by dept_code; 
--23
select emp_name, substr(emp_no, 0,6),substr(emp_no, 8,13),
to_number(substr(emp_no, 0,6)) + to_number(substr(emp_no, 8,13)) 합 from employee
where emp_name = '송종기';
--24
select sum((salary + salary*bonus)*12) from employee where dept_code='D5';
--25


