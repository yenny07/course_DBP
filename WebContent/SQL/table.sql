CREATE TABLE STUDENT(
s_id VARCHAR2(7), --�й� �� �α��� ���̵�
s_pwd VARCHAR2(15), --�α��� �н�����
s_name VARCHAR2(20),
s_grade NUMBER, --�г�
s_major VARCHAR2(30),
isLeaved NUMBER(3), --���� ���� (0: ����, 1: ����)
CONSTRAINT student_pk PRIMARY KEY (s_id)
);

CREATE TABLE PROFESSOR(
p_id varchar2(5),
p_pwd VARCHAR2(15), -- professor ��й�ȣ
p_name VARCHAR2(20),
p_major VARCHAR2(30),
CONSTRAINT professor_pk PRIMARY KEY (p_id)
);

CREATE TABLE COURSE(
c_id VARCHAR2(20),
c_name VARCHAR2(50),
c_position VARCHAR2(50),
c_year NUMBER, --�⵵
c_semester NUMBER, -- �б�
p_id VARCHAR2(5),  --����id
c_credit NUMBER, --����
c_number NUMBER, --�йݹ�ȣ
c_major VARCHAR2(50), --����
c_day1 NUMBER, --����1 (1:��, 2:ȭ, 3:��, 4:��, 5:��)
c_day2 NUMBER, --����2
c_period1 NUMBER, --����1
c_period2 NUMBER, --����2
c_max NUMBER, --�ִ��ο�
c_current NUMBER, --���� �����ο�
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
