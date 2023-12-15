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
 	<button onclick="redirectToRegister('resume.jsp')">이력서 보기</button> 
 	<br>
    <button onclick="showForm('register_village')">신규 마을 등록</button>
    <br>
    <button onclick="showForm('register_hub')">신규 HUB 등록</button>

    <!-- 마을 등록 form -->
    <form id="register_village" class="hidden" action ="" method ="post">
        <h2 id = "village">new village register</h2>
        <label>마을이름: </label>
        <input type="text" name="vill_name" required><br>
        <label>마을ID: </label>
        <input type="text" name="vill_id" required><br>                 
        <label>지형: </label>
        <input type="text" name="terrain_vill" required><br>
        <label>지원HUB: </label>
        <input type="text" name="hub_vill" required><br>   
        <label>HUB거리: </label>
        <input type="text" name="distance" required><br>
        <br>
      
        <input type="submit" value="등록">
        <button type="button" onclick ="closeForm('register_village')">닫기</button>
        
    </form>

    <!-- 신규허브 등록 -->
    <form id="register_hub" class="hidden" action ="" method ="post">
        <h2>New HUB register</h2>
        <label>HUB ID: </label>
        <input type="text" name="hub_id" required><br>
                
        <label>지형 ID: </label>
        <input type="text" name="terrain_hub" required><br>
        
        <label>본부 ID: </label>
        <input type="text" name="headquarter" required><br>
        
        
        <br>
        
        <input type="submit" value="등록">
        <button type="button" onclick ="closeForm('register_hub')">닫기</button>
    </form>
</div>
    <script src="javascript/knightPage.js">
    
    </script>
    <%
    //마을 등록을 위한 파라미터
    String villId = request.getParameter("vill_id");
    String villageName = request.getParameter("vill_name");
    String terrForVill = request.getParameter("terrain_vill");
    String hubForVill = request.getParameter("hub_vill");
    String distanceParam = request.getParameter("distance");
    
    //hub등록을 위한 파라미터
	String hubForRe = request.getParameter("hub_id");
	String terrain = request.getParameter("terrain_hub");
	String headquarter = request.getParameter("headquarter");
    
    
    
    // 사용자가 회원가입 버튼을 눌렀을 때만 데이터베이스 처리
    if (request.getMethod().equalsIgnoreCase("post")) {
    	
        String jdbcDriver = "jdbc:mariadb://localhost:3306/Ark";
        String dbUser = "root";
        String dbPass = "gksdnf12!";
        int distance;
        
        //신규 마을 등록
        // distance 있는 경우 즉, form village register에 작성된 경우
        // authorityParam이 null이 아니고 숫자로 구성되어 있으면 파싱
        if (distanceParam != null && distanceParam.matches("\\d+")) {
            distance = Integer.parseInt(distanceParam);
            try {
                // JDBC 드라이버 로드

                // 데이터베이스 연결
                Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

                // SQL 쿼리 작성 및 실행
                String query = "INSERT INTO village (vill_id, vill_name, near_hub_id, distance_to_hub, terr_id) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = con.prepareStatement(query)) {
                    pstmt.setString(1, villId);
                    pstmt.setString(2, villageName);
                    pstmt.setString(3, hubForVill);
                    pstmt.setInt(4, distance);
                    pstmt.setString(5, terrForVill);

                    int result = pstmt.executeUpdate();

                    if (result > 0) {
                    	out.println("<script>showPopup('마을 등록 완료');</script>");
                    } else {
                    	out.println("<script>showPopup('마을 등록 실패');</script>");
                    }
                }
                // 연결 닫기
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("오류 발생: " + e.getMessage());
            }            
            
        } else {
            // 기본값 또는 예외 처리
            distance = 5555; // 또는 다른 기본값 설정
        }    
	if(headquarter != null){
        try {
            // JDBC 드라이버 로드

            // 데이터베이스 연결
            Connection con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            // SQL 쿼리 작성 및 실행
            String query = "INSERT INTO hub (hub_id, terr_id, head_id) VALUES (?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setString(1, hubForRe);
                pstmt.setString(2, terrain);
                pstmt.setString(3, headquarter);

                int result = pstmt.executeUpdate();

                if (result > 0) {
                	out.println("<script>showPopup('HUB 등록 완료');</script>");
                } else {
                	out.println("<script>showPopup('HUB 등록 실패');</script>");
                }
            }
            // 연결 닫기
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("오류 발생: " + e.getMessage());
        }		
	}   
        
    }
    
	%>
</body>
</html>