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
                    // JDBC ����̹� �ε�
                    Class.forName("org.mariadb.jdbc.Driver");

                    // �����ͺ��̽� ����
                    String jdbcUrl = "jdbc:mariadb://localhost:3306/Ark";
                    String dbUser = "root";
                    String dbPass = "gksdnf12!";
                    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

                    // SQL ���� �ۼ� �� ����
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

                    // ���� �ݱ�
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("���� �߻�: " + e.getMessage());
                }
            %>
        </tbody>
    </table>
    
    <div class ="container">
    <form id="reg_vehicle" class="hidden" action ="" method ="post">
        <p id = "vehicle">Vehicle</p>
        
        <label>ID ���: </label>
        <input type="text" name="ve_id" required><br>
        
        <label>��: </label>
        <input type="text" name="species" required><br>
        
        <label>���డ�� ����: </label>
        <input type="text" name="terrain_id" required><br>
        
        <label>���� Hub: </label>
        <input type="text" name="hub_id" required><br>
       	
       	<label>max�뷮: </label>
       	<input type="text" name="max_cap" required><br>
        <br>
        
        <input type="submit" value="���">
        <button type="button" onclick ="closeForm('reg_vehicle')">�ݱ�</button>
        

    </form>
    </div>
    <br>
    <button onclick="redirectToRegister('manage_page.jsp')">���ư���</button>
    <button onclick="showForm('reg_vehicle')">��ۼ��� ���</button>
    
<script src="javascript/knightPage.js"></script>
</html>