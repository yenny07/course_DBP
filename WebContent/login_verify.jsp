<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@page import="java.sql.*"%>
	<%
	String userID=request.getParameter("userID");
	String userPassword=request.getParameter("userPassword");
	String session_id = request.getParameter("userID");
	
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "sook";
	String passwd = "2019";
	
	try{
		Class.forName(dbdriver);
		Connection myConn = DriverManager.getConnection(dburl, user, passwd);
		
		String mySQL = "select s_id, s_name from student where s_id='" + userID + "' and s_pwd='" + userPassword + "'"; 
		Statement stmt = myConn.createStatement();
		ResultSet rs = stmt.executeQuery(mySQL);
		
		System.out.println(mySQL);
		boolean result = rs.next();
		System.out.println(result);
		
		if(result) {
			session.setAttribute("user", session_id);
			response.sendRedirect("main.jsp");
			}
		else{%>
		    <script>
		    	alert("로그인 실패.");
		    	location.href="login.jsp";
		    </script>
		    <%
		}
		rs.close();
		stmt.close();
		myConn.close();
		
	}catch (ClassNotFoundException e){
		e.printStackTrace();
		System.out.println("jdbc driver 로딩 실패");
	}catch (SQLException e){
		e.printStackTrace();
		System.out.println("오라클 연결 실패");
	}
	
	%>