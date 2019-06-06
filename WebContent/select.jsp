<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<title>수강신청 조회</title>
</head>
<body>
<%@include file="top.jsp"%>

<form action="select.jsp" method="post">
   <div class="yearAndSemesterSelect" style = "padding : 0px 0px 0px 160px;">
    <table>
     <tbody>
      <td>
      <%
      int year_semester = Integer.parseInt(request.getParameter("year_semester"));
  	
	int nYear = year_semester / 100;
  	int nSemester = year_semester % 100;
  	
      if(year_semester == 201902){
    	  %>
      <select name="year_semester">
			<option value=201902 onclick="location.href='select.jsp?year_semester=201902'" selected="selected">2019년 2학기</option>	
			<option value=201901 onclick="location.href='select.jsp?year_semester=201901'" >2019년 1학기</option>
    		<option value=201802 onclick="location.href='select.jsp?year_semester=201802'">2018년 2학기</option>
    		<option value=201801 onclick="location.href='select.jsp?year_semester=201801'">2018년 1학기</option>
	  </select>    
	  <%} else if(year_semester == 201901) { %>
	  <select name="year_semester">
			<option value=201902 onclick="location.href='select.jsp?year_semester=201902'" >2019년 2학기</option>	
			<option value=201901 onclick="location.href='select.jsp?year_semester=201901'" selected="selected">2019년 1학기</option>
    		<option value=201802 onclick="location.href='select.jsp?year_semester=201802'">2018년 2학기</option>
    		<option value=201801 onclick="location.href='select.jsp?year_semester=201801'">2018년 1학기</option>
	  </select>
	  <%} else if(year_semester == 201802) { %>     
	   <select name="year_semester">
			<option value=201902 onclick="location.href='select.jsp?year_semester=201902'" >2019년 2학기</option>	
			<option value=201901 onclick="location.href='select.jsp?year_semester=201901'" >2019년 1학기</option>
    		<option value=201802 onclick="location.href='select.jsp?year_semester=201802'" selected="selected">2018년 2학기</option>
    		<option value=201801 onclick="location.href='select.jsp?year_semester=201801'">2018년 1학기</option>
	  </select>      
	  <%} else { %>
	       <select name="year_semester">
			<option value=201902 onclick="location.href='select.jsp?year_semester=201902'" >2019년 2학기</option>	
			<option value=201901 onclick="location.href='select.jsp?year_semester=201901'" >2019년 1학기</option>
    		<option value=201802 onclick="location.href='select.jsp?year_semester=201802'">2018년 2학기</option>
    		<option value=201801 onclick="location.href='select.jsp?year_semester=201801'" selected="selected">2018년 1학기</option>
	  </select>   
	  <% } %>        
      </td>
     </tbody>
    </table>
   </div>
</form>
<%

String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "SOOK";
String passwd = "2019";

ArrayList<String> courseID = new ArrayList<>();
ArrayList<String> courseName = new ArrayList<>();
ArrayList<String> profID = new ArrayList<>();
ArrayList<Integer> courseCredit = new ArrayList<>();
ArrayList<Integer> courseNumber = new ArrayList<>();
ArrayList<String> courseMajor = new ArrayList<>();
ArrayList<Integer> courseDay1 = new ArrayList<>();
ArrayList<Integer> courseDay2 = new ArrayList<>();
ArrayList<Integer> coursePeriod1 = new ArrayList<>();
ArrayList<Integer> coursePeriod2 = new ArrayList<>();
int day1;
int day2;
String period1;
String period2;

//PreparedStatement pstmt;

CallableStatement cstmt;

try {
   Class.forName(dbdriver);
   Connection myConn = DriverManager.getConnection(dburl, user, passwd);
   
   String sql = "{call getCourseINF(?, ?, ?, ?)}";
   cstmt = myConn.prepareCall(sql);
   cstmt.setString(1, session_id);
   cstmt.setInt(2, nYear);
   cstmt.setInt(3, nSemester);
   cstmt.registerOutParameter(4, oracle.jdbc.OracleTypes.CURSOR);
   cstmt.execute();
   ResultSet rs = (ResultSet)cstmt.getObject(4);

   while (rs.next()) {
      courseID.add(rs.getString("c_id"));
      courseName.add(rs.getString("c_name"));
      profID.add(rs.getString("p_id"));
      courseCredit.add(rs.getInt("c_credit"));
      courseNumber.add(rs.getInt("c_number"));
      courseMajor.add(rs.getString("c_major"));
      coursePeriod1.add(rs.getInt("c_period1"));
      coursePeriod2.add(rs.getInt("c_period2"));
      courseDay1.add(rs.getInt("c_day1"));
      courseDay2.add(rs.getInt("c_day2"));
   }

   rs.close();
   cstmt.close();
   myConn.close();
   
}catch (ClassNotFoundException e){
   e.printStackTrace();
   System.out.println("jdbc driver 로딩 실패");
}catch (SQLException e){
   e.printStackTrace();
   System.out.println("오라클 연결 실패");
} 
%>
   <table width="75%" align="center" border>
      <tr>
         <th>과목번호</th>
         <th>분반</th>
         <th>과목명</th>
         <th>교수</th>
         <th>시간</th>
         <th>학점</th>
      </tr>
<%	 
		 while (!courseID.isEmpty()) {
         out.println("<tr>");
         
         out.println("<td align = \"center\" >");
         out.println(courseID.remove(0));
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         out.println(courseNumber.remove(0));
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         out.println(courseName.remove(0));
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         out.println(profID.remove(0));
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         period1 = coursePeriod1.remove(0).toString();
         period2 = coursePeriod2.remove(0).toString();
         day1 = courseDay1.remove(0);
         day2 = courseDay2.remove(0);
         switch(day1) {
         case 1:
             out.println("월 " + period1 + "교시");
             out.println("<br>");
             break;
         case 2:
             out.println("화 " + period1 + "교시");
             out.println("<br>");
             break;
         case 3:
             out.println("수 " + period1 + "교시");
             out.println("<br>");
             break;
         case 4:
        	 out.println("목 " + period1 + "교시");
             out.println("<br>");
        	 break;
         case 5:
        	 out.println("금 " + period1 + "교시");
             out.println("<br>");
        	 break;
         }
         switch(day2) {
         case 1:
             out.println("월 " + period2 + "교시");
             out.println("<br>");
             break;
         case 2:
             out.println("화 " + period2 + "교시");
             out.println("<br>");
             break;
         case 3:
             out.println("수 " + period2 + "교시");
             out.println("<br>");
             break;
         case 4:
        	 out.println("목 " + period2 + "교시");
             out.println("<br>");
        	 break;
         case 5:
        	 out.println("금 " + period2 + "교시");
             out.println("<br>");
        	 break;
         }
         out.println("</td>");
         
         out.println("<td align = \"center\" >");
         out.println(courseCredit.remove(0));
         out.println("</td>");
         
         out.println("</tr>");
      }
      out.flush();
      
%>
   </table>   
</body>
</html>