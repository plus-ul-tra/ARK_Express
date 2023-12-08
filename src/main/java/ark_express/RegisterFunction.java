package ark_express;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class RegisterFunction{
    private static final String url = "jdbc:mysql://localhost:3306/ark";
    private static final String dbUser = "root";
    private static final String dbPass = "gksdnf12!";
	
    public static void main(String[] args) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, dbUser, dbPass);

            String query = "INSERT INTO accounts (id, password, name, authority) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            pstmt.setString(3, username);
            pstmt.setInt(4, authority);

            int result = pstmt.executeUpdate();

            if (result > 0) {
                System.out.println("회원가입 성공!");
            } else {
                System.out.println("회원가입 실패");
            }

            pstmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
