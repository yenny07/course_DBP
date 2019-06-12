<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<% 
    request.setCharacterEncoding("UTF-8");
%>

<html><head><title> 수강신청 입력 </title></head>
<body>
<%

	String session_id = (String)session.getAttribute("user");
	String c_id=request.getParameter("c_id");
	int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
	System.out.println(c_id);
	System.out.println(session_id);
%>	
<%	
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "sook";
	String passwd = "2019";
	Connection myConn = null;
	String result = null;
	
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
	
	if(session_id.length()==7){
		CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?)}",
				ResultSet.TYPE_SCROLL_SENSITIVE,
		        ResultSet.CONCUR_READ_ONLY);
		cstmt.setString(1, session_id);
		cstmt.setString(2, c_id);
		cstmt.setInt(3,c_id_no);
		cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);

		try {
			cstmt.execute();
			result = cstmt.getString(4);
			%>
			<script>
			alert("<%= result %>");
			location.href="insert.jsp?year_semester=201902";
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
	}else{
		CallableStatement cstmt = myConn.prepareCall("{call InsertCourse(?,?,?,?,?,?,?,?,?,?,?,?,?)}",
		ResultSet.TYPE_SCROLL_SENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
		String c_name = request.getParameter("c_name");
		int c_credit = Integer.parseInt(request.getParameter("c_credit"));
		String c_major = request.getParameter("c_major");
		String c_position1 = request.getParameter("c_position1");
		String c_position2 = request.getParameter("c_position2");
		String c_position = c_position1 + " " + c_position2;
		int c_max = Integer.parseInt(request.getParameter("c_max"));
		int c_day1 = Integer.parseInt(request.getParameter("c_day1"));
		int c_period1 = Integer.parseInt(request.getParameter("c_period1"));	
		int c_day2 = Integer.parseInt(request.getParameter("c_day2"));
		int c_period2 = Integer.parseInt(request.getParameter("c_period2"));		
		
		
		cstmt.setString(1, session_id);
		System.out.println(session_id);
		
		cstmt.setString(2, c_id);
		System.out.println(c_id);
		
		cstmt.setInt(3,c_id_no);
		System.out.println(c_id_no);
		
		cstmt.setString(4, c_name);
		System.out.println(c_name);
		
		cstmt.setString(5, c_position);
		System.out.println(c_position);
		
		cstmt.setInt(6, c_credit);
		System.out.println(c_credit);
		
		cstmt.setString(7, c_major);
		System.out.println(c_major);
		
		cstmt.setInt(8, c_max);
		System.out.println(c_max);
		
		cstmt.setInt(9, c_day1);
		System.out.println(c_day1);
		
		cstmt.setInt(10, c_period1);
		System.out.println(c_period1);
		
		cstmt.setInt(11, c_day2);
		System.out.println(c_day2);
		
		cstmt.setInt(12, c_period2);
		System.out.println(c_period2);
		
		cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);

		try {
			cstmt.execute();
			result = cstmt.getString(13);
			%>
			<script>
			alert("<%= result %>");
			location.href="insert_prof.jsp?year_semester=201902";
			</script>
			<%
			} catch(SQLException ex) {
				ex.printStackTrace();
			System.err.println("SQLException: " + ex.getMessage());
			}
			finally {
			if (cstmt != null)
			try { myConn.commit(); cstmt.close(); myConn.close(); }
			catch(SQLException ex) { }
		}
	}
	
	%>
</body>
</html>