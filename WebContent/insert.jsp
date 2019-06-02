<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"  %>
<html><head><title>수강신청 입력</title></head>
<body>
<%@ include file="top.jsp" %>
<%   if (session_id==null) response.sendRedirect("login.jsp");  %>

<table width="75%" align="center" border>
<br>
<tr>
         <th>과목번호</th>
         <th>분반</th>
         <th>과목명</th>
         <th>교수</th>
         <th>시간</th>
         <th>학점</th>
         <th>현재 수강인원</th>
         <th>최대 수강인원</th>
         <th>수강신청</th>
      </tr>
<%
	Connection myConn = null;     
Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet myResultSet = null;   String mySQL = "";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user="sook";     String passwd="2019";
     String dbdriver = "oracle.jdbc.driver.OracleDriver";    
     String sql = "select * from COURSE where c_id = ?";
     //session_id = session.getId();
	session_id=(String)session.getAttribute("user");
	System.out.println("sessionid:"+session_id);
     
     String id = request.getParameter("userID");
     String pwd = request.getParameter("userPassword");
	int cmax = 30;
	try {
		
	///	int result = stmt.executeQuery(sql);
		
		Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();	
		pstmt = myConn.prepareStatement(sql);
		pstmt.setString(1,"C1234");
//		pstmt.setString(2,pwd);
		
		
    } catch(SQLException ex) {
	     System.err.println("SQLException: " + ex.getMessage());
    }

//mySQL = "select c_id,c_id_no,c_name,c_unit from course where c_id not in (select c_id from enroll where s_id='" + session_id + "')";
	mySQL="select * from course";
myResultSet = pstmt.executeQuery();
System.out.println("myreslutset"+myResultSet);

if (myResultSet != null) {
	while (myResultSet.next()) {
		
		
		String c_id = myResultSet.getString("c_id");//과목번호
		String c_name = myResultSet.getString("c_name");//과목명
	//	System.out.println("c_id:"+c_id);
	//	System.out.println("c_name"+c_name);

		
		int c_credit= myResultSet.getInt("c_credit");//분반			
		int c_number = myResultSet.getInt("c_number");//분반			
%>
<tr>
  <td align="center"><%= c_id %></td> <td align="center"><%= c_number %></td> 
  <td align="center"><%= c_name %></td><td align="center"><%= c_credit %></td>
  <td align="center"><a href="insert_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_number %>">신청</a></td>
</tr>
<%
		}
	}
	//stmt.close(); 
	//pstmt.close();
	//myConn.close();
%>
</table></body></html>