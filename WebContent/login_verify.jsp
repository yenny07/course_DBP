<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
//String userID=request.getParameter("userID");
//String userPassword=request.getParameter("userPassword");

//Connection myConn = null;
//Statement stmt = null;

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "sook";
	String password = "2019";
	try{
		Class.forName(driver);
		out.println("jdbc driver 로딩 성공");
		DriverManager.getConnection(url,user,password);
		out.println("오라클 연결 성공");
	}catch (ClassNotFoundException e){
		e.printStackTrace();
		System.out.println("jdbc driver 로딩 실패");
	}catch (SQLException e){
		System.out.println("오라클 연결 실패");
	}



%>