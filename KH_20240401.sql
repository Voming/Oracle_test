SELECT * FROM USER_DUCTIBBARY;
SELECT * FROM USER_VIES;
SELECT * FROM user_constraints;
SELECT * FROM user_cons_columns;
CREATE TABLE T8(
C1 VARCHAR2(10),
C2 VARCHAR2(10),
C3 CHAR(10),
C4 NCHAR(10)); --NCHAR cHAR N개 만큼


INSERT INTO T8 VALUES('1234567890','1234567890','1234567890','1234567890');
INSERT INTO T8 VALUES('123456789가','123456789가','123456789가','123456789가');  --너무 큼(실제 12, 최대ㅏ
INSERT INTO T8 VALUES('1234567890','1234567890','1234567890','1234567890');

CREATE UNIQUE INDEX IDX_COLUMNS ON EMPLOYEE(EMP_NO);

SELECT * FROM USER_IND_COLUMNS;

CREATE UNIQUE INDEX IDX_DEPTCODE ON EMPLOYEE(DEPT_CODE);  -- 중복값이 있는 칼럼이라 오류 발생

CREATE INDEX IDX_DEPTCODE ON EMPLOYEE(DEPT_CODE); -- NONUNIQUE INDEX는 중복값있어도 생성 가능

select to_char(sysdate, 'yy') from dual;

select case 
    when  substr(professor_ssn,1,6) > to_char(sysdate, 'yy') then 
    else 
    end birthday

,   to_date(substr(professor_ssn,1,6),'rrmmdd') a1
 to_date(substr(professor_ssn,1,6),'rrmmdd') a2
