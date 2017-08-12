package FlightPackage;

import java.io.*;
import java.util.*;
import java.security.*;

import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class User{

	Connection con;

	public User(){
		DatabaseConn dbCon = new DatabaseConn();
		con = dbCon.getConnection();
	}
	
	//returns false if the email id already exists
    //else return false
	public boolean signUp (String inEmail,String inContact,String inPassword,String inFname,String inLname,String inBillingAddress){
		boolean retval = false;
		int initialMiles=500;
		try{
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT email FROM flt_users WHERE email='"+inEmail+"'");
			if(!rs.next()){
				st.executeUpdate("INSERT INTO flt_users(email,contact,password,fname,lname,air_miles,billing_address) VALUES('"+inEmail+"','"+inContact+"','"+inPassword+"','"+inFname+"','"+inLname+"','"+initialMiles+"','"+inBillingAddress+"')");
				retval = true;
			}else{
				retval = false;
			}
		}catch(Exception e){
			System.out.println(e);
		}
		return retval;
	}
	
	
	public boolean login (String inUsername,String inPassword,HttpSession session){
		Boolean retval = false;

		try{

			String password = inPassword;
			byte[] bytesOfMessage = password.getBytes("UTF-8");
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] encodedPassword = md.digest(bytesOfMessage);
			StringBuffer buf = new StringBuffer();
			for (int i = 0; i < encodedPassword.length; i++) {
				if (((int) encodedPassword[i] & 0xff) < 0x10) {
					buf.append("0");
				}
				buf.append(Long.toString((int) encodedPassword[i] & 0xff, 16));
			}
			String passw = buf.toString();
			System.out.println(passw);

			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM flt_users WHERE email='"+inUsername+"' AND password='"+passw+"' ;");
			if(!rs.next())	retval = false;
			else {
				session.setAttribute("isLoggedIn",true);
				session.setAttribute("user_id",rs.getInt("user_id"));
				session.setAttribute("email",rs.getString("email"));
				session.setAttribute("contact",rs.getString("contact"));
				session.setAttribute("fname",rs.getString("fname"));
				session.setAttribute("lname",rs.getString("lname"));
				session.setAttribute("air_miles",rs.getInt("air_miles"));
				session.setAttribute("billing_address",rs.getString("billing_address"));
				retval = true;
			}
		}catch(Exception e){
			System.out.println(e);
		}

		return retval;
	}

	public ArrayList<MyBooking> getUserBookings(HttpSession session){

		ArrayList<MyBooking> bookedFlights = null;
		
		//search for routes	
		Statement st = null;
		ResultSet rs = null;
		
		try{
			//String userName = (String) session.getAttribute("userName"); // where is userName
			int user_id =  Integer.parseInt(session.getAttribute("user_id").toString());

			rs = st.executeQuery("SELECT * FROM flt_booking WHERE user_id = "+user_id);
		
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
}