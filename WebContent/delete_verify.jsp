<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	String session_id = (String) session.getAttribute("user");
	String c_id=request.getParameter("c_id");
	int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
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
	
	if(session_id.length() == 7){	//학생의 경우
		
		//저장 프로시저를 부르기 위한 callable statement의 이용
		//학생이 수강신청한 과목을 지우면 해당 프로시저가 실행된다
		//스크롤 옵션과 동시성 옵션을 주었다
		cstmt = myConn.prepareCall("{call deleteEnroll(?,?,?)}",
	    	    ResultSet.TYPE_SCROLL_SENSITIVE,
	        	ResultSet.CONCUR_READ_ONLY);
	   	
		cstmt.setString(1, session_id);
	   	cstmt.setString(2, c_id);
	   	cstmt.setInt(3,c_id_no);
	   
	}else if(session_id.length() == 5){ //교수의 경우
		
		//저장 프로시저를 부르기 위한 callable statement의 이용
		//교수가 개설한 과목을 없애면 해당 프로시저가 실행된다
		//스크롤 옵션과 동시성 옵션을 주었다
		cstmt = myConn.prepareCall("{call deleteCourse(?,?,?)}",
		        ResultSet.TYPE_SCROLL_SENSITIVE,
		        ResultSet.CONCUR_READ_ONLY);
		
		cstmt.setString(1, session_id);
		cstmt.setString(2, c_id);
		cstmt.setInt(3,c_id_no);
	}
	
<<<<<<< HEAD
	
	  try {
			cstmt.execute();
			
			if(session_id.length() == 7)
		   	 	result = "수강 신청이 취소되었습니다.";
			
			if(session_id.length() == 5)
			   	 result = "강의 개설이 취소되었습니다.";
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
		 	  	 try { 
		   			 myConn.commit(); cstmt.close(); myConn.close(); 
		   			 } catch(SQLException ex) { }
			   }
=======
	   try {
		   
		      cstmt.execute();
		      System.out.println("executed");
		      if (session_id.length() == 7) {
		    	  result = "���� ��û�� ��ҵǾ����ϴ�.";
		      }
		      else {
			      result = "���� ������ ��ҵǾ����ϴ�.";
		      }
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
>>>>>>> 0332e8f3d269e7765b94a8fa18335256a95044f3
		
%>