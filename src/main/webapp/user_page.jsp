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
 	<button onclick="redirectToRegister('search_cargo.jsp')">배송조회</button> 
 	<br>
    <button onclick="showForm('reg_cargo')">택배 접수</button>
    
    <br>
        <form id="reg_cargo" class="hidden" action ="" method ="post">
        <p id = "resume">택배 접수</p>
        
        <label>출발지 마을: </label>
        <input type="text" name="origin" required><br>
        
        <label>도착지 마을: </label>
        <input type="text" name="destination" required><br>
        
        <label>화물 크기: </label>
        <select name = "kindOfCargo" required>
            <option value="0">소형</option>
            <option value="1">중형</option>
            <option value="2">대형</option>
        </select>
        <br>
        
        <input type="submit" value="접수">
        <button type="button" onclick ="closeForm('reg_cargo')">닫기</button>
        

    </form>
    
</div>
    <script src="javascript/knightPage.js">
    </script>
        <%
    // 화물 id 랜덤 코드 부여
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

    // 사용자가 회원가입 버튼을 눌렀을 때만 데이터베이스 처리
    if (request.getMethod().equalsIgnoreCase("post")) {
        int cargo;

        // authorityParam이 null이 아니고 숫자로 구성되어 있으면 파싱
        if (cargoParam != null && cargoParam.matches("\\d+")) {
            cargo = Integer.parseInt(cargoParam);
        } else {
            // 기본값 또는 예외 처리
            cargo = 0; // 또는 다른 기본값 설정
        }
        String jdbcDriver = "jdbc:mariadb://localhost:3306/Ark";
        String dbUser = "root";
        String dbPass = "gksdnf12!";
        
        try {
            // JDBC 드라이버 로드

            // 데이터베이스 연결
            Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // SQL 쿼리 작성 및 실행
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