<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>register vehicle</title>
<link rel="stylesheet" href="css/resume.css">
</head>
<body>

    <h2>Vehicle List</h2>

    <table border="1" id="resumeTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Species</th>
                <th>Terrain</th>
                <th>Hub</th>
                <th>Capacity</th>
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
                    String query = "SELECT * FROM vehicle";
                    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
                        ResultSet resultSet = pstmt.executeQuery();

                        while (resultSet.next()) {
                            String id = resultSet.getString("ve_id");
                            String species = resultSet.getString("species");
                            String terrain = resultSet.getString("terr_id");
                            String hub = resultSet.getString("hub_id");
                            int capacity = resultSet.getInt("max_cap");
            %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= species %></td>
                                <td><%= terrain %></td>
                                <td><%= hub %></td>
                                <td><%= capacity %></td>
                             
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
    
    <div class ="container">
    <form id="reg_vehicle" class="hidden" action ="" method ="post">
        <p id = "vehicle">Vehicle</p>
        
        <label>ID 등록: </label>
        <input type="text" name="ve_id" required><br>
        
        <label>종: </label>
        <input type="text" name="species" required><br>
        
        <label>운행가능 지역: </label>
        <input type="text" name="terrain_id" required><br>
        
        <label>관리 Hub: </label>
        <input type="text" name="hub_id" required><br>
       	
       	<label>max용량: </label>
       	<input type="text" name="max_cap" required><br>
        <br>
        
        <input type="submit" value="등록">
        <button type="button" onclick ="closeForm('reg_vehicle')">닫기</button>
        

    </form>
    </div>
    <br>
    <button onclick="redirectToRegister('manage_page.jsp')">돌아가기</button>
    <button onclick="showForm('reg_vehicle')">운송수단 등록</button>
    
<script src="javascript/knightPage.js"></script>
</html>