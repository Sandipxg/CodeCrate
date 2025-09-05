package CodeMaze;

import java.sql.Connection;
import java.sql.DriverManager;

public class jdbcConnections {
    public static Connection con;
    public jdbcConnections() {
        try {
            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);

            String dburl = "jdbc:mysql://localhost:3306/codecrate";
            String dbuser = "root";
            String dbpass = "";
            con = DriverManager.getConnection(dburl, dbuser, dbpass);
//            jdbcConnections.connect(); // ✅ Connect first



        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new jdbcConnections();
    }
}