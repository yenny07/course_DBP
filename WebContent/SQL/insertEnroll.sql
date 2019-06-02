CREATE OR REPLACE PROCEDURE InsertEnroll(studentID IN VARCHAR2, courseID IN VARCHAR2,
               courseIDNO IN NUMBER, result OUT VARCHAR2 )
IS
   CURSOR courseLIST(student_id VARCHAR2) IS
   SELECT NVL(c_id, 0) c_id
   FROM enroll
   WHERE s_id = student_id;

   credit_limit_over EXCEPTION;
   duplicate_course EXCEPTION;
   too_many_students EXCEPTION;
   duplicate_period EXCEPTION;
   courseSUM NUMBER;
   courseCREDIT NUMBER;
   courseCOUNT NUMBER;
   periodCOUNT1 NUMBER;
   periodCOUNT2 NUMBER;
   courseMAX NUMBER;
   courseCURRENT NUMBER;

BEGIN
<<<<<<< HEAD
   result := ' ';
   
   DBMS_OUTPUT.put_line(studentID || '´ÔÀÌ °ú¸ñ¹øÈ£ ' || courseID ||
   ', ºÐ¹Ý ' || courseIDNO || 'ÀÇ ¼ö°­ µî·ÏÀ» ¿äÃ»ÇÏ¿´½À´Ï´Ù.');

   /*ÃÖ´ëÇÐÁ¡ ÃÊ°ú*/
   SELECT SUM(c.c_credit)
   INTO courseSUM
   FROM course c, enroll e
   WHERE e.s_id = studentID AND e.c_id = c.c_id and e.c_number = c.c_number;
   
   IF courseSUM IS NULL THEN
      courseSUM := 0;
   END IF;   

   SELECT c_credit
   INTO courseCREDIT
   FROM course
   WHERE c_id = courseID AND c_number = courseIDNO;
   
   DBMS_OUTPUT.put_line(courseSUM || ' / ' || courseCREDIT);
   
   IF (courseSUM + courseCREDIT) >18 THEN
      RAISE credit_limit_over;
   END IF;

   /*Áßº¹µÈ °ú¸ñ*/
   FOR course_list IN courseLIST(studentID) LOOP
      IF course_list.c_id = courseID THEN
         RAISE duplicate_course;
      END IF;
   END LOOP;

   /*¼ö°­½ÅÃ» ÀÎ¿ø ÃÊ°ú*/
   SELECT c_max, c_current
   INTO courseMAX, courseCURRENT
   FROM course
   WHERE c_id = courseID AND c_number = courseIDNO;

   DBMS_OUTPUT.put_line(courseMAX || ' / ' || courseCURRENT);

   IF (courseCURRENT+1) > courseMAX THEN
      RAISE too_many_students;
   END IF;
   
   /*Áßº¹µÈ ½Ã°£*/
   SELECT COUNT(*)
   INTO periodCOUNT1
   FROM course c
   WHERE c.c_id = courseID AND c.c_period IN (SELECT c.c_period
         FROM enroll e, course c 
         WHERE e.s_id = studentID AND e.c_id = c.c_id AND c.c_id != courseID AND e.c_number = c.c_number 
                     AND (e.c_id, e.c_number) IN (
                     SELECT enrolled_c.c_id, enrolled_c.c_number
                     FROM course new_c INNER JOIN course enrolled_c
                     ON new_c.c_day1 = enrolled_c.c_day1
                     WHERE new_c.c_id = courseID));

   SELECT COUNT(*)
   INTO periodCOUNT2
   FROM course c
   WHERE c.c_id = courseID AND c.c_period IN (SELECT c.c_period
         FROM enroll e, course c 
         WHERE e.s_id = studentID AND e.c_id = c.c_id AND c.c_id != courseID AND e.c_number = c.c_number 
                     AND (e.c_id, e.c_number) IN (
                     SELECT enrolled_c.c_id, enrolled_c.c_number
                     FROM course new_c INNER JOIN course enrolled_c
                     ON new_c.c_day2 = enrolled_c.c_day2
                     WHERE new_c.c_id = courseID));

   DBMS_OUTPUT.put_line(periodCOUNT1 || ' / ' || periodCOUNT2);

   IF periodCOUNT1 > 0 OR periodCOUNT2 > 0 THEN
      RAISE duplicate_period;
   END IF;

   INSERT INTO enroll(s_id, c_id, c_number)
   VALUES (studentID, courseID, courseIDNO);
   
   UPDATE course
   SET c_current = courseCURRENT + 1
   WHERE c_id = courseID AND c_number = courseIDNO;

   UPDATE student
   SET s_credit = (courseSUM + courseCREDIT)
   WHERE s_id = studentID;

   result := '¼ö°­½ÅÃ»ÀÌ ¿Ï·áµÇ¾ú½À´Ï´Ù.';
   DBMS_OUTPUT.put_line(result);

   COMMIT;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.put_line('no data found');
   WHEN credit_limit_over THEN
      result := 'ÃÖ´ëÇÐÁ¡À» ÃÊ°úÇÏ¿´½À´Ï´Ù.';
      DBMS_OUTPUT.put_line(result);
   WHEN duplicate_course THEN
      result :='ÀÌ¹Ì ¼ö°­½ÅÃ»ÇÑ °ú¸ñÀÔ´Ï´Ù.';
      DBMS_OUTPUT.put_line(result);
   WHEN too_many_students THEN
      result :='ÃÖ´ë ¼ö°­½ÅÃ» ÀÎ¿øÀ» ÃÊ°úÇÏ¿© µî·ÏÇÒ ¼ö ¾ø½À´Ï´Ù.';
      DBMS_OUTPUT.put_line(result);
   WHEN duplicate_period THEN
      result :='°°Àº ½Ã°£¿¡ ¼ö°­½ÅÃ»ÇÑ °ú¸ñÀÌ ÀÖ½À´Ï´Ù.';
      DBMS_OUTPUT.put_line(result);
   WHEN OTHERS THEN
      ROLLBACK;
      result := SQLCODE;
      DBMS_OUTPUT.put_line(result);
