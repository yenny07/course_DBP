<%@ page contentType = "text/html; charset=EUC-KR" %>
<%@ page import = "java.sql.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<%
	//�л���忡���� ������û�� �л��� �й��� login_verify.jsp�κ���, ������û�� ������ �����ȣ, ����й� �����͸� insert.jsp�κ��� �޾ƿ´�
	//������忡���� ������û�� ������ ������ login_verify.jsp�κ���, ������û�� ������ �����ȣ, ����й� �����͸� insert_prof.jsp�κ��� �޾ƿ´�
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
		System.out.println("jdbc driver �ε� ����");
	}
	catch (SQLException e) {
		e.printStackTrace();
		System.out.println("����Ŭ ���� ����");
	}
	//�л��� ���
	if (session_id.length() == 7) {
		//CallaleStatement + Procedure ��� �κ� - ������ ������ ������û ��Ͽ� �߰��Ѵ�
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
	//������ ���
	else {
		//������ ������ ���� ������ insert_prof.jsp�κ��� �޾ƿ��� ���� ���Ǵ� ����
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
			System.out.println("����ó��");
%>
			<script>
				alert("�߸��� �Է��Դϴ�.");
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
		} catch (NumberFormatException e){ //input���� �߸��Ǿ��� ��� ���� ó��
			%>
			<script>
			alert("�߸��� �Է��Դϴ�.");
			location.href="insert_prof.jsp?year_semester=201902";
			</script>
			<%
		}
>>>>>>> 0332e8f3d269e7765b94a8fa18335256a95044f3
		try {
			//CallaleStatement + Procedure ��� �κ� - �Է��� ������ ���� ���ο� ������ �����Ѵ�
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