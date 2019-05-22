<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
//test/ashdfskhdfkshdfjsbvjabjdfvsdfasdfasdgsdagd

	String userID=request.getParameter("userID");
	String userPassword=request.getParameter("userPassword");

	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "sook";
	String password = "2019";
	System.out.println(userID);
	System.out.println(userPassword);
	
	try{
		Class.forName(driver);
		myConn = DriverManager.getConnection(url,user,password);
		stmt = myConn.createStatement();
		
		mySQL="select s_id from student where s_id='" + userID + " 'and s_pwd='" + userPassword + "'";
		
		ResultSet  myResultSet = stmt.executeQuery(mySQL);
		
		if(myResultSet.next() != false){
		
			String name = myResultSet.getString("s_name");
			session.setAttribute("userName", name);
			session.setAttribute("userID", userID);  
			response.sendRedirect("main.jsp");
		}
	    else { %>
	    <script>
	    	alert("로그인 실패.");
	    	location.href="login.jsp";
	    </script>
	    <%
	    }
		
		myConn.close();
		stmt.close();
		
	}catch (ClassNotFoundException e){
		e.printStackTrace();
		System.out.println("jdbc driver 로딩 실패");
	}catch (SQLException e){
		System.out.println("오라클 연결 실패");
	}

%>