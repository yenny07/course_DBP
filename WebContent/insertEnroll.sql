CREATE OR REPLACE PROCEDURE InserEnroll(studentID IN VARCHAR2, courseID IN VARCHAR2,
					courseIDNO IN NUMBER, result OUT VARCHAR2 )
IS
	credit_limit_over EXCEPTION;
	duplicate_course EXCEPTION;
	too_many_students EXCEPTION;
	duplicate_time EXCEPTION;
	courseSUM NUMBER;
	courseCREDIT NUMBER;
	courseCOUNT NUMBER;
	courseMAX NUMBER;
	courseCURRENT NUMBER;

BEGIN
	result := "";
	DBMS_OUTPUT.put_line(studentID || '님이 과목번호 ' || courseID ||
	', 분반 ' || courseIDNO || '의 수강 등록을 요청하였습니다.');

	/*최대학점 초과*/
	SELECT SUM(c.c_credit)
	INTO courseSUM
	FROM course c, enroll e
	WHERE e.s_id = studentID AND e.c_id = c.c_id AND e.c_number = c.c_number;

	SELECT c_credit
	INTO courseCREDIT
	FROM course
	WHERE c_id = courseID AND c_number = courseIDNO;

	IF( courseSUM + courseCREDIT >18) THEN
		RAISE credit_limit_over EXCEPTION;
	END IF;

	/*중복된 과목*/
	SELECT COUNT(*)
	INTO courseCOUNT
	FROM enroll
	WHERE s_id = studentID AND c_id = courseID;

	IF (courseCOUNT > 0) THEN
		RAISE duplicate_course;
	END if;

	/*수강신청 인원 초과*/
	SELECT c_max, c_current
	INTO courseMAX, courseCURRENT
	FROM course
	WHERE c_id = courseID;

	IF ( (courseCURRENT+1) > course MAX) THEN
		RAISE too_many_students;
	END IF;
	
	/*중복된 시간*/
	SELECT COUNT(*)
	INTO courseCOUNT
	FROM course c
	WHERE c.c_id = courseID AND c.c_period IN  (SELECT c_period
						FROM 