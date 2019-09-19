import java.sql.*;

public class Main {
    public static void main(String[] args) throws SQLException {
        String connectionString =
                "jdbc:mysql://localhost:3306/school?user=root&password=guest";

        Connection con = DriverManager
                .getConnection(connectionString);

        PreparedStatement query =
                con.prepareStatement("select Id, Name from students");

        ResultSet result = query.executeQuery();

        while (result.next()) {
            int id = result.getInt("Id");
            String name = result.getString("Name");
            System.out.println(id + " " + name);
        }
    }
}