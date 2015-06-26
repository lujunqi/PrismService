package test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.prism.dbutil.DBConnection;
import com.prism.dbutil.VMPreparedStatement;

public class Test1021 {

	public static void main(String[] args) {
		DBConnection db1 = new DBConnection();
		Map<String, String> j1 = new HashMap<String, String>();
		j1.put("username", "HNTL");
		j1.put("password", "123456");
		j1.put("url", "jdbc:oracle:thin:@188.80.65.7:1521:dbhnaps");
		j1.put("driverClassName", "oracle.jdbc.OracleDriver");
		db1.setJDBC(j1);
		Connection c1 = db1.getConnection();
		
		DBConnection db2 = new DBConnection();
		Map<String, String> j2 = new HashMap<String, String>();
		j2.put("username", "root");
		j2.put("password", "123456");
		j2.put("url", "jdbc:mysql://localhost/test");
		j2.put("driverClassName", "com.mysql.jdbc.Driver");
		db2.setJDBC(j2);
		Connection c2 = db2.getConnection();
		
		
		VMPreparedStatement cmd1 = new VMPreparedStatement(c1);
		try {
			List<Map<String,Object>> l1 = cmd1.getListColValue("SELECT * FROM SM_BEAN");
			for(Map<String,Object> m:l1){
				System.out.println(c2);
				VMPreparedStatement cmd2 = new VMPreparedStatement(c2);
				String ss = 
						"INSERT INTO sm_bean\n" +
								"  (action, `key`, val)\n" + 
								"VALUES\n" + 
								"  (${ACTION<STRING>}, ${KEY<STRING>}, ${VAL<STRING>})";
				cmd2.putAll(m);
				System.out.println(cmd2.executeUpdate(ss));
			}
			
			c1.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
