<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Ark-express : Knight</title>
</head>
<body>
 	<button onclick="showForm('knight_resume')">��� ��� ��û</button>
    <button onclick="showForm('form2')">Show Form 2</button>

    <!-- form1 -->
    <form id="knight_resume" class="hidden">
        <h2>resume</h2>
        
        <label>����: </label>
        <input type="text" name="tribe" required><br>
        <label>��й�ȣ: </label>
        <input type="password" name="password" required><br>
        <input type="submit" value="�α���">
        <button type="button" onclick="redirectToRegister()">ȸ������</button>
        

    </form>

    <!-- form2 -->
    <form id="form2" class="hidden">
        <h2>Form 2</h2>
        <!-- form2�� ���� -->
    </form>

    <script src="javascript/knightPage.js"></script>
</body>
</html>