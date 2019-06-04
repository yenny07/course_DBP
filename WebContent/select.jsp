<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.ArrayList"  %>
<html>
<head>
<title>수강신청 입력</title>
<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<meta name="description" content="">
  	<meta name="author" content="">
  
	
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  	<!-- Custom styles for this template-->
  	<link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>
<style type="text/css">
	html{
		height:100vh;
		overflow:hidden;
	}
	body{
		background:#f8f9fa;
	}
	#accordionSidebar{
		width:20%;
		float:left;
	}

	.navbar-expand{
		width:75%;
		float:left;
		text-align:right
	}
	#content-wrapper{
		width:75%;
		height:80vh;
		float:left;
		overflow:auto
	}
	.select{
		float:right;
	}
	
	#current-credit{
		margin-left:20px;
		margin-right:5px;
		float:left;
	}
	
	.form{
		margin : auto;
		width:100%;
	}
	
	.table{
		background: white;
		margin : auto;
		width:100%;
	}
	
	td{
		word-break: keep-all;
		white-space:pre-line
	}
</style>

<body>
<%@include file="top.jsp"%>

      <%
      int year_semester = 0;
  	if( request.getParameter("year_semester") == null){
  		year_semester = 201902;
  	}else{
  		year_semester = Integer.parseInt(request.getParameter("year_semester"));
  	}
  	System.out.println(year_semester);
  	if (session_id != null){
  		System.out.println(session_id);
  	}else{
  			System.out.println(session_id);
  			response.sendRedirect("login.jsp");
  	}
  	
  	int nYear = year_semester / 100;
  	int nSemester = year_semester % 100;
  	
  	if(year_semester == 201902){
  		%>
  		<select name="year_semester" onchange="location = this.value;">
  			<option value='insert.jsp?year_semester=201902' selected="selected">2019년 2학기</option>	
  			<option value='insert.jsp?year_semester=201901' >2019년 1학기</option>
      		<option value='insert.jsp?year_semester=201802'>2018년 2학기</option>
      		<option value='insert.jsp?year_semester=201801'>2018년 1학기</option>
  		</select>
  		<%
  	}else if(year_semester == 201901){
  		%>
  		<select name="year_semester" onchange="location = this.value;">
  			<option value='insert.jsp?year_semester=201902'>2019년 2학기</option>	
  			<option value='insert.jsp?year_semester=201901' selected="selected" >2019년 1학기</option>
      		<option value='insert.jsp?year_semester=201802'>2018년 2학기</option>
      		<option value='insert.jsp?year_semester=201801'>2018년 1학기</option>
  		</select>
  		<%
  	}else if(year_semester == 201802){
  		%>
  		<select name="year_semester" onchange="location = this.value;">
  			<option value='insert.jsp?year_semester=201902'>2019년 2학기</option>	
  			<option value='insert.jsp?year_semester=201901' >2019년 1학기</option>
      		<option value='insert.jsp?year_semester=201802' selected="selected">2018년 2학기</option>
      		<option value='insert.jsp?year_semester=201801'>2018년 1학기</option>
  		</select>
  		<%
  	}else if(year_semester == 201801){
  		%>
  		<select name="year_semester" onchange="location = this.value;">
  			<option value='insert.jsp?year_semester=201902'>2019년 2학기</option>	
  			<option value='insert.jsp?year_semester=201901' >2019년 1학기</option>
      		<option value='insert.jsp?year_semester=201802'>2018년 2학기</option>
      		<option value='insert.jsp?year_semester=201801' selected="selected">2018년 1학기</option>
  		</select>
  		<%
  	} %>        
<%

String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "SOOK";
String passwd = "2019";

ArrayList<String> courseID = new ArrayList<>();
ArrayList<String> courseName = new ArrayList<>();
ArrayList<String> profID = new ArrayList<>();
ArrayList<Integer> courseCredit = new ArrayList<>();
ArrayList<Integer> courseNumber = new ArrayList<>();
ArrayList<String> courseMajor = new ArrayList<>();
ArrayList<Integer> courseDay1 = new ArrayList<>();
ArrayList<Integer> coursePeriod = new ArrayList<>();
int day;

String period;

PreparedStatement pstmt;

try {
   Class.forName(dbdriver);
   Connection myConn = DriverManager.getConnection(dburl, user, passwd);
   pstmt = myConn.prepareStatement("SELECT c_id, c_name, p_id, c_credit, c_number, c_major, c_period, c_day1 FROM course WHERE c_year = ? AND c_semester = ? AND (c_id, c_number) IN (SELECT c_id, c_number FROM enroll WHERE s_id = ?)");
   pstmt.setInt(1, nYear);
   pstmt.setInt(2, nSemester);
   pstmt.setString(3, session_id);
   ResultSet rs = pstmt.executeQuery();
   
   while (rs.next()) {
      courseID.add(rs.getString("c_id"));
      courseName.add(rs.getString("c_name"));
      profID.add(rs.getString("p_id"));
      courseCredit.add(rs.getInt("c_credit"));
      courseNumber.add(rs.getInt("c_number"));
      courseMajor.add(rs.getString("c_major"));
      coursePeriod.add(rs.getInt("c_period"));
      courseDay1.add(rs.getInt("c_day1"));
      courseDay1.add(rs.getInt("c_day2"));
   }
   

	String std_SQL = "select s_credit from student where s_id = '" + session_id + "'";
	Statement std_stmt = myConn.createStatement();
	ResultSet std_rs = std_stmt.executeQuery(std_SQL);
	std_rs.next();
	int s_credit = std_rs.getInt("s_credit");
	%>
<div id="current-credit">
	<p>현재 신청한 학점 : <%= s_credit %></p>
</div>
<%
   
	
	
	rs.close();
   pstmt.close();
   myConn.close();
   
}catch (ClassNotFoundException e){
   e.printStackTrace();
   System.out.println("jdbc driver 로딩 실패");
}catch (SQLException e){
   e.printStackTrace();
   System.out.println("오라클 연결 실패");
}
%>



	<!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">


   <table class="table table-bordered" width="75%" align="center" border>
      <tr>
         <th>과목번호</th>
         <th>분반</th>
         <th>과목명</th>
         <th>교수</th>
         <th>시간</th>
         <th>학점</th>
      </tr>
<%
      while (!courseID.isEmpty()) {
         out.println("<tr>");
         
         out.println("<td align = \"center\" >");
         out.println(courseID.remove(0));
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         out.println(courseNumber.remove(0));
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         out.println(courseName.remove(0));
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         out.println(profID.remove(0));
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         period = coursePeriod.remove(0).toString();
         day = courseDay1.remove(0);
         if (day == 1) {
            out.println("월 " + period + "교시");
            out.println("<br>");
            out.println("수 " + period + "교시");
         }
         else if (day == 2) {
            out.println("화 " + period + "교시");
            out.println("<br>");
            out.println("목 " + period + "교시");
         }
         else if (day == 3) {
            out.println("금 " + period + "교시");
         }
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         out.println(courseCredit.remove(0));
         out.println("</td>");
         
         out.println("</tr>");
      }
      out.flush();
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