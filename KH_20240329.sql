INSERT INTO EMPLOYEE  -- 모든 칼럼에 INSERT하고 싶은 경우 칼럼 명 생략 가능
-- 단, 칼럼의 순서를 지켜서 VALUES값에 대입
VALUES(  --넣을 실제 값
	900, '장채현', '901123-1080503', 'jang_ch@kh.or.kr', 
	'01055569512', 'D1', 'J8','S3', 4300000, 0.2, '200', 
	SYSDATE, NULL, DEFAULT
);