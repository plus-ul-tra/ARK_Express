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
 	<button onclick="showForm('knight_resume')">기사 등록 신청</button> 
 	<br>
    <button onclick="showForm('form2')">Show Form 2</button>

    <!-- form1 -->
    <form id="knight_resume" class="hidden" action ="" method ="post">
        <p id = "resume">resume</p>
        
        <label>종족: </label>
        <input type="text" name="tribe" required><br>
        
        <label>지원 허브: </label>
        <input type="text" name="hub" required><br>
        
        <label>용기사 자격증 유무: </label>
        <select name = "dragonLicense" required>
            <option value="0">없음</option>
            <option value="1">있음</option>
        </select>
        <br>
        
        <input type="submit" value="신청">
        <button type="button" onclick ="closeForm('knight_resume')">닫기</button>
        

    </form>

    <!-- form2 -->
    <form id="form2" class="hidden">
        <h2>Form 2</h2>
        <!-- form2의 내용 -->
    </form>
</div>
    <script src="javascript/knightPage.js">
    </script>
    <%
    // 데이터 받기
    Object id_data = session.getAttribute("id");
    Object username_data = session.getAttribute("username");
    
    String id = (String)id_data;
    String username = (String)username_data;
    String tribe = request.getParameter("tribe");
    String hub = request.getParameter("hub");
    String dragonParam = request.getParameter("dragonLicense");

    // 사용자가 회원가입 버튼을 눌렀을 때만 데이터베이스 처리
    if (request.getMethod().equalsIgnoreCase("post")) {
        int dragon;

        // authorityParam이 null이 아니고 숫자로 구성되어 있으면 파싱
        if (dragonParam != null && dragonParam.matches("\\d+")) {
            dragon = Integer.parseInt(dragonParam);
        } else {
            // 기본값 또는 예외 처리
            dragon = 0; // 또는 다른 기본값 설정
        }
        String jdbcDriver = "jdbc:mariadb://localhost:3306/Ark";
        String dbUser = "root";
        String dbPass = "gksdnf12!";
        
        try {
            // JDBC 드라이버 로드

            // 데이터베이스 연결
            Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // SQL 쿼리 작성 및 실행
            String query = "INSERT INTO resume (id, name, tribe, hub, dragon_license) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setString(1, id);
                pstmt.setString(2, username);
                pstmt.setString(3, tribe);
                pstmt.setString(4, hub);
                pstmt.setInt(5, dragon);

                int result = pstmt.executeUpdate();

                if (result > 0) {
                	out.println("<script>showPopup('이력서 등록 성공');</script>");
                } else {
                	out.println("<script>showPopup('이력서 등록 실패');</script>");
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
</body>
</html>