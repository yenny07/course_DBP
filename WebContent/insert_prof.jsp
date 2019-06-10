<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<title>데이터베이스를 활용한 수강신청 시스템입니다</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
  	
	<link href = "vendor/fontawesome-free/css/all.min.css" rel = "stylesheet" type = "text/css">
	<link href = "https://fonts.googleapis.com/css?family=Nunito:200, 200i, 300, 300i, 400, 400i, 600, 600i, 700, 700i, 800, 800i, 900, 900i" rel = "stylesheet">
	<!-- Custom styles for this template-->
	<link href = "css/sb-admin-2.min.css" rel = "stylesheet">
</head>
<style type = "text/css">
	html {
		height : 100vh;
		overflow : hidden;
	}
	body {
		background : #f8f9fa;
	}
	#accordionSidebar {
		float : left;
	}
	.navbar-expand {
		width : 70%;
		float : left;
		text-align : right
	}
	#content-wrapper {
		width : 70%;
		height : 80vh;
		float : left;
		overflow : auto
	}
	#table-header {
		width : 100%;
		float : left;
		overflow : auto
	}	
	#year-dropdown {
		float : right;
	}
	#current-credit {
		float : left;
	}
	.form {
		margin : auto;
		width : 100%;
	}
	.table {
		background : white;
		margin : auto;
		width : 100%;
	}	
	th {
		text-align : center;
		word-break : keep-all;
	}
	td {
		text-align : center;
		margin : auto;
		word-break : keep-all;
		white-space : pre-line
	}
	#insert-button {
		margin : auto;
	}
	#input-box {
		margin-top : 5px;
		text-align : center;
		width : 100%;
		height : 38px;
	}
</style>
<body>
<%@ include file = "top.jsp" %>
<%
	//교수가 아니라면
	if (session_id.length() != 5) {
		response.sendRedirect("login.jsp");
		return;
	}
%>
	<!-- Content Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">
	<!-- Main Content -->
	<div id="content">
	<div class="container-fluid">
		<!-- Page Heading -->
		<div class="d-sm-flex align-items-center justify-content-between">  	
		<div id="table-header">
