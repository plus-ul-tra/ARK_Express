<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Ark-express : Knight</title>
<link rel="stylesheet" href="css/knightPage.css">
</head>
<body>
<div class ="container">
	<h1>Page For Knights</h1>
 	<button onclick="showForm('knight_resume')">��� ��� ��û</button> 
 	<br>
    <button onclick="showForm('form2')">Show Form 2</button>

    <!-- form1 -->
    <form id="knight_resume" class="hidden" action ="" method ="post">
        <p id = "resume">resume</p>
        
        <label>����: </label>
        <input type="text" name="tribe" required><br>
        
        <label>���� ���: </label>
        <input type="text" name="hub" required><br>
        
        <label>���� �ڰ��� ����: </label>
        <select name = "dragonLicense" required>
            <option value="0">����</option>
            <option value="1">����</option>
        </select>
        <br>
        
        <input type="submit" value="��û">
        <button type="button" onclick ="closeForm('knight_resume')">�ݱ�</button>
        

    </form>

    <!-- form2 -->
    <form id="form2" class="hidden">
        <h2>Form 2</h2>
        <!-- form2�� ���� -->
    </form>
</div>
    <script src="javascript/knightPage.js">
    </script>
    <%
    // ������ �ޱ�
    Object id_data = session.getAttribute("id");
    Object username_data = session.getAttribute("username");
    
    String id = (String)id_data;
    String username = (String)username_data;
    String tribe = request.getParameter("tribe");
    String hub = request.getParameter("hub");
    String dragonParam = request.getParameter("dragonLicense");

    // ����ڰ� ȸ������ ��ư�� ������ ���� �����ͺ��̽� ó��
    if (request.getMethod().equalsIgnoreCase("post")) {
        int dragon;

        // authorityParam�� null�� �ƴϰ� ���ڷ� �����Ǿ� ������ �Ľ�
        if (dragonParam != null && dragonParam.matches("\\d+")) {
            dragon = Integer.parseInt(dragonParam);
        } else {
            // �⺻�� �Ǵ� ���� ó��
            dragon = 0; // �Ǵ� �ٸ� �⺻�� ����
        }
        String jdbcDriver = "jdbc:mariadb://localhost:3306/Ark";
        String dbUser = "root";
        String dbPass = "gksdnf12!";
        
        try {
            // JDBC ����̹� �ε�

            // �����ͺ��̽� ����
            Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // SQL ���� �ۼ� �� ����
            String query = "INSERT INTO resume (id, name, tribe, hub, dragon_license) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setString(1, id);
                pstmt.setString(2, username);
                pstmt.setString(3, tribe);
                pstmt.setString(4, hub);
                pstmt.setInt(5, dragon);

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