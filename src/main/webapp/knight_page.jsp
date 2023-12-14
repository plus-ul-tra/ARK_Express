<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Ark-express : Knight</title>
</head>
<body>
 	<button onclick="showForm('knight_resume')">기사 등록 신청</button>
    <button onclick="showForm('form2')">Show Form 2</button>

    <!-- form1 -->
    <form id="knight_resume" class="hidden">
        <h2>resume</h2>
        
        <label>종족: </label>
        <input type="text" name="tribe" required><br>
        <label>비밀번호: </label>
        <input type="password" name="password" required><br>
        <input type="submit" value="로그인">
        <button type="button" onclick="redirectToRegister()">회원가입</button>
        

    </form>

    <!-- form2 -->
    <form id="form2" class="hidden">
        <h2>Form 2</h2>
        <!-- form2의 내용 -->
    </form>

    <script src="javascript/knightPage.js"></script>
</body>
</html>