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

<<<<<<< HEAD
	select c_current, c_credit
	into coursecurrent, courseCREDIT
	from course
	where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;
=======
select c_current, c_credit
into coursecurrent, courseCREDIT
from course
where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;
>>>>>>> 0332e8f3d269e7765b94a8fa18335256a95044f3

	UPDATE COURSE
	SET c_current = coursecurrent -1
	where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;

	DELETE FROM ENROLL
	where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;

	DELETE FROM COURSE
	where c_id = courseID AND c_number = courseIDNO AND c_year = nYEAR AND c_semester = nSEMESTER;
 
	COMMIT;
 
END;
/

 show error;