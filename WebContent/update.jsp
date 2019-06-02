<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
   <title>수강신청 사용자 정보 수정</title>
</head>
<body>
<%@ include file="top.jsp" %>
<%
String dbdriver = "oracle.jdbc.driver.OracleDriver"; //JDBC 드라이버 로딩
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl"; //url
String user = "sook"; //oracle login id
String passwd = "2019"; //pw

Class.forName(dbdriver); // DriverManager.registerDriver(dbdriver);
Connection myConn = null;
Statement stmt = null;
String mySQL = null;

// show_stu_info 변수
String s_pwd = null; 
String s_name = null; 
int s_grade = 0; 
String s_major = null; 
int s_credit = 0;
%>
<%
   if (session_id == null) { %>
      <script> 
         alert("로그인 후 사용하세요."); 
         location.href="login.jsp";  
      </script>
<%
   } else { 
      try{
        // oracle 연결
         myConn = DriverManager.getConnection(dburl, user, passwd);
        
         /* show_stu_info 호출*/
       String sql = "{call show_stu_info(?,?,?,?,?,?)}";
       CallableStatement cstmt = myConn.prepareCall(sql);
       cstmt.setString(1, session_id); // s_id
       cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); // s_pwd
       cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //s_name
       cstmt.registerOutParameter(4, java.sql.Types.INTEGER); // s_grade
       cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); // s_major
       cstmt.registerOutParameter(6, java.sql.Types.INTEGER); // s_credit
       cstmt.execute(); // 프로시저 실행

       s_pwd = cstmt.getString(2);
        s_name = cstmt.getString(3);
       s_grade = cstmt.getInt(4);
       s_major = cstmt.getString(5);
        s_credit = cstmt.getInt(6);
          
       System.out.println(session_id + s_pwd + s_name + s_grade + s_major + s_credit);
      }catch(SQLException e){
          out.println(e);
          e.printStackTrace();
      }
   }
%>
   <form action="update_verify.jsp?id=<%=session_id%>" method="post">
   <table align="center" id="update_table">
   <tr>
     <td id="update_td">아이디</td>
     <td colspan="3"><input id="update_id_in" type="text" name="id" size="50" style="text-align: center;" value="<%=session_id%>" disabled></td>
   </tr>
   <tr>
     <td id = "student_name">이름</td>
     <td colspan="3"><input id="update_name" type="text" name="name" size="50" style="text-align: center;" value="<%=s_name%>" disabled></td>
   </tr>
   <tr>
     <td id = "student_grade">학년</td>
     <td colspan="3"><input id="update_grade" type="number" name="grade" size="50" style="text-align: center;" value="<%=s_grade%>" disabled></td>
   </tr>
   <tr>
     <td id = "student_major">전공</td>
     <td colspan="3"><input id="update_major" type="text" name="major" size="50" style="text-align: center;" value="<%=s_major%>" disabled></td>
   </tr>
   <tr>  
     <td id="update_td">비밀번호</td>
     <td colspan="3"><input id="update_pw_in" type="password" name="password" size="10" value="<%=s_pwd%>"></td>
   </tr>
   <tr>
     <td id="update_td_confirm">비밀번호 확인</td>
     <td colspan="3"><input id="update_pw_in_confirm" type="password" name="passwordConfirm" size="10" ></td>
   </tr>
   <tr>
       <td colspan="4" align="center">
        <input id="update_btn" type="submit" value="수정 완료">
        <input id="update_btn" type="reset" value="초기화">
    </tr>
    </table>
    </form>
<%
      //cstmt.close();
      myConn.close(); 
%>
</body>
</html>