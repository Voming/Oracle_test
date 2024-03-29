
CREATE TABLE T1 (BRITHDAY DATE, NAME VARCHAR2(30));
COMMENT ON COLUMN T1.BRITHDAY IS '생년월일';

update employee set emp_name='홍길동';
select * from employee;
ROLLBACK;

INSERT INTO EMPLOYEE
VALUES(1, '홍길동', '820114-1010101', 'hong_kd@kh.or.kr', 
'01099998888', 'D5', 'J2', 'S4', 3800000,
NULL, '200', SYSDATE, NULL, DEFAULT);

UPDATE EMPLOYEE
SET EMP_ID = 290
WHERE EMP_NAME = '홍길동';

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '홍길동';

INSERT INTO T1 VALUES (SYSDATE, NULL);

DROP TABLE T1;

CREATE TABLE T1 (
birthday DATE, 
name VARCHAR2(30) PRIMARY KEY,
gender char(1) check(gender in('f', 'm')));

INSERT INTO T1 VALUES (SYSDATE, '공유', 'm');


INSERT INTO T1(birthday, name) VALUES (SYSDATE, NULL);
--명령의 21 행에서 시작하는 중 오류 발생 -
--INSERT INTO T1 VALUES (SYSDATE, NULL)
--오류 보고 -
--ORA-01400: NULL을 ("KH"."T1"."NAME") 안에 삽입할 수 없습니다

INSERT INTO T1 VALUES (SYSDATE, '홍길동');
--명령의 31 행에서 시작하는 중 오류 발생 -
--INSERT INTO T1 VALUES (SYSDATE, '홍길동')
--오류 보고 -
--ORA-00001: 무결성 제약 조건(KH.SYS_C008364)에 위배됩니다

DESC T1;

----------오류 판단시  DICTIONARY 딕셔너리 사용
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_VIEWS;

DESC USER_CONSTRAINTS;
DESC USER_CONS_COLUMNS;

create table t2(
gender char(1),
check(gender in ('m', 'f')),
name varchar(30),
foreign key (name) REFERENCES t1(name)
);

INSERT INTO T1 VALUES (SYSDATE, '홍길동', 'm');
INSERT INTO T1 VALUES (SYSDATE, '홍길동2', 'm');

insert into t2 values (null, '홍길동'); -- 외래키는 unique는 아님
insert into t2 values (null, '홍길동2'); -- 부모에 있는 것만 넣을 수 있다

update t1 set name='홍길동3' where name='홍길동'; 
--명령의 69 행에서 시작하는 중 오류 발생 -
--update t1 set name='홍길동3' where name='홍길동'
--오류 보고 -
--ORA-02292: 무결성 제약조건(KH.SYS_C008371)이 위배되었습니다- 자식 레코드가 발견되었습니다

delete from t2 where name='홍길동';  -- 외래키 오류 발생 방지 
--1. t2에서 쓰는 홍길동 모두 삭제
--2. t2 홍길동에 null 넣어주기

drop table t2;
drop table t1;


CREATE TABLE USER_NOTNULL(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
); --생성 성공

INSERT INTO USER_NOTNULL VALUES(1, NULL, 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr'); 
--명령의 93 행에서 시작하는 중 오류 발생 -
--INSERT INTO USER_NOTNULL VALUES(1, NULL, 'pass01', '홍길동', '남'
--, '010-1234-5678', 'hong123@kh.or.kr')
--오류 보고 -
--ORA-01400: NULL을 ("KH"."USER_NOTNULL"."USER_ID") 안에 삽입할 수 없습니다


CREATE TABLE USER_UNIQUE(
	USER_NO NUMBER,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30)
);

INSERT INTO USER_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동');
INSERT INTO USER_UNIQUE VALUES(1,'user01', 'pass01', NULL);
--명령의 110 행에서 시작하는 중 오류 발생 -
--INSERT INTO USER_UNIQUE VALUES(1,'user01', 'pass01', NULL)
--오류 보고 -
--ORA-00001: 무결성 제약 조건(KH.SYS_C008376)에 위배됩니다


-- 생성 방법 1
CREATE TABLE USER_PRIMARYKEY( 
	USER_NO NUMBER PRIMARY KEY, 
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30)
);

