<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
</head>
<body>
    <h2>로그인</h2>
    <form action="LoginServlet" method="post">
        <label>아이디: </label>
        <input type="text" name="username" required><br>
        <label>비밀번호: </label>
        <input type="password" name="password" required><br>
        <input type="submit" value="로그인">
    </form>
    <br>
    <a href="register.jsp">회원가입</a>
</body>
</html>
