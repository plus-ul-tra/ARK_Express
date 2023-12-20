<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.util.Random,
java.sql.DriverManager, jakarta.servlet.http.HttpServlet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Ark-express : User</title>
<link rel="stylesheet" href="css/knightPage.css">
</head>
<body>

<div class ="container">
	<h1>Page For User</h1>
 	<button onclick="redirectToRegister('search_cargo.jsp')">�����ȸ</button> 
 	<br>
    <button onclick="showForm('reg_cargo')">�ù� ����</button>
    
    <br>
        <form id="reg_cargo" class="hidden" action ="" method ="post">
        <p id = "resume">�ù� ����</p>
        
        <label>����� ����: </label>
        <input type="text" name="origin" required><br>
        
        <label>������ ����: </label>
        <input type="text" name="destination" required><br>
        
        <label>ȭ�� ũ��: </label>
        <select name = "kindOfCargo" required>
            <option value="0">����</option>
            <option value="1">����</option>
            <option value="2">����</option>
        </select>
        <br>
        
        <input type="submit" value="����">
        <button type="button" onclick ="closeForm('reg_cargo')">�ݱ�</button>
        

    </form>
    
</div>
    <script src="javascript/knightPage.js">
    </script>
        <%
    // ȭ�� id ���� �ڵ� �ο�
    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    
    Random random = new Random();

    
    StringBuilder idBuilder = new StringBuilder();

    
    int firstCharIndex = random.nextInt(characters.length());
    char firstChar = characters.charAt(firstCharIndex);
    idBuilder.append(firstChar);

   
    for (int i = 0; i < 6; i++) {
        int randomIndex = random.nextInt(characters.length());
        char randomChar = characters.charAt(randomIndex);
        idBuilder.append(randomChar);
    }
    String id = idBuilder.toString();
    String ori_id = request.getParameter("origin");
    String des_id = request.getParameter("destination");
    String cargoParam = request.getParameter("kindOfCargo");

    // ����ڰ� ȸ������ ��ư�� ������ ���� �����ͺ��̽� ó��
    if (request.getMethod().equalsIgnoreCase("post")) {
        int cargo;

        // authorityParam�� null�� �ƴϰ� ���ڷ� �����Ǿ� ������ �Ľ�
        if (cargoParam != null && cargoParam.matches("\\d+")) {
            cargo = Integer.parseInt(cargoParam);
        } else {
            // �⺻�� �Ǵ� ���� ó��
            cargo = 0; // �Ǵ� �ٸ� �⺻�� ����
        }
        String jdbcDriver = "jdbc:mariadb://localhost:3306/Ark";
        String dbUser = "root";
        String dbPass = "gksdnf12!";
        
        try {
            // JDBC ����̹� �ε�

            // �����ͺ��̽� ����
            Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // SQL ���� �ۼ� �� ����
            String query = "INSERT INTO cargo (cargo_id, knight_id, origin_id, dest_id, status, kind_cargo) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setString(1, id);
                pstmt.setString(2, null);
                pstmt.setString(3, ori_id);
                pstmt.setString(4, des_id);
                pstmt.setString(5, null);
                pstmt.setInt(6, cargo);

                int result = pstmt.executeUpdate();

                if (result > 0) {
                	out.println("<script>showPopup('�̷¼� ��� ����');</script>");
                } else {
                	out.println("<script>showPopup('�̷¼� ��� ����');</script>");
                }
            }
            // ���� �ݱ�
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("���� �߻�: " + e.getMessage());
        }
    }
    
	%>
</body>
</html>