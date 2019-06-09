CREATE OR REPLACE FUNCTION Date2EnrollSemester(dDate IN DATE)
	RETURN NUMBER
IS
	month NUMBER := TO_NUMBER(TO_CHAR(dDate, 'MM'));
	semester NUMBER := 0;
BEGIN
	IF month <= 2 THEN
		semester := 1;
	ELSIF month <=8 THEN
		semester := 2;
	ELSE
		semester := 1;
	END IF;
	RETURN semester;
END;
/

CREATE OR REPLACE FUNCTION Date2EnrollYear(dDate IN DATE)
	RETURN NUMBER
IS
	year NUMBER := 0;
	nSEMESTER NUMBER;
BEGIN
	year := TO_NUMBER(TO_CHAR(dDate, 'YYYY'));
	nSEMESTER := Date2EnrollSemester(dDate);
	IF (nSEMESTER = 1) THEN
		year := year + 1;
	END IF;
	
	RETURN year;
END;
/
