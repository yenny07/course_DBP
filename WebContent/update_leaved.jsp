<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>
<div id = "formDialogDiv" style = "display : none;">
	<%@ include file = "top.jsp" %>
</div>
<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "SOOK";
	String passwd = "2019";
	Connection myConn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//휴학 신청 여부를 확인하는 데에 사용되는 변수
	String isLeave; 
	String deletingsql;
	String leavingsql;
	String sql;
	String c_id;
	String DecCurrent;
	int c_number, c_year, c_semester;
	
	try {
		//update.jsp로부터 휴학 신청 여부에 관한 데이터를 받아온다
		isLeave = request.getParameter("leaved");
		
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		DecCurrent = "update Course set c_current = c_current-1 where c_id = ? and c_number = ? and c_year = ? and c_semester = ?";
		pstmt = myConn.prepareStatement(DecCurrent);
		
		//휴학 신청을 한 경우
		if (isLeave.equals("true")) {	
			// Updatable한 ResultSet을 이용하여 Student 테이블에서 휴학여부를 바꾸고
			leavingsql = "select isLeaved from student where s_id = '" + session_id + "'";
			rs = stmt.executeQuery(leavingsql);
			rs.next();
			rs.updateLong(1, 1);
			rs.updateRow();
			rs.close();
			
			// Updatable한 ResultSet을 이용하여 해당 학생이 이번 학기에 수강신청한 과목들을 지움으로써 모두 취소시킨다.
			deletingsql = "select s_id, c_id, c_number, c_year, c_semester from enroll where c_year = 2019 and c_semester = 2 and s_id = '" + session_id + "'";
			rs = stmt.executeQuery(deletingsql);
			
			while(rs.next()){
				
				// 수강신청한 과목들의 현재인원을 1명 빼주는 작업
				c_id = rs.getString(2);
				c_number = rs.getInt(3);
				c_year = rs.getInt(4);
				c_semester = rs.getInt(5);
				pstmt.setString(1, c_id);
				pstmt.setInt(2, c_number);
				pstmt.setInt(3, c_year);
				pstmt.setInt(4, c_semester);
				pstmt.executeUpdate();
				
				// Enroll 테이블에서 삭제
				rs.deleteRow();
			}
			rs.close();

%>		
<script>
	alert('휴학 신청이 완료되었습니다.')
	location.href = "main.jsp";
</script>
<%
		}
		//휴학 신청했던 것을 취소한 경우
		else {
			leavingsql = "select isLeaved from student where s_id = '" + session_id + "'";
			rs = stmt.executeQuery(leavingsql);
			rs.next();
			rs.updateLong(1, 0);
			rs.updateRow();
			rs.close();
%>
<script>
	alert('휴학 취소가 완료되었습니다.')
	location.href = "main.jsp";
</script>
<%
		myConn.commit();
		}
	}
	catch (SQLException ex) {
		System.out.println(ex.getErrorCode());
	}   
	myConn.close();
%>