package Bean;

import java.io.*;
import java.sql.*;

public class Booking {
	
	
		public Connection getConnection() throws ClassNotFoundException, SQLException{
		System.out.println("Connecting to database!");
		String url = "jdbc:mysql://10.53.32.16:3306/";
		String db_name = "sap_flight_v1_0?autoReconnect=true&useSSL=false";
		String driver = "com.mysql.jdbc.Driver";
		String db_uname = "dbuser";
		String db_upass = "123123123";
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url+db_name , db_uname , db_upass);
		System.out.println("Connected!");
		return con;
	}



	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getTypeClass() {
		return typeClass;
	}

	public void setTypeClass(String typeClass) {
		this.typeClass = typeClass;
	}

	public int getTotalSeats() {
		return totalSeats;
	}

	public void setTotalSeats(int totalSeats) {
		this.totalSeats = totalSeats;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getCarrierName() {
		return carrierName;
	}

	public void setCarrierName(String carrierName) {
		this.carrierName = carrierName;
	}

	int bookingId;
	String source;
	String destination;
	String typeClass;
	int totalSeats;
	String date;
	String time;
	String carrierName;
	
	public Booking(int bookingId, int flightId, String typeClass,int totalSeats) {
		System.out.println("enter");
		try{
			Connection con = getConnection();
		Statement st = con.createStatement();

		//getcarrierName
		 ResultSet rs = st.executeQuery("SELECT * FROM flt_flight WHERE flight_id ="+flightId);
		
		rs.next();
		String carrierId = rs.getString("carrier_id");
		System.out.println(carrierId);
		int routeId = rs.getInt("route_id");
	    System.out.println(routeId);
		//getdate
		this.date = rs.getString("flight_date");
		System.out.println(date);
		//gettime
		this.time = rs.getString("flight_time");
		System.out.println(time);
		ResultSet rs1 = st.executeQuery("SELECT * FROM flt_carrier WHERE carrier_id ='"+carrierId+"'");
		rs1.next();
		this.carrierName = rs1.getString("carrier_name");
		System.out.println(carrierName);
		
		//getsource
		

		rs1 = st.executeQuery("SELECT * FROM flt_route WHERE route_id ="+routeId);
		rs1.next();
		this.source = rs1.getString("source_id");
		System.out.println(source);
		//getdest
		this.destination = rs1.getString("destination_id");
		System.out.println(destination);
		
		this.bookingId = bookingId;
		this.typeClass = typeClass;
		this.totalSeats = totalSeats;
		}
		catch(Exception e){
			System.out.println(e);
			
		}
		System.out.println("exit");
		
	}




	
}