-- 생성 방법 2
CREATE TABLE USER_PRIMARYKEY( 
	USER_NO NUMBER, 
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	PRIMARY KEY (USER_NO)
);

INSERT INTO USER_PRIMARYKEY VALUES(1, 'user01', 'pass01', '홍길동'); -- 성공

INSERT INTO USER_PRIMARYKEY VALUES(1, 'user01', 'pass01', '홍길동'); -- 실패
--명령의 135 행에서 시작하는 중 오류 발생 -
--INSERT INTO USER_PRIMARYKEY VALUES(1, 'user01', 'pass01', '홍길동')
--오류 보고 -
--ORA-00001: 무결성 제약 조건(KH.SYS_C008378)에 위배됩니

INSERT INTO USER_PRIMARYKEY VALUES(NULL, 'user01', 'pass01', '홍길동'); -- 실패
--명령의 141 행에서 시작하는 중 오류 발생 -
--INSERT INTO USER_PRIMARYKEY VALUES(NULL, 'user01', 'pass01', '홍길동')
--오류 보고 -
--ORA-01400: NULL을 ("KH"."USER_PRIMARYKEY"."USER_NO") 안에 삽입할 수 없습니다


-- 부모 테이블
CREATE TABLE USER_GRADE(
GRADE_CODE NUMBER PRIMARY KEY,
GRADE_NAME VARCHAR2(30) NOT NULL
);
-- 행 삽입
INSERT INTO USER_GRADE VALUES(10, '일반회원');
INSERT INTO USER_GRADE VALUES(20, '우수회원');
INSERT INTO USER_GRADE VALUES(30, '특별회원');

SELECT * FROM USER_GRADE;

CREATE TABLE USER_FOREIGNKEY(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GRADE_CODE NUMBER REFERENCES USER_GRADE (GRADE_CODE)
);

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', '홍길동', 10); 

INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '이순신', 20); 

INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '유관순', 30); 

INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '심사임당', NULL); 

INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '안중근', 50); 

--명령의 180 행에서 시작하는 중 오류 발생 -
--INSERT INTO USER_FOREIGNKEY
--VALUES(5, 'user05', 'pass05', '안중근', 50)
--오류 보고 -
--ORA-02291: 무결성 제약조건(KH.SYS_C008385)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', '홍길동', 10);

CREATE TABLE T7(
    C1 NUMBER CONSTRAINT T7_PK_C1 PRIMARY KEY,
    C2 NUMBER CONSTRAINT T7_NN_C2 NOT NULL,
    C3 NUMBER CONSTRAINT T7_UQ_C3 UNIQUE,
    C4 NUMBER CONSTRAINT T7_FK_C4 REFERENCES DEPT 
);

CREATE OR REPLACE VIEW V_EMPLOYEE
	AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, NATIONAL_NAME
	FROM EMPLOYEE
	LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
	LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
	LEFT JOIN NATIONAL USING(NATIONAL_CODE);
--오류 보고 -
--ORA-01031: 권한이 불충분합니다
--01031. 00000 -  "insufficient privileges"
--*Cause:    An attempt was made to perform a database operation without
--           the necessary privileges.
--*Action:   Ask your database administrator or designated security
--           administrator to grant you the necessary privileges

SELECT * FROM v_employee;

DESC EMPLOYEE;

INSERT INTO EMPLOYEE VALUES ('999', '홍길동', '000327-4123415',
'KH@KH.AC.KR','01012341234', 'D9', 'J1', '1', 300, NULL, '207', SYSDATE,'N');

CREATE OR REPLACE VIEW V_JOB(이름, 직급)
	AS SELECT JOB_CODE, JOB_NAME
	FROM JOB;

INSERT INTO V_JOB VALUES('J8', '인턴');

SELECT * FROM V_JOB;

SELECT * FROM JOB;

DROP VIEW V_EMP_JOB;

SELECT * FROM EMPLOYEE WHERE 1<>1;
SELECT * FROM EMPLOYEE WHERE 1<>0;

CREATE TABLE EMPLOYEE_COPY 
    AS SELECT * FROM EMPLOYEE WHERE 1<>1;
    
SELECT * FROM EMPLOYEE_COPY;