=======
	result := ' ';
	
	DBMS_OUTPUT.put_line(studentID || 'ë‹˜ì´ ê³¼ëª©ë²ˆí˜¸ ' || courseID ||
	', ë¶„ë°˜ ' || courseIDNO || 'ì˜ ìˆ˜ê°• ë“±ë¡ì„ ìš”ì²­í•˜ì˜€ìŠµë‹ˆë‹¤.');

	/*ìµœëŒ€í•™ì  ì´ˆê³¼*/
	SELECT SUM(c.c_credit)
	INTO courseSUM
	FROM course c, enroll e
	WHERE e.s_id = studentID AND e.c_id = c.c_id and e.c_number = c.c_number;
	
	IF courseSUM IS NULL THEN
		courseSUM := 0;
	END IF;	

	SELECT c_credit
	INTO courseCREDIT
	FROM course
	WHERE c_id = courseID AND c_number = courseIDNO;
	
	DBMS_OUTPUT.put_line(courseSUM || ' / ' || courseCREDIT);
	
	IF (courseSUM + courseCREDIT) >18 THEN
		RAISE credit_limit_over;
	END IF;

	/*ì¤‘ë³µëœ ê³¼ëª©*/
	FOR course_list IN courseLIST(studentID) LOOP
		IF course_list.c_id = courseID THEN
			RAISE duplicate_course;
		END IF;
	END LOOP;

	/*ìˆ˜ê°•ì‹ ì²­ ì¸ì› ì´ˆê³¼*/
	SELECT c_max, c_current
	INTO courseMAX, courseCURRENT
	FROM course
	WHERE c_id = courseID AND c_number = courseIDNO;

	DBMS_OUTPUT.put_line(courseMAX || ' / ' || courseCURRENT);

	IF (courseCURRENT+1) > courseMAX THEN
		RAISE too_many_students;
	END IF;
	
	/*ì¤‘ë³µëœ ì‹œê°„*/
	SELECT COUNT(*)
	INTO periodCOUNT1
	FROM course c
	WHERE c.c_id = courseID AND c.c_period IN (SELECT c.c_period
			FROM enroll e, course c 
			WHERE e.s_id = studentID AND e.c_id = c.c_id AND c.c_id != courseID AND e.c_number = c.c_number 
							AND (e.c_id, e.c_number) IN (
							SELECT enrolled_c.c_id, enrolled_c.c_number
							FROM course new_c INNER JOIN course enrolled_c
							ON new_c.c_day1 = enrolled_c.c_day1
							WHERE new_c.c_id = courseID));

	SELECT COUNT(*)
	INTO periodCOUNT2
	FROM course c
	WHERE c.c_id = courseID AND c.c_period IN (SELECT c.c_period
			FROM enroll e, course c 
			WHERE e.s_id = studentID AND e.c_id = c.c_id AND c.c_id != courseID AND e.c_number = c.c_number 
							AND (e.c_id, e.c_number) IN (
							SELECT enrolled_c.c_id, enrolled_c.c_number
							FROM course new_c INNER JOIN course enrolled_c
							ON new_c.c_day2 = enrolled_c.c_day2
							WHERE new_c.c_id = courseID));

	DBMS_OUTPUT.put_line(periodCOUNT1 || ' / ' || periodCOUNT2);

	IF periodCOUNT1 > 0 OR periodCOUNT2 > 0 THEN
		RAISE duplicate_period;
	END IF;

	INSERT INTO enroll(s_id, c_id, c_number)
	VALUES (studentID, courseID, courseIDNO);
	
	UPDATE course
	SET c_current = courseCURRENT + 1
	WHERE c_id = courseID AND c_number = courseIDNO;

	UPDATE student
	SET s_credit = (courseSUM + courseCREDIT)
	WHERE s_id = studentID;

	result := 'ìˆ˜ê°•ì‹ ì²­ì´ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤.';
	DBMS_OUTPUT.put_line(result);

	COMMIT;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.put_line('no data found');
	WHEN credit_limit_over THEN
		result := 'ìµœëŒ€í•™ì ì„ ì´ˆê³¼í•˜ì˜€ìŠµë‹ˆë‹¤.';
		DBMS_OUTPUT.put_line(result);
	WHEN duplicate_course THEN
		result :='ì´ë¯¸ ìˆ˜ê°•ì‹ ì²­í•œ ê³¼ëª©ìž…ë‹ˆë‹¤.';
		DBMS_OUTPUT.put_line(result);
	WHEN too_many_students THEN
		result :='ìµœëŒ€ ìˆ˜ê°•ì‹ ì²­ ì¸ì›ì„ ì´ˆê³¼í•˜ì—¬ ë“±ë¡í•  ìˆ˜ ì—†ìŠµë‹ˆë‹¤.';
		DBMS_OUTPUT.put_line(result);
	WHEN duplicate_period THEN
		result :='ê°™ì€ ì‹œê°„ì— ìˆ˜ê°•ì‹ ì²­í•œ ê³¼ëª©ì´ ìžˆìŠµë‹ˆë‹¤.';
		DBMS_OUTPUT.put_line(result);
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;
		DBMS_OUTPUT.put_line(result);
>>>>>>> d09a88ceb95bd0965745ffe6af820eecf754c402
END;
/