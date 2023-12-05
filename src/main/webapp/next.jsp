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
		<h1>결과</h1>
		<p>전송된 내용</p>
		<p>
		이름 : <%=name %>
		</p>
		<p>
		권한 : <%=authority %>
		</p>
		<p>
		나이 : <%=age %>
		</p>
		
	</div>
	<%
	} catch (NumberFormatException e){
	%>
	<h1>이런 !</h1>
	<p>
	올바른 정보입력 해라. <%} %>
</body>
</html>

















