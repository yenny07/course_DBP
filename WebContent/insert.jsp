<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head> <meta charset="EUC-KR">
	<title>데이터베이스를 활용한 수강신청 시스템입니다.</title>
</head>

<body>
	<%@include file="top.jsp"%>
	<table width="75%" align="center" border>
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
			<th>교수</th>
			<th>시간</th>
			<th>학점</th>
			<th>현재 수강인원</th>
			<th>최대 수강인원</th>
			<th>수강신청</th>
		</tr>
		<form method="post" action="insert_verify.jsp">
		<tr>
			<td align="center"> C1234 </td>
			<td align="center"> 1 </td>
			<td align="center"> 데이터베이스 프로그래밍 </td>
			<td align="center"> 심준호 </td>
			<td align="center"> 월 2교시 <br> 수 2교시 </td>
			<td align="center"> 3 </td>
			<td align="center"> 10 </td>
			<td align="center"> 30 </td>
			<td align="center"><a href="insert_verify.jsp?c_id=C1234&c_id_no=1">신청</a></td>
		</tr>
		</form>
		<form method="post" action="insert_verify.jsp">
		<tr>
			<td align="center"> C1256 </td>
			<td align="center"> 1 </td>
			<td align="center"> 시스템종합설계 </td>
			<td align="center"> 박숙영 </td>
			<td align="center"> 월 2교시 <br> 수 2교시 </td>
			<td align="center"> 3 </td>
			<td align="center"> 10 </td>
			<td align="center"> 20 </td>
			<td align="center"><a href="insert_verify.jsp?c_id=C1256&c_id_no=1">신청</a></td>
		</tr>
		</form>
	</table>
</body>

</html>