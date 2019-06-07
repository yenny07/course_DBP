/* update.jsp */
CREATE OR REPLACE PROCEDURE show_prof_info(
id IN VARCHAR2,
pwd OUT VARCHAR2,
name OUT VARCHAR2,
major OUT VARCHAR2,
credit OUT NUMBER
)
IS

BEGIN

select p_pwd, p_name, p_major, p_credit
into pwd, name, major, credit
from professor
where p_id = id;

END;
/