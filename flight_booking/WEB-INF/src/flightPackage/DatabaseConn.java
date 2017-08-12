package FlightPackage;

import java.io.*;
import java.sql.*;
import java.util.*;

public class DatabaseConn {
	String url;
	String db_name;
	String driver;
	String db_uname;
	String db_upass;

	public Connection getConnection(){
		Connection con = null;
		try{
			System.out.println("Connecting to database!");
			url = "jdbc:mysql://localhost:3306/";
			db_name = "sap_flight_v1_0?autoReconnect=true&useSSL=false";
			driver = "com.mysql.jdbc.Driver";
			db_uname = "dbuser";
			db_upass = "123123123";
			Class.forName(driver);
			con = DriverManager.getConnection(url+db_name , db_uname , db_upass);
		}catch(Exception e){
			System.out.println(e);
		}
		
		return con;
	}

	void closeConnection(Connection con) throws SQLException{
		con.close();
	}
}
