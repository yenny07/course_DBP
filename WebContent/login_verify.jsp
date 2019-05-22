<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@page import="java.sql.*"%>
	<%
	String userID=request.getParameter("userID");
	String userPassword=request.getParameter("userPassword");
	String session_id = request.getParameter("userID");


	// Oracle 연결
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "SOOK";
	String passwd = "2019";
	Class.forName(dbdriver);
	Connection myConn = DriverManager.getConnection(dburl, user, passwd);

	// Query 실행 
	// s_id = 1616020, s_pwd = 0 으로 로그인
	String mySQL = "select s_id from student where s_id='" + userID + " 'and s_pwd='" + userPassword + "'"; 
	Statement stmt = myConn.createStatement();
	ResultSet rs = stmt.executeQuery(mySQL);

	if(rs.next()) {
		// request.setAttribute("userID", session_id);
		response.sendRedirect("main.jsp?user="+session_id);
		}
	else{
		response.sendRedirect("login.jsp");
	}

	rs.close();
	stmt.close();
	myConn.close();
	%>