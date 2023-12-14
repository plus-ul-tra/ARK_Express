<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register to Ark</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class ="container>">
    <h2>Register</h2>
    <% 
        // 데이터 받기
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String username = request.getParameter("username");
        String authorityParam = request.getParameter("authority");

        // 사용자가 회원가입 버튼을 눌렀을 때만 데이터베이스 처리
        if (request.getMethod().equalsIgnoreCase("post")) {
            int authority;

            // authorityParam이 null이 아니고 숫자로 구성되어 있으면 파싱
            if (authorityParam != null && authorityParam.matches("\\d+")) {
                authority = Integer.parseInt(authorityParam);
            } else {
                // 기본값 또는 예외 처리
                authority = 0; // 또는 다른 기본값 설정
            }
            String jdbcDriver = "jdbc:mariadb://localhost:3306/Ark";
            String dbUser = "root";
            String dbPass = "gksdnf12!";
            
            try {
                // JDBC 드라이버 로드

                // 데이터베이스 연결
                Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

                // SQL 쿼리 작성 및 실행
                String query = "INSERT INTO accounts (id, password, name, authority) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pstmt = con.prepareStatement(query)) {
                    pstmt.setString(1, id);
                    pstmt.setString(2, password);
                    pstmt.setString(3, username);
                    pstmt.setInt(4, authority);

                    int result = pstmt.executeUpdate();

                    if (result > 0) {
                        out.println("회원가입 성공!");
                        response.sendRedirect("login_page.jsp");
                    } else {
                        out.println("회원가입 실패");
                    }
                }
                // 연결 닫기
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("오류 발생: " + e.getMessage());
            }
        }
    %>
    <form action="" method="post">
        <label>아이디: </label>
        <input type="text" name="id" required><br>
        
        <label>비밀번호: </label>
        <input type="password" name="password" required><br>
        
        <label>이름 : </label>
        <input type="text" name="username" required><br>
       
        <label>권한 : </label>
        <select name="authority" required>
            <option value="0">Manager</option>
            <option value="1">Knight</option>
            <option value="2">User</option>
        </select>
        <br>
        <input type="submit" value="회원가입">
    </form>
    </div>
</body>
</html>