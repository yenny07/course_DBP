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
ArrayList<Integer> coursePeriod = new ArrayList<>();
int day;
String period;

try{
   Class.forName(dbdriver);
   Connection myConn = DriverManager.getConnection(dburl, user, passwd);
   
   String mySQL = "select c_id, c_name, p_id, c_credit, c_number, c_major, c_period, c_day1 from course " +
               "where c_id in (select c_id from enroll where s_id = " + session_id + ")"; 
   Statement stmt = myConn.createStatement();
   ResultSet rs = stmt.executeQuery(mySQL);
   
   while (rs.next()) {
      courseID.add(rs.getString("c_id"));
      courseName.add(rs.getString("c_name"));
      profID.add(rs.getString("p_id"));
      courseCredit.add(rs.getInt("c_credit"));
      courseNumber.add(rs.getInt("c_number"));
      courseMajor.add(rs.getString("c_major"));
      coursePeriod.add(rs.getInt("c_period"));
      courseDay1.add(rs.getInt("c_day1"));
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
         period = coursePeriod.remove(0).toString();
         day = courseDay1.remove(0);
         if (day == 1) {
            out.println("월 " + period + "교시");
            out.println("<br>");
            out.println("수 " + period + "교시");
         }
         else if (day == 2) {
            out.println("화 " + period + "교시");
            out.println("<br>");
            out.println("목 " + period + "교시");
         }
         else if (day == 3) {
            out.println("금 " + period + "교시");
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