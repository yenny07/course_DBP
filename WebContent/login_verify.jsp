<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
	String userID=request.getParameter("userID");
	String userPassword=request.getParameter("userPassword");

	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "sook";
	String password = "2019";

		
		/*
		Class.forName(driver);
		out.println("jdbc driver 로딩 성공");
		myConn = DriverManager.getConnection(url,user,password);
		out.println("오라클 연결 성공");
		stmt = myConn.createStatement();
		*/
		
		mySQL="select s_id from student where s_id='" + userID + " 'and s_pwd='" + userPassword + "'";
		
		
		
		myConn.close();
		stmt.close();
		
		String a = resultSet.getString("userID");
		//int pw = resultSet.getInt("userPassword");

		 System.out.println(""+a);
	

%>