<%
	int year_semester = 0;
	int nYear, nSemester;
	
	if (request.getParameter("year_semester") == null) {
		year_semester = 201902; //year_semester라는 파라미터가 없을 경우 default값을 2019년 2학기로 한다.
	} 
	else {
		year_semester = Integer.parseInt(request.getParameter("year_semester"));
	}	
	nYear = year_semester / 100; //년도
	nSemester = year_semester % 100; //학기
	
	//각 학기별로 개설된 과목을 볼 수 있는 드롭다운 버튼
	if (year_semester == 201902) {
%>
		<select id = "year-dropdown" name = "year_semester" onchange = "location = this.value;">
			<option value = 'insert_prof.jsp?year_semester=201902' selected = "selected">2019년 2학기</option>	
			<option value = 'insert_prof.jsp?year_semester=201901'>2019년 1학기</option>
			<option value = 'insert_prof.jsp?year_semester=201802'>2018년 2학기</option>
			<option value = 'insert_prof.jsp?year_semester=201801'>2018년 1학기</option>
		</select>
<%
	}
	else if (year_semester == 201901) {
%>
		<select id = "year-dropdown" name = "year_semester" onchange = "location = this.value;">
			<option value = 'insert_prof.jsp?year_semester=201902'>2019년 2학기</option>	
			<option value = 'insert_prof.jsp?year_semester=201901' selected = "selected">2019년 1학기</option>
			<option value = 'insert_prof.jsp?year_semester=201802'>2018년 2학기</option>
			<option value = 'insert_prof.jsp?year_semester=201801'>2018년 1학기</option>
		</select>
<%
	}
	else if (year_semester == 201802) {
%>
		<select id = "year-dropdown" name = "year_semester" onchange = "location = this.value;">
			<option value = 'insert_prof.jsp?year_semester=201902'>2019년 2학기</option>	
			<option value = 'insert_prof.jsp?year_semester=201901'>2019년 1학기</option>
			<option value = 'insert_prof.jsp?year_semester=201802' selected = "selected">2018년 2학기</option>
			<option value = 'insert_prof.jsp?year_semester=201801'>2018년 1학기</option>
		</select>
<%
	}
	else if (year_semester == 201801) {
%>
		<select id = "year-dropdown" name = "year_semester" onchange = "location = this.value;">
			<option value = 'insert_prof.jsp?year_semester=201902'>2019년 2학기</option>	
			<option value = 'insert_prof.jsp?year_semester=201901'>2019년 1학기</option>
			<option value = 'insert_prof.jsp?year_semester=201802'>2018년 2학기</option>
			<option value = 'insert_prof.jsp?year_semester=201801' selected = "selected">2018년 1학기</option>
		</select>
<%
	}
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "sook";
	String passwd = "2019";
	Connection myConn = null;
	PreparedStatement pstmt = null;
	CallableStatement cstmt = null;
	ResultSet myResultSet = null;
	String sql;
	
	int credit;
	
	try {				
		Class.forName(dbdriver);
		myConn =  DriverManager.getConnection (dburl, user, passwd);
		
		//PreparedStatement 사용 부분 - 특정 연도, 학기에 해당하는 과목만 필터링하여 보여준다
		sql = "select * from COURSE where c_year = ? and c_semester = ? order by c_id";
		pstmt = myConn.prepareStatement(sql);
		pstmt.setInt(1, nYear);
		pstmt.setInt(2, nSemester);
		myResultSet = pstmt.executeQuery();
	} 
	catch (SQLException ex) {
		System.err.println("SQLException: " + ex.getMessage());
	}
%>
<%
		//CallableStatement + Function 사용 부분 - 현재 교수가 개설한 과목의 총 학점을 가져와서 보여준다
		String creditSQL = "{? = call get_prof_credit(?,?,?)}";
		cstmt = myConn.prepareCall(creditSQL);
		cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt.setString(2, session_id);
		cstmt.setInt(3, 2019);
		cstmt.setInt(4, 2);
		cstmt.execute();
		credit = cstmt.getInt(1);
		
%>
		<div id = "current-credit">
			<p>2019년 2학기에 현재 개설한 강의 : <%=credit%>학점</p>
		</div>
		<form method = "post" action = "insert_verify.jsp" >
		<table class = "table table-bordered" border>
			<tr>
				<td colspan = "4" >과목번호</td>
				<td colspan = "4">
					<input id = "c_id" type = "text" name = "c_id" size = "20" placeholder = "C0000">
				</td>
			</tr>
			<tr>
				<td colspan = "4">분반번호</td>
				<td colspan = "4">
					<input id = "c_id_no" type = "text" name = "c_id_no" size = "20" placeholder = "1이상의 숫자">
				</td>
			</tr>
			<tr>
				<td colspan = "4">과목이름</td>
				<td colspan = "4">
					<input id = "c_name" type = "text" name = "c_name" size = "20" placeholder = "25자 이하">
				</td>
			</tr>
			<tr>
				<td colspan = "4">전공</td>
				<td colspan = "4">
				<select id = "day-period" name = "c_major">
					<option value = "기초교양대학" selected = "selected">기초교양대학</option>
					<option value = "컴퓨터과학부" >컴퓨터과학부</option>
					<option value = "경영학부" >경영학부</option>
					<option value = "경제학부" >경제학부</option>
					<option value = "한국어문학부" >한국어문학부</option>
					<option value = "중어중문학부" >중어중문학부</option>
					<option value = "프랑스언어문화학과" >프랑스언어문화학과</option>
					<option value = "독일언어문화학과" >독일언어문화학과</option>
					<option value = "역사문화학과" >역사문화학과</option>
					<option value = "일본학과" >일본학과</option>
					<option value = "문헌정보학과" >문헌정보학과</option>
					<option value = "문화관광학전공" >문화관광학전공</option>
					<option value = "르꼬르동블루 외식경영전공" >르꼬르동블루 외식경영전공</option>
					<option value = "교육학부" >교육학부</option>
					<option value = "화학과" >화학과</option>
					<option value = "생명시스템학부" >생명시스템학부</option>
					<option value = "수학과" >수학과</option>
					<option value = "통계학과" >통계학과</option>
					<option value = "체육교육과" >체육교육과</option>
					<option value = "무용과" >무용과</option>
					<option value = "화공생명공학부" >화공생명공학부</option>
					<option value = "IT공학전공" >IT공학전공</option>
					<option value = "전자공학전공" >전자공학전공</option>
					<option value = "응용물리전공" >응용물리전공</option>
					<option value = "화학과" >소프트웨어융합전공</option>
					<option value = "기계시스템학부" >기계시스템학부</option>
					<option value = "기초공학부" >기초공학부</option>
					<option value = "가족자원경영학과" >가족자원경영학과</option>
					<option value = "아동복지학부" >아동복지학부</option>
					<option value = "의류학과" >의류학과</option>
					<option value = "식품영양학과" >식품영양학과</option>
					<option value = "정치외교학과" >정치외교학과</option>
					<option value = "행정학과" >행정학과</option>
					<option value = "홍보광고학과" >홍보광고학과</option>
					<option value = "소비자경제학과" >소비자경제학과</option>
					<option value = "사회심리학과" >사회심리학과</option>
					<option value = "법학부" >법학부</option>
					<option value = "피아노과" >피아노과</option>
					<option value = "관현악과" >관현악과</option>
					<option value = "성악과" >성악과</option>
					<option value = "작곡과" >작곡과</option>
					<option value = "시각영상디자인과" >시각영상디자인과</option>
					<option value = "산업디자인과" >산업디자인과</option>
					<option value = "환경디자인과" >환경디자인과</option>
					<option value = "공예과" >공예과</option>
					<option value = "회화과" >회화과</option>
					<option value = "글로벌협력전공" >글로벌협력전공</option>
					<option value = "앙트프러너십전공" >앙트프러너십전공</option>
					<option value = "영어영문학전공" >영어영문학전공</option>
					<option value = "테슬전공" >테슬전공</option>
					<option value = "미디어학부" >미디어학부</option>
				</select>
				</td>
			</tr>
			<tr>
				<td colspan = "4">학점</td>
				<td colspan = "4">
					<input id = "c_credit" type = "text" name = "c_credit" size = "20" placeholder = "1~3 사이의 숫자">
				</td>
			</tr>
			<tr>
				<td colspan = "4">최대인원</td>
				<td colspan = "4">
					<input id = "c_max" type = "text" name = "c_max" size = "20" placeholder = "10이상 200이하의 숫자">
				</td>
			</tr>
			<tr>
				<td>첫번째 날</td>
				<td>
				<select id = "day-period" name = "c_day1">
					<option value = "1" selected = "selected">월</option>
					<option value = "2">화</option>
					<option value = "3">수</option>
					<option value = "4">목</option>
					<option value = "5">금</option>
				</select>
				</td>
				<td>교시</td>
				<td>
				<select id = "day-period" name = "c_period1">
					<option value = "1" selected = "selected">1</option>
					<option value = "2">2</option>
					<option value = "3">3</option>
					<option value = "4">4</option>
					<option value = "5">5</option>
					<option value = "6">6</option>
					<option value = "7">7</option>
				</select>
				</td>
				<td>두번째 날</td>
				<td>
				<select id = "day-period" name = "c_day2">
					<option value = "1">월</option>
					<option value = "2">화</option>
					<option value = "3" selected = "selected">수</option>
					<option value = "4">목</option>
					<option value = "5">금</option>
				</select>
				</td>
				<td>교시</td>
				<td>
				<select id = "day-period" name = "c_period2">
					<option value = "1" selected = "selected">1</option>
					<option value = "2">2</option>
					<option value = "3">3</option>
					<option value = "4">4</option>
					<option value = "5">5</option>
					<option value = "6">6</option>
					<option value = "7">7</option>
				</select>
				</td>
			</tr>
		</table>
		<div id = "input-box">
			<INPUT class = "btn btn-primary" id = "insert-button" TYPE = "SUBMIT" NAME = "Submit" VALUE = "작성완료">
			<INPUT class = "btn btn-primary" id = "insert-button" TYPE = "RESET" VALUE = "초기화">
		</div>
		</form>
		<p>개설된 강의</p>
		</div>          
		</div>
		<div class = "d-sm-flex align-items-center justify-content-between mb-4">
		<table class = "table table-bordered" align = "center" border>
			<tr>
				<th>과목번호</th>
				<th>분반</th>
				<th>과목명</th>
				<th>교수</th>
				<th>시간</th>
				<th>학점</th>
				<th>현재 수강인원</th>
				<th>최대 수강인원</th>
			</tr>
<%
	Statement stmt;
	ResultSet rs;
	String sql2;

	//Prepared Statement에서 가져온 과목 정보들을 보여주기 위한 변수들
	String c_id, c_name, p_name;
	String c_time = "";
	int c_number, p_id, c_day1, c_day2, c_period1, c_period2, c_max, c_current, c_credit;
	
	if (myResultSet != null) {
		while (myResultSet.next()) {	
			c_id = myResultSet.getString("c_id");
			c_number = myResultSet.getInt("c_number");
			c_name = myResultSet.getString("c_name");
			p_id = myResultSet.getInt("p_id");
			c_day1 = myResultSet.getInt("c_day1");
			c_day2 = myResultSet.getInt("c_day2");
			c_period1 = myResultSet.getInt("c_period1");
			c_period2 = myResultSet.getInt("c_period2");
			c_max = myResultSet.getInt("c_max");
			c_current = myResultSet.getInt("c_current");
			switch (c_day1) {
				case 1 :
					c_time = "월";
					break;
				case 2 :
					c_time = "화";
					break;
				case 3 :
					c_time = "수";
					break;
				case 4 :
					c_time = "목";
					break;
				case 5 :
					c_time = "금";
					break;
				default :
					break;
			}
			c_time = c_time + " " + c_period1 + "교시";
			switch (c_day2) {
				case 1 :
					c_time = c_time +"\n월";
					break;
				case 2 :
					c_time = c_time +"\n화";
					break;
				case 3 :
					c_time = c_time +"\n수";
					break;
				case 4 :
					c_time = c_time +"\n목";
					break;
				case 5 :
					c_time = c_time +"\n금";
					break;
				default :
					break;
			}
			c_time = c_time + " " + c_period2 + "교시";
			c_credit= myResultSet.getInt("c_credit");
			
			sql2 = "select p_name from professor where p_id = '" + p_id + "'";
			stmt = myConn.createStatement();
			rs = stmt.executeQuery(sql2);
			rs.next();
			p_name = rs.getString("P_NAME");	
%>
			<tr>
				<td align = "center"><%=c_id%></td>
				<td align = "center"><%=c_number%></td> 
				<td align = "center"><%=c_name%></td>
				<td align = "center"><%=p_name%></td>
				<td align = "center"><%=c_time%></td>
				<td align = "center"><%=c_credit%></td>
				<td align = "center"><%=c_current%></td>
				<td align = "center"><%=c_max%></td>
			</tr>
<%
		}
	}
%>
		</table>	
		</div>
	</div>
	<!-- /.container-fluid -->
	</div>
	<!-- End of Main Content -->
	</div>
	<!-- End of Content Wrapper -->
</body>
</html>