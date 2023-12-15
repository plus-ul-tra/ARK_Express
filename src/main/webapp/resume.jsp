<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resume List</title>
    <link rel="stylesheet" href="css/resume.css">
</head>
<body>

    <h2>Resume List</h2>

    <table border="1" id="resumeTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Tribe</th>
                <th>Hub</th>
                <th>Dragon License</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
                try {
                    // JDBC 드라이버 로드
                    Class.forName("org.mariadb.jdbc.Driver");

                    // 데이터베이스 연결
                    String jdbcUrl = "jdbc:mariadb://localhost:3306/Ark";
                    String dbUser = "root";
                    String dbPass = "gksdnf12!";
                    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

                    // SQL 쿼리 작성 및 실행
                    String query = "SELECT * FROM resume";
                    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
                        ResultSet resultSet = pstmt.executeQuery();

                        while (resultSet.next()) {
                            String id = resultSet.getString("id");
                            String name = resultSet.getString("name");
                            String tribe = resultSet.getString("tribe");
                            String hub = resultSet.getString("hub");
                            int dragonLicense = resultSet.getInt("dragon_license");
            %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= name %></td>
                                <td><%= tribe %></td>
                                <td><%= hub %></td>
                                <td><%= dragonLicense == 1 ? "있음" : "없음" %></td>
                                <td><button onclick="" data-id="<%= id %>">등록</button></td>
                            </tr>
            <%
                        }
                    }

                    // 연결 닫기
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("오류 발생: " + e.getMessage());
                }
            %>
        </tbody>
    </table>
    <br>
    <button onclick="redirectToRegister('manage_page.jsp')">돌아가기</button>
    
<script src="javascript/knightPage.js"></script>
</body>
</html>
