<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% String session_id = (String)session.getAttribute("user");
	String log;
	if (session_id == null)
		log = "<a href=login.jsp>로그인</a>";
	else 
		log = "<a href=logout.jsp>로그아웃</a>"; %>

<table width="75%" align="center" bgcolor="#FFFF99" border>
	<tr>
		<td align="center"><b><%=log%></b></td>
		<td align="center"><b><a href="update.jsp">사용자 정보 수정</b></td>
<<<<<<< HEAD

		<td align="center"><b><a href="insert.jsp?year_semester=201901">수강신청 입력</b></td>
		<td align="center"><b><a href="delete2.jsp">수강신청 삭제</b></td>
		<td align="center"><b><a href="select.jsp?year_semester=201901">수강신청 조회</b></td>
		<td align="center"><b><a href="logout.jsp">로그아웃</a></b></td>
=======
		<td align="center"><b><a href="insert.jsp?year_semester=201902">수강신청 입력</b></td>
		<td align="center"><b><a href="delete.jsp">수강신청 삭제</b></td>
	<td align="center"><b><a href="select.jsp?year_semester=201902">수강신청 조회</b></td>
>>>>>>> 55cab73f51104e177ed0b030585d777136fab51f
	</tr>
</table>
