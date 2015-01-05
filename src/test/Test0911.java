package test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.Future;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.PoolProperties;

public class Test0911 {
	public static void main(String[] args) throws SQLException {
		PoolProperties p = new PoolProperties();
	    p.setUrl("jdbc:oracle:thin:@10.80.1.188:1521:hnaps");
	    p.setDriverClassName("oracle.jdbc.OracleDriver");
	    p.setUsername("hncust2");
	    p.setPassword("hncust2allinpay");
	    p.setJmxEnabled(true);
	    p.setTestWhileIdle(false);
	    p.setTestOnBorrow(true);
	    p.setValidationQuery("SELECT 1 FROM DUAL");
	    p.setTestOnReturn(false);
	    p.setValidationInterval(30000);
	    p.setTimeBetweenEvictionRunsMillis(30000);
	    p.setMaxActive(100);
	    p.setInitialSize(10);
	    p.setMaxWait(10000);
	    p.setRemoveAbandonedTimeout(60);
	    p.setMinEvictableIdleTimeMillis(30000);
	    p.setMinIdle(10);
	    p.setLogAbandoned(true);
	    p.setRemoveAbandoned(true);
	    p.setJdbcInterceptors("org.apache.tomcat.jdbc.pool.interceptor.ConnectionState;"+
	      "org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer");
	    

		DataSource datasource = new DataSource();

		Future<Connection> future = datasource.getConnectionAsync();
		while (!future.isDone()) {
			System.out
					.println("Connection is not yet available. Do some background work");
			try {
				Thread.sleep(100); // simulate work
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
//		CONN = future.get();
	}
}
