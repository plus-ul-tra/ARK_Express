<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>result</title>
</head>
<body>
<%
try{
	String name =request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String authority = request.getParameter("authority");
	String redirect = null;
	String trigger_name ="Jhon";
	
	if(name.equals(trigger_name)){
		session.setAttribute("user_name", name);
		redirect = "welcom.jsp";
	}
	if(redirect != null)
		response.sendRedirect(redirect);
%>
	<div>
		<h1>���</h1>
		<p>���۵� ����</p>
		<p>
		�̸� : <%=name %>
		</p>
		<p>
		���� : <%=authority %>
		</p>
		<p>
		���� : <%=age %>
		</p>
		
	</div>
	<%
	} catch (NumberFormatException e){
	%>
	<h1>�̷� !</h1>
	<p>
	�ùٸ� �����Է� �ض�. <%} %>
</body>
</html>

















