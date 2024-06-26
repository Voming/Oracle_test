CREATE UNIQUE INDEX IDX_EMPNO
ON EMPLOYEE(EMP_NO);

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

CREATE INDEX IDX_DEPTCODE ON EMPLOYEE(DEPT_CODE);

CREATE INDEX IDX_DEPT ON DEPARTMENT(DEPT_ID, DEPT_TITLE);

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'DEPARTMENT';

CREATE TABLE EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS, 
(SALARY +(SALARY +NVL(BONUS, 0))) * 12 연봉
FROM EMPLOYEE;

CREATE INDEX IDX_SALCALC ON EMP_SAL((SALARY +(SALARY +NVL(BONUS, 0))) * 12);

SELECT * FROM EMP_SAL;

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMP_SAL';

DELETE FROM EMP_SAL WHERE EMP_ID = 200;

ALTER INDEX IDX_SALCALC REBUILD;

SELECT * FROM EMPLOYEE ORDER BY EMP_NO;

SELECT * FROM EMPLOYEE WHERE EMP_NO > '0';
