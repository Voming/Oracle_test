--2024.04.02--
--SEQUENCE
--테이블과 연관 연결이 없음
--테이블과 관련은 있음
CREATE SEQUENCE SEQ_TEST;
SELECT SEQ_TEST.NEXTVAL FROM DUAL;

DESC DEPT;
SELECT * FROM DEPT;

INSERT INTO DEPT VALUES ((SELECT MAX(DEPTNO)+1 FROM DEPT), 'KH', 'SEOUL', '50');

CREATE SEQUENCE SEQ_DEPT_DEPTNO START WITH 60;
INSERT INTO DEPT VALUES (SEQ_DEPT_DEPTNO.NEXTVAL, 'KH', 'SEOUL', '50');


INSERT INTO DEPT VALUES((SELECT NVL(MAX(DEPTNO),0 )+1 FROM DEPT), 'KH', 'SEOUL', '50');

CREATE SEQUENCE SEQ_DEPT_DEPTNO2 START WITH 98;
INSERT INTO DEPT VALUES (SEQ_DEPT_DEPTNO2.NEXTVAL, 'KH', 'SEOUL', '50');

SELECT SEQ_DEPT_DEPTNO2.NEXTVAL FROM DUAL;

ALTER SEQUENCE SEQ_DEPT_DEPTNO2 MAXVALUE 100 CYCLE;

SELECT * FROM USER_SEQUENCES;

DROP SEQUENCE SEQ_DEPT_DEPTNO2;
CREATE SEQUENCE SEQ_DEPT_DEPTNO3 START WITH 70 MAXVALUE 99 CYCLE;

CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID.CURRVAL FROM DUAL;
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; 
SELECT * FROM USER_SEQUENCES;