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
		<h1>Form post��� </h1>
		<p>������ �����غ���</P>
	</div>
	<form action="next.jsp" method ="post">
	<div>
		<label>Name</label><input name ="name" type = "text"/>
	</div>
	
	<div>
	<label>����</label>
	<br><input type ="radio" name ="authority" value ="User" Checked>User<br>
	<input type ="radio" name ="authority" value ="Knight" Checked>Knight<br>
	<input type ="radio" name ="authority" value ="Manager" Checked>Manager
	</div>
	<div>
	<label>����</label><input name ="age" type ="number" value ="25" required=""/>
	</div>
	<button type = "submit">����</button>
	</form>
</body>
</html>