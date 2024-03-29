CREATE TABLE DEPT_COPY AS
SELECT * FROM DEPT_copy;
desc dept_copy;

select * from dept_copy;

ALTER TABLE DEPT_COPY ADD (CNAME VARCHAR2(20));

ALTER TABLE DEPT_COPY ADD (LNAME VARCHAR2(20) DEFAULT '한국');

ALTER TABLE DEPT_COPY ADD (CNAME VARCHAR2(20));

ALTER TABLE DEPT_COPY
	ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPTNO);

ALTER TABLE DEPT_COPY
	ADD CONSTRAINT DCOPY_DNAME_UNQ UNIQUE(DNAME);
ALTER TABLE DEPT_COPY
	MODIFY LOC CONSTRAINT DCOPY_LOC_NN NOT NULL;
    
    
SELECT * FROM USER_CONSTRAINTS;

ALTER TABLE DEPT_COPY
    MODIFY DEPTNO CHAR(3);
ALTER TABLE DEPT_COPY
    MODIFY DNAME VARCHAR2(30);
ALTER TABLE DEPT_COPY
    MODIFY LOC VARCHAR2(10);
ALTER TABLE DEPT_COPY
    MODIFY LNAME DEFAULT '미국';
    
INSERT INTO dept_copy(DEPTNO, dname, LOC) VALUES ('50', 'NON', 'LA');

ALTER TABLE DEPT_COPY DROP COLUMN LOC;

CREATE TABLE TB1(
PK NUMBER PRIMARY KEY,
FK NUMBER REFERENCES TB1,
COL1 NUMBER,
CHECK(PK > 0 AND COL1 > 0)
);

ALTER TABLE TB1
DROP COLUMN PK;
--명령의 44 행에서 시작하는 중 오류 발생 -
--ALTER TABLE TB1
--DROP COLUMN PK
--오류 보고 -
--ORA-12992: 부모 키 열을 삭제할 수 없습니다
--12992. 00000 -  "cannot drop parent key column"
--*Cause:    An attempt was made to drop a parent key column.
--*Action:   Drop all constraints referencing the parent key column, or
--           specify CASCADE CONSTRAINTS in statement.


ALTER TABLE TB1
	DROP COLUMN PK CASCADE CONSTRAINT;
    
    
