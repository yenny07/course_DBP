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
		String mySQL = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		if(userID.length() == 7){
			mySQL = "select s_id, s_name from student where s_id = ? and s_pwd = ?"; 		
		}else{
			mySQL = "select p_id, p_name from professor where p_id = ? and p_pwd= ?"; 
		}
			pstmt = myConn.prepareStatement(mySQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			rs = pstmt.executeQuery();
		
			System.out.println(mySQL);
			result = rs.next();
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