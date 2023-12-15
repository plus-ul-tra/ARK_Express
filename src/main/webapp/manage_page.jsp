<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, 
java.sql.DriverManager, jakarta.servlet.http.HttpServlet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Ark-express : Manager</title>
<link rel="stylesheet" href="css/knightPage.css">
</head>
<body>

<div class ="container">
	<h1>Page For Manager</h1>
 	<button onclick="redirectToRegister('resume.jsp')">�̷¼� ����</button> 
 	<br>
    <button onclick="showForm('register_village')">�ű� ���� ���</button>
    <br>
    <button onclick="showForm('register_hub')">�ű� HUB ���</button>

    <!-- ���� ��� form -->
    <form id="register_village" class="hidden" action ="" method ="post">
        <h2 id = "village">new village register</h2>
        <label>�����̸�: </label>
        <input type="text" name="vill_name" required><br>
        <label>����ID: </label>
        <input type="text" name="vill_id" required><br>                 
        <label>����: </label>
        <input type="text" name="terrain_vill" required><br>
        <label>����HUB: </label>
        <input type="text" name="hub_vill" required><br>   
        <label>HUB�Ÿ�: </label>
        <input type="text" name="distance" required><br>
        <br>
      
        <input type="submit" value="���">
        <button type="button" onclick ="closeForm('register_village')">�ݱ�</button>
        
    </form>

    <!-- �ű���� ��� -->
    <form id="register_hub" class="hidden" action ="" method ="post">
        <h2>New HUB register</h2>
        <label>HUB ID: </label>
        <input type="text" name="hub_id" required><br>
                
        <label>���� ID: </label>
        <input type="text" name="terrain_hub" required><br>
        
        <label>���� ID: </label>
        <input type="text" name="headquarter" required><br>
        
        
        <br>
        
        <input type="submit" value="���">
        <button type="button" onclick ="closeForm('register_hub')">�ݱ�</button>
    </form>
</div>
    <script src="javascript/knightPage.js">
    
    </script>
    <%
    //���� ����� ���� �Ķ����
    String villId = request.getParameter("vill_id");
    String villageName = request.getParameter("vill_name");
    String terrForVill = request.getParameter("terrain_vill");
    String hubForVill = request.getParameter("hub_vill");
    String distanceParam = request.getParameter("distance");
    
    //hub����� ���� �Ķ����
	String hubForRe = request.getParameter("hub_id");
	String terrain = request.getParameter("terrain_hub");
	String headquarter = request.getParameter("headquarter");
    
    
    
    // ����ڰ� ȸ������ ��ư�� ������ ���� �����ͺ��̽� ó��
    if (request.getMethod().equalsIgnoreCase("post")) {
    	
        String jdbcDriver = "jdbc:mariadb://localhost:3306/Ark";
        String dbUser = "root";
        String dbPass = "gksdnf12!";
        int distance;
        
        //�ű� ���� ���
        // distance �ִ� ��� ��, form village register�� �ۼ��� ���
        // authorityParam�� null�� �ƴϰ� ���ڷ� �����Ǿ� ������ �Ľ�
        if (distanceParam != null && distanceParam.matches("\\d+")) {
            distance = Integer.parseInt(distanceParam);
            try {
                // JDBC ����̹� �ε�

                // �����ͺ��̽� ����
                Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

                // SQL ���� �ۼ� �� ����
                String query = "INSERT INTO village (vill_id, vill_name, near_hub_id, distance_to_hub, terr_id) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = con.prepareStatement(query)) {
                    pstmt.setString(1, villId);
                    pstmt.setString(2, villageName);
                    pstmt.setString(3, hubForVill);
                    pstmt.setInt(4, distance);
                    pstmt.setString(5, terrForVill);

                    int result = pstmt.executeUpdate();

                    if (result > 0) {
                    	out.println("<script>showPopup('���� ��� �Ϸ�');</script>");
                    } else {
                    	out.println("<script>showPopup('���� ��� ����');</script>");
                    }
                }
                // ���� �ݱ�
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("���� �߻�: " + e.getMessage());
            }            
            
        } else {
            // �⺻�� �Ǵ� ���� ó��
            distance = 5555; // �Ǵ� �ٸ� �⺻�� ����
        }    
	if(headquarter != null){
        try {
            // JDBC ����̹� �ε�

            // �����ͺ��̽� ����
            Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // SQL ���� �ۼ� �� ����
            String query = "INSERT INTO hub (hub_id, terr_id, head_id) VALUES (?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setString(1, hubForRe);
                pstmt.setString(2, terrain);
                pstmt.setString(3, headquarter);

                int result = pstmt.executeUpdate();

                if (result > 0) {
                	out.println("<script>showPopup('HUB ��� �Ϸ�');</script>");
                } else {
                	out.println("<script>showPopup('HUB ��� ����');</script>");
                }
            }
            // ���� �ݱ�
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("���� �߻�: " + e.getMessage());
        }		
	}   
        
    }
    
	%>
</body>
</html>