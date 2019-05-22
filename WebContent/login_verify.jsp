<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
String userID=request.getParameter("userID");
String userPassword=request.getParameter("userPassword");
...
Class.forName(dbdriver);
myConn=DriverManager.getConnection(dburl, user, passwd);
...
mySQL="select s_id from student where s_id='" + userID + " 'and s_pwd='" + userPassword + "'";
...
stmt.close();
myConn.close();
%>