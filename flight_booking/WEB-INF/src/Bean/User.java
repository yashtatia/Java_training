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
	


public ArrayList<Booking> getUserBookings(HttpSession session){
		ArrayList<Booking> bookedFlights = null;
		System.out.println("inm");
		ResultSet rs = null;
		Connection con = null;
		Statement st = null;
		try{
			con = getConnection();
			st = con.createStatement();
   
		//session.setAttribute("userName","c.sritej@gmail.com");
		int userId = (int) session.getAttribute("user_id");
	
		System.out.println(userId);
		rs = st.executeQuery("SELECT * FROM flt_booking WHERE user_id = "+userId);
		/*
		rs.next();
		System.out.println(	rs.getInt("booking_id")+
									rs.getInt("user_id")+
									rs.getInt("flight_id")+
									rs.getString("class")
									);
		
		*/
		bookedFlights = new ArrayList<Booking>();
		
		while(rs.next()){
	
				bookedFlights.add( new Booking(
									rs.getInt("booking_id"),
									rs.getInt("flight_id"),
									rs.getString("class"),
									rs.getInt("seats")
									
									)
						);
			}
		
		
		}catch(Exception e){
			System.out.println(e);
		}

		System.out.println(bookedFlights);

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