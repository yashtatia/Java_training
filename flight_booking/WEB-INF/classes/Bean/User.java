package Bean;

import java.io.*;
import java.util.*;

import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class User{

	
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
	

	//returns false if the email id already exists
    //else return false
	public boolean signUp (String inEmail,String inContact,String inPassword,String inFname,String inLname,String inBillingAddress) throws ClassNotFoundException, SQLException{
		
		
		int initialMiles=500;
		Connection con = getConnection();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT email FROM flt_users WHERE email='"+inEmail+"'");
		if(!rs.next())
		{st.executeUpdate("INSERT INTO flt_users(email,contact,password,fname,lname,air_miles,billing_address) VALUES('"+inEmail+"','"+inContact+"','"+inPassword+"','"+inFname+"','"+inLname+"','"+initialMiles+"','"+inBillingAddress+"')");

		return true;}
		else 
			return false;
		
		
	}
	
	
	public boolean login (String inUsername,String inPassword,HttpSession session) throws ClassNotFoundException, SQLException
	{ 
	Connection con = getConnection();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * FROM flt_users WHERE email='"+inUsername+"' AND '"+"password='"+inPassword+"'");
		if(!rs.next())
			return false;
		else 
		{  session.setAttribute("userName",inUsername);
			return true;
		}
		
	}
	


public ArrayList<MyBooking> getUserBookings(HttpSession session){
		ArrayList<MyBooking> bookedFlights = null;
		
		//DatabaseConn dbCon = new DatabaseConn();
		Connection con = null;

		//search for routes	
		Statement st = null;
		ResultSet rs = null;
		
		try{
			/*
		if (session.getAttribute("username") == null || session.getAttribute("username").equals("")){
			
		}
*/      String userName = (String) session.getAttribute("userName");

		 con = getConnection();
		 st = con.createStatement();
		rs = st.executeQuery("SELECT * FROM flt_users WHERE email ='"+userName+"'");
		rs.next();
	    int userId =  rs.getInt("user_id");
		rs = st.executeQuery("SELECT * FROM flt_booking WHERE user_id ="+ userId);
		
		bookedFlights = new ArrayList<MyBooking>();
		
		while(rs.next()){
	
				bookedFlights.add( new MyBooking(
									rs.getInt("booking_id"),
									rs.getInt("user_id"),
									rs.getInt("flight_id"),
									rs.getString("class"),
									rs.getInt("seats"),
									rs.getInt("miles_used"),
									rs.getString("cc_number"),
									rs.getString("cc_expiry"),
									rs.getString("cc_security_pin"),
									rs.getFloat("total_amount")
									)
						);
			}
		
			//search for all flights of given routes on given date and with required vacancy
		
		
		}catch(Exception e){
			System.out.println(e);
		}

		return bookedFlights;
		
		}


		/*
class test{
	
	public static void main(String args[]) throws ClassNotFoundException, SQLException
	{ User obj = new User();
	  boolean a = obj.signUp("c.sriteju@gmail.com","9506729692","sritej1$","sri","tej","heaven");
	  if(a)
	  System.out.println("yes");
	   boolean b = obj.signUp("ram.johani@gmail.com","9506764692","sri54j1$","ram","tej","hell");
	   if(b)
	   System.out.println("yes");
		
	}
	
	
	*/

	
}