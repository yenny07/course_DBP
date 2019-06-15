<%@ page contentType = "text/html; charset=EUC-KR" %>
<%@ page import = "java.sql.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<%
	//학생모드에서는 수강신청한 학생의 학번을 login_verify.jsp로부터, 수강신청한 과목의 과목번호, 과목분반 데이터를 insert.jsp로부터 받아온다
	//교수모드에서는 개설신청한 교수의 교번을 login_verify.jsp로부터, 개설신청한 과목의 과목번호, 과목분반 데이터를 insert_prof.jsp로부터 받아온다
	String session_id = (String) session.getAttribute("user");
	String c_id = request.getParameter("c_id");
	int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
	
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "sook";
	String passwd = "2019";
	Connection myConn = null;
	CallableStatement cstmt = null;
	String result = null;
	
	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
	}
	catch (ClassNotFoundException e) {
		e.printStackTrace();
		System.out.println("jdbc driver 로딩 실패");
	}
	catch (SQLException e) {
		e.printStackTrace();
		System.out.println("오라클 연결 실패");
	}
	//학생인 경우
	if (session_id.length() == 7) {
		//CallaleStatement + Procedure 사용 부분 - 선택한 과목을 수강신청 목록에 추가한다
		cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?)}", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		cstmt.setString(1, session_id);
		cstmt.setString(2, c_id);
		cstmt.setInt(3, c_id_no);
		cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
		try {
			cstmt.execute();
			result = cstmt.getString(4);
%>
	<script>
		alert("<%=result%>");
		location.href="insert.jsp?year_semester=201902";
	</script>
<%
		} 
		catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}
		finally {
			if (cstmt != null) {
				try { 
					myConn.commit(); 
					cstmt.close(); 
					myConn.close(); 
				}
				catch (SQLException ex) { }
			}
		}
<<<<<<< HEAD
	}
	//교수인 경우
	else {
		//교수가 개설한 과목 정보를 insert_prof.jsp로부터 받아오는 데에 사용되는 변수
		String c_name=null; int c_credit = -1; String c_major = null; int c_max = -1;
		int c_day1 = -1; int c_period1 = -1; int c_day2 = -1; int c_period2 = -1;
		try{
			c_name = request.getParameter("c_name");
			c_credit = Integer.parseInt(request.getParameter("c_credit"));
			c_major = request.getParameter("c_major");
			c_max = Integer.parseInt(request.getParameter("c_max"));
			c_day1 = Integer.parseInt(request.getParameter("c_day1"));
			c_period1 = Integer.parseInt(request.getParameter("c_period1"));	
			c_day2 = Integer.parseInt(request.getParameter("c_day2"));
			c_period2 = Integer.parseInt(request.getParameter("c_period2"));
		}catch (NumberFormatException nfe){ 
			System.out.println("예외처리");
%>
			<script>
				alert("잘못된 입력입니다.");
			</script>
<%
			response.sendRedirect("insert_prof.jsp?year_semester=201902");
			return;
		}
		
=======
	}else{
		CallableStatement cstmt = myConn.prepareCall("{call InsertCourse(?,?,?,?,?,?,?,?,?,?,?,?,?)}",
		ResultSet.TYPE_SCROLL_SENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
		try{
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
		} catch (NumberFormatException e){ //input값이 잘못되었을 경우 예외 처리
			%>
			<script>
			alert("잘못된 입력입니다.");
			location.href="insert_prof.jsp?year_semester=201902";
			</script>
			<%
		}
>>>>>>> 0332e8f3d269e7765b94a8fa18335256a95044f3
		try {
			//CallaleStatement + Procedure 사용 부분 - 입력한 정보를 토대로 새로운 과목을 개설한다
			cstmt = myConn.prepareCall("{call InsertCourse(?,?,?,?,?,?,?,?,?,?,?,?)}", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);		
			cstmt.setString(1, session_id);		
			cstmt.setString(2, c_id);
			cstmt.setInt(3,c_id_no);
			cstmt.setString(4, c_name);		
			cstmt.setInt(5, c_credit);		
			cstmt.setString(6, c_major);		
			cstmt.setInt(7, c_max);		
			cstmt.setInt(8, c_day1);		
			cstmt.setInt(9, c_period1);	
			cstmt.setInt(10, c_day2);
			cstmt.setInt(11, c_period2);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.execute();
<<<<<<< HEAD
			result = cstmt.getString(12);
%>
=======
			result = cstmt.getString(13);
			%>
>>>>>>> 0332e8f3d269e7765b94a8fa18335256a95044f3
			<script>
				alert("<%= result %>");
				location.href="insert_prof.jsp?year_semester=201902";
			</script>
<%
		} 
		catch (SQLException ex) {
			ex.printStackTrace();
			System.err.println("SQLException: " + ex.getMessage());
		}
		finally {
			if (cstmt != null) {
				try { 
					myConn.commit(); 
					cstmt.close(); 
					myConn.close(); 
				}
				catch (SQLException ex) { }
			}
		}
	}
%>