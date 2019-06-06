/* update.jsp */
CREATE OR REPLACE PROCEDURE show_stu_info(
id IN VARCHAR2,
pwd OUT VARCHAR2,
name OUT VARCHAR2,
grade OUT NUMBER,
major OUT VARCHAR2,
credit OUT NUMBER,
isLeaved_out OUT NUMBER
)
IS

BEGIN

select s_pwd, s_name, s_grade, s_major, s_credit, isLeaved
into pwd, name, grade, major, credit, isLeaved_out
from student
where s_id = id;

END;
/