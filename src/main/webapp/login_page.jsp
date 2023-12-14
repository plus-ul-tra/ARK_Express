<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ark-express</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<div class ="container>">
 	<h2>Ark-Express</h2>

    <form action="" method="post">
        <label>아이디: </label>
        <input type="text" name="id" required><br>
        <label>비밀번호: </label>
        <input type="password" name="password" required><br>
        <input type="submit" value="로그인">
        <button type="button" onclick="redirectToRegister()">회원가입</button>
    </form>
    </div>
    <br>

    <script>
        function redirectToRegister() {
            // JavaScript로 페이지 이동
            window.location.href = 'register.jsp';
        }
    </script>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String id = request.getParameter("id");
            String password = request.getParameter("password");

            try {
                // JDBC 드라이버 로드
                Class.forName("org.mariadb.jdbc.Driver");

                // 데이터베이스 연결
                String jdbcUrl = "jdbc:mariadb://localhost:3306/Ark";
                String dbUser = "root";
                String dbPass = "gksdnf12!";
                Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

                // SQL 쿼리 작성 및 실행
                String query = "SELECT * FROM accounts WHERE id=? AND password=?";
                try (PreparedStatement pstmt = connection.prepareStatement(query)) {
                    pstmt.setString(1, id);
                    pstmt.setString(2, password);

                    ResultSet resultSet = pstmt.executeQuery();

                   //로그인 성공,
                    if (resultSet.next()) {
                    	
                    	//권한, 및 이름 확인
                        int authority = resultSet.getInt("authority");
                    	String username= resultSet.getString("name");
                    	
                    	//세션으로 다음 페이지에 필요할 id와 username 생성
                        session.setAttribute("id", id);
                        session.setAttribute("username", username);
                        // 로그인 성공 시 권한에 맞는 페이지로 이동
                        switch (authority){
                        
                        case 0 :
                        	response.sendRedirect("manage_page.jsp");
                        	break;
                        case 1 :
                        	response.sendRedirect("knight_page.jsp");
                        	break;                        
                        case 2 :
                        	response.sendRedirect("user_page.jsp");
                        	break;                        
                        }
                        
                    } else {
                        out.println("로그인 실패!");
                    }
                }

            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("오류 발생: " + e.getMessage());
            }
        }
    %>
</body>
</html>
