CREATE TABLE STUDENT(
s_id VARCHAR2(7), --학번 겸 로그인 아이디
s_pwd VARCHAR2(15), --로그인 패스워드
s_name VARCHAR2(20),
s_grade NUMBER, --학년
s_major VARCHAR2(30),
isLeaved NUMBER(3), --휴학 유무 (0: 재학, 1: 휴학)
CONSTRAINT student_pk PRIMARY KEY (s_id)
);

CREATE TABLE PROFESSOR(
p_id varchar2(5),
p_pwd VARCHAR2(15), -- professor 비밀번호
p_name VARCHAR2(20),
p_major VARCHAR2(30),
CONSTRAINT professor_pk PRIMARY KEY (p_id)
);

CREATE TABLE COURSE(
c_id VARCHAR2(20),
c_name VARCHAR2(50),
c_position VARCHAR2(50),
c_year NUMBER, --년도
c_semester NUMBER, -- 학기
p_id VARCHAR2(5),  --교수id
c_credit NUMBER, --학점
c_number NUMBER, --분반번호
c_major VARCHAR2(50), --전공
c_day1 NUMBER, --요일1 (1:월, 2:화, 3:수, 4:목, 5:금)
c_day2 NUMBER, --요일2
c_period1 NUMBER, --교시1
c_period2 NUMBER, --교시2
c_max NUMBER, --최대인원
c_current NUMBER, --현재 수강인원
CONSTRAINT course_pk PRIMARY KEY (c_id, c_number, c_year, c_semester),
CONSTRAINT course_p_id FOREIGN KEY (p_id) REFERENCES professor(p_id)
);

CREATE TABLE ENROLL(
s_id VARCHAR2(7) ,
c_id VARCHAR2(20) ,
c_number NUMBER,
c_year NUMBER,
c_semester NUMBER,
CONSTRAINT enroll_pk PRIMARY KEY (s_id, c_id, c_number, c_year, c_semester),
CONSTRAINT enroll_s_fk FOREIGN KEY (s_id) REFERENCES student(s_id),
CONSTRAINT enroll_c_fk FOREIGN KEY (c_id, c_number, c_year, c_semester) REFERENCES course(c_id, c_number, c_year, c_semester)
);
