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
--25. EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
--전체 직원 수, 2001년, 2002년, 2003년, 2004년
--WHERE, GROUP BY, HAVING은 행을 뽑아내는 식이다.
SELECT COUNT(*) 전체직원수
, COUNT(DECODE( EXTRACT(YEAR FROM HIRE_DATE), '2001', 0,NULL)) "2001년"
, COUNT(DECODE( EXTRACT(YEAR FROM HIRE_DATE), '2002', 0,NULL))  "2002년"
, COUNT(DECODE( EXTRACT(YEAR FROM HIRE_DATE), '2003', 0,NULL))  "2003년"
, COUNT(DECODE( EXTRACT(YEAR FROM HIRE_DATE), '2004', 0,NULL))  "2004년"
FROM EMPLOYEE;

--안에 들어갈 내용 확인
SELECT COUNT(DECODE( EXTRACT(YEAR FROM HIRE_DATE), '2001', 0,NULL)) FROM EMPLOYEE;
--둘이 결과 같음
--그룹함수는 그룹바이에 써야 되기때문에 이게 들어가면 복잡해짐
SELECT COUNT(*) FROM EMPLOYEE WHERE EXTRACT(YEAR FROM HIRE_DATE) = '2001';

----------추가 문제풀이
--04_KH
--8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
SELECT T1.EMP_NAME, T1.DEPT_CODE, T2.EMP_NAME
    FROM EMPLOYEE T1
        JOIN EMPLOYEE T2 ON (T1.DEPT_CODE = T2.DEPT_CODE) --SELF조인
    WHERE T1.EMP_NAME <> T2.EMP_NAME 
    ORDER BY T1.EMP_NAME, T2.EMP_NAME;

--04_KH
--11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
--JOIN, HAVING
SELECT DEPT_TITLE, SUM(SALARY) 
    FROM EMPLOYEE E
        JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    GROUP BY DEPT_TITLE
    HAVING SUM(SALARY) > ANY(SELECT SUM(SALARY)*0.2 FROM EMPLOYEE)
    ORDER BY DEPT_TITLE;
--인라인 뷰
SELECT DEPT_TITLE, SUMSAL  FROM(
    SELECT DEPT_TITLE, SUM(SALARY) SUMSAL
    FROM EMPLOYEE E
        JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID) 
             GROUP BY DEPT_TITLE)
             HAVING SUM(SALARY) > ANY(SELECT SUM(SALARY)*0.2 FROM EMPLOYEE)
             ORDER BY DEPT_TITLE;

--WITH 사용

select dept_title , sum(salary)
    from employee e
        join department d on (e.dept_code=d.dept_id)
    group by dept_title
    having sum(salary) > any( select sum(salary)*0.2 from employee) 
;
select dept_title , sum(salary)
    from ( select dept_title, salary from employee e join department d on (e.dept_code=d.dept_id)) t1
    group by dept_title
    having sum(salary) > any( select sum(salary)*0.2 from employee) 
;
select dept_title , sum_sal
    from ( select dept_title, sum(salary) sum_sal
            from employee e join department d on (e.dept_code=d.dept_id)
            group by dept_title
        ) t1
    where sum_sal > any( select sum(salary)*0.2 from employee) 
;
with t1 as ( select dept_title, sum(salary) sum_sal
                from employee e join department d on (e.dept_code=d.dept_id)
                group by dept_title
            ) 
select dept_title, sum_sal from t1 where sum_sal > any( select sum(salary)*0.2 from employee)
;


--05_실습_SQL02_SELECT(Function)
--15.학번이 A112113 인 김고은 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총     평점을 SQL 문을 작성하시오.(단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
--ROLLUP, CUBE, GROUPING 고려
SELECT
    nvl((substr(term_no, 1, 4)), ' ')              년도,
    nvl((substr(term_no, 5, 2)), ' ')              학기,
    round(AVG(point), 1)                           avg_point
FROM
    tb_grade
WHERE
    student_no = 'A112113'
GROUP BY
    ROLLUP((substr(term_no, 1, 4)),
           (substr(term_no, 5, 2)))
ORDER BY NULL;
    

SELECT * FROM TB_STUDENT WHERE STUDENT_NO = 'A112113';



