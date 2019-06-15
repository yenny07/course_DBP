CREATE OR REPLACE PROCEDURE deleteCourse(profID IN VARCHAR2, courseID IN VARCHAR2,
               courseIDNO IN NUMBER)
IS

   courseMAX NUMBER;
   coursecurrent NUMBER;
   nYEAR NUMBER;
   nSEMESTER NUMBER;
   courseCREDIT NUMBER;
   
BEGIN
   
   nYEAR := Date2EnrollYear(SYSDATE);
   nSEMESTER := Date2EnrollSemester(SYSDATE);

	select c_current, c_credit
	into coursecurrent, courseCREDIT
	from course
	where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;


	UPDATE COURSE
	SET c_current = coursecurrent -1
	where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;
	
	commit;

	DELETE FROM ENROLL
	where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;
	
	commit;

	DELETE FROM COURSE
	where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;
 
	COMMIT;
 	
END;
/