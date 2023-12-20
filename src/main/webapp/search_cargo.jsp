<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.Connection, java.sql.PreparedStatement, 
java.sql.DriverManager, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Search_cargo</title>
<link rel="stylesheet" href="css/search.css">
</head>
<body>
<div class ="container">
<h2>Search Cargo</h2>
<input type="text" name="cargo_id" required><br>
<input type="submit" onclick="showForm('result')" value="�˻�">

    <form id="result" class="hidden" action ="" method ="post">
        <p id = "result">result</p>
        
    <table border="1" id="resumeTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>���Knight</th>
                <th>��߸���</th>
                <th>��������</th>
                <th>����</th>
                <th>ȭ������</th>
            </tr>
        </thead>
        <tbody>
            <% 
            if (request.getMethod().equalsIgnoreCase("post")){
                try {
                    // JDBC ����̹� �ε�
                    Class.forName("org.mariadb.jdbc.Driver");

                    // �����ͺ��̽� ����
                    String jdbcUrl = "jdbc:mariadb://localhost:3306/Ark";
                    String dbUser = "root";
                    String dbPass = "gksdnf12!";
                    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
                    //�˻��� ��������
					String keyword = request.getParameter("cargo_id");
                    // SQL ���� �ۼ� �� ����
                    String query = "SELECT * FROM cargo WHERE cargo_id LIKE ?";
                    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
                    	pstmt.setString(1, "%" + keyword + "%");
                        ResultSet resultSet = pstmt.executeQuery();

                        while (resultSet.next()) {
                            String id = resultSet.getString("cargo_id");
                            String knight = resultSet.getString("knight_id");
                            String origin = resultSet.getString("origin_id");
                            String destination = resultSet.getString("dest_id");
                            String status = resultSet.getString("status");
                            int kindOfCargo = resultSet.getInt("kind_cargo");
            %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= knight %></td>
                                <td><%= origin %></td>
                                <td><%= destination %></td>
                                <td><%= status %></td>
                                <td><%= kindOfCargo %></td>
                             
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
            }
            %>
        </tbody>
    </table>
        <br>
        <button type="button" onclick ="closeForm('result')">�ݱ�</button>
        

    </form>



</div>

    <script src="javascript/knightPage.js">
    </script>
</body>
</html>