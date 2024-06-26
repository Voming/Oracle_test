--1 
SELECT STUDENT_NAME,STUDENT_ADDRESS FROM TB_STUDENT
ORDER BY STUDENT_NAME;
--2
SELECT STUDENT_NAME, STUDENT_SSN FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y';
--3
SELECT STUDENT_NAME, STUDENT_NO, STUDENT_ADDRESS FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '경기도%' OR STUDENT_ADDRESS LIKE '강원도%')
AND SUBSTR(entrance_date,1,1) = 9 
ORDER BY STUDENT_NAME;

SELECT DECODE(SUBSTR(STUDENT_SSN,8,1), 1, 19||SUBSTR(STUDENT_SSN, 1,2), 2, 19||SUBSTR(STUDENT_SSN, 1,2), 20||SUBSTR(STUDENT_SSN, 1,2)) FROM TB_STUDENT;
--4
SELECT PROFESSOR_NAME, PROFESSOR_SSN FROM TB_PROFESSOR
ORDER BY SUBSTR(PROFESSOR_SSN,1,6) DESC;
--5
SELECT STUDENT_NO, POINT FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC;
--6
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;
--7
SELECT CLASS_NAME, DEPARTMENT_NAME FROM TB_DEPARTMENT
JOIN TB_CLASS USING (DEPARTMENT_NO);
--8
SELECT CLASS_NAME, PROFESSOR_NAME FROM TB_PROFESSOR
JOIN TB_CLASS USING (DEPARTMENT_NO);
--9
SELECT CLASS_NAME, PROFESSOR_NAME FROM TB_PROFESSOR
JOIN TB_CLASS USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO IN (SELECT  DEPARTMENT_NO FROM TB_DEPARTMENT WHERE CATEGORY = '인문사회');
--10
SELECT STUDENT_NO, STUDENT_NAME, ROUND(AVG(POINT), 1) 
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
GROUP BY STUDENT_NO, STUDENT_NAME;
--11
SELECT DEPARTMENT_NAME, STUDENT_NAME, PROFESSOR_NAME FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR USING (DEPARTMENT_NO);
--12
SELECT STUDENT_NAME, TERM_NO FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE CLASS_NO = (SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME ='인간관계론')
AND SUBSTR(TERM_NO,1,4) = 2007;
--13
SELECT CLASS_NAME, DEPARTMENT_NAME FROM TB_CLASS
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    LEFT JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
    JOIN TB_CLASS_PROFESSOR USING(PROFESSOR_NO)
    WHERE CATEGORY = '예체능' AND PROFESSOR_NAME IS NULL;
--14
