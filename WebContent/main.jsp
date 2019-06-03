<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head> <meta charset="EUC-KR">
	<title>데이터베이스를 활용한 수강신청 시스템입니다.</title>
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
<style>
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
		height:85vh;
		float:left;
		overflow:auto
	}
	#update_post{
		margin : auto;
		width:100%;
	}
	
	#update_table{
		background: white;
		margin : auto;
		width:80%;
	}
	
	#profile{
		margin:0 auto;
	}

</style>
<body>
	<%@include file="top.jsp"%>
<%
String dbdriver = "oracle.jdbc.driver.OracleDriver"; //JDBC 드라이버 로딩
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl"; //url
String user = "sook"; //oracle login id
String passwd = "2019"; //pw

Class.forName(dbdriver); // DriverManager.registerDriver(dbdriver);
Connection myConn = null;
Statement stmt = null;
String mySQL = null;

// show_stu_info 변수
String s_pwd = null; 
String s_name = null; 
int s_grade = 0; 
String s_major = null; 
int s_credit = 0;
%>

	<!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

            <% if (session_id != null) {
            	try{
                    // oracle 연결
                     myConn = DriverManager.getConnection(dburl, user, passwd);
                    
                     /* show_stu_info 호출*/
                   String sql = "{call show_stu_info(?,?,?,?,?,?)}";
                   CallableStatement cstmt = myConn.prepareCall(sql);
                   cstmt.setString(1, session_id); // s_id
                   cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); // s_pwd
                   cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //s_name
                   cstmt.registerOutParameter(4, java.sql.Types.INTEGER); // s_grade
                   cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); // s_major
                   cstmt.registerOutParameter(6, java.sql.Types.INTEGER); // s_credit
                   cstmt.execute(); // 프로시저 실행

                   s_pwd = cstmt.getString(2);
                    s_name = cstmt.getString(3);
                   s_grade = cstmt.getInt(4);
                   s_major = cstmt.getString(5);
                    s_credit = cstmt.getInt(6);
                      
                   System.out.println(session_id + s_pwd + s_name + s_grade + s_major + s_credit);
                  }catch(SQLException e){
                      out.println(e);
                      e.printStackTrace();
                  }
            
            
            %>
                    
        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
          		<table class="table table-bordered" align="center" id="update_table">
   <tr>
   	 <td rowspan="5" style="text-align:center"><img src="img/character_new03.gif" alt="profile" id="profile"></td>
     <td id="update_td">학번</td>
     <td><%=session_id%></td>
   </tr>
   <tr>
     <td id = "student_name">이름</td>
     <td ><%=s_name%></td>
   </tr>
   <tr>
     <td id = "student_grade">학년</td>
     <td ><%=s_grade%></td>
   </tr>
   <tr>
     <td id = "student_major">전공</td>
     <td ><%=s_major%></td>
   </tr>
   <tr>
     <td id = "student_credit">수강학점</td>
     <td ><%=s_credit%></td>
   </tr>
   <tr>  
     <td id="update_td">비밀번호</td>
     <td colspan="2"><input id="update_pw_in" type="password" name="password" size="10" value="<%=s_pwd%>"></td>
   </tr>
   <tr>
     <td id="update_td_confirm">비밀번호 확인</td>
     <td colspan="2"><input id="update_pw_in_confirm" type="password" name="passwordConfirm" size="10" ></td>
   </tr>
    </table>
          
				
		  </div>
		  
		  
		<% myConn.close(); } else {%>

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
				
		  </div>
		<% } %>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

</body>

</html>