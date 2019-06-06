<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<html><head><title> 수강신청 입력 </title></head>
<body>
<%

	String s_id = (String)session.getAttribute("user");
	String c_id=request.getParameter("c_id");
	int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
	System.out.println(c_id);
	System.out.println(s_id);
%>	
<%	
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "sook";
	String passwd = "2019";
	Connection myConn = null;
	String result = null;
	ResultSet rs = null;
	CallableStatement cstmt = null;

	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
	}catch (ClassNotFoundException e){
		e.printStackTrace();
		System.out.println("jdbc driver 로딩 실패");
	}catch (SQLException e){
		e.printStackTrace();
		System.out.println("오라클 연결 실패");
	}
	
	cstmt = myConn.prepareCall("{call deleteEnroll(?,?,?)}",
	         ResultSet.TYPE_SCROLL_SENSITIVE,
	           ResultSet.CONCUR_READ_ONLY);
	   cstmt.setString(1, s_id);
	   cstmt.setString(2, c_id);
	   cstmt.setInt(3,c_id_no);
	
	   try {
		      cstmt.execute();
		      result = "수강신청이 취소되었습니다.";
		      //result = cstmt.getString(6);
		      %>
		      <script>
		      alert("<%= result %>");
		      location.href="delete.jsp";
		      </script>
		      <%
		      } catch(SQLException ex) {
		      System.err.println("SQLException: " + ex.getMessage());
		      }
		      finally {
		      if (cstmt != null)
		      try { myConn.commit(); cstmt.close(); myConn.close(); }
		      catch(SQLException ex) { }
		      }
		
	//pstmt.close();
	//myConn.close();
	%>
</body>
</html>