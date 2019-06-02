<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>수강신청 시스템 로그아웃</title>
</head>
<body>
<% 
	String session_id = request.getParameter("userID");
	session_id = null;
%>
	<form action = "login.jsp?=session_id" method = "post"> 
		<script>
			alert("로그아웃 되었습니다.");
			location.href="login.jsp";
		</script>
	</form>
</body>
</html>