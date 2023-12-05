<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Ark-Express Login Page</title>
</head>
<body>
	<div>
		<h1>Form post방식 </h1>
		<p>데이터 전송해보자</P>
	</div>
	<form action="next.jsp" method ="post">
	<div>
		<label>Name</label><input name ="name" type = "text"/>
	</div>
	
	<div>
	<label>권한</label>
	<br><input type ="radio" name ="authority" value ="User" Checked>User<br>
	<input type ="radio" name ="authority" value ="Knight" Checked>Knight<br>
	<input type ="radio" name ="authority" value ="Manager" Checked>Manager
	</div>
	<div>
	<label>나이</label><input name ="age" type ="number" value ="25" required=""/>
	</div>
	<button type = "submit">전송</button>
	</form>
</body>
</html>