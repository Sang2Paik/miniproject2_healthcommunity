package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBService {
	
	DataSource ds = null;
	
	static DBService single = null;
	
	public static DBService getInstance() {
		if(single == null)
			single = new DBService();
		return single;
	}
	
	private DBService() {
		// TODO Auto-generated constructor stub
		try {
			//객체 생성
			InitialContext ic = new InitialContext();
			//context 불러오기
			Context context = (Context) ic.lookup("java:comp/env");
			ds = (DataSource) context.lookup("jdbc/mysql_test");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws SQLException {
		return ds.getConnection();
	}
	
	
	
}
