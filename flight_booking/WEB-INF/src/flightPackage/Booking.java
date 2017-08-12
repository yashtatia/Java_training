package FlightPackage;

import java.io.*;
import java.sql.*;
import java.util.*;
import com.google.gson.Gson;
import javax.servlet.http.HttpSession;

public class Booking {
	Connection con;
	
	public Booking(){
		DatabaseConn dbCon = new DatabaseConn();
		con = dbCon.getConnection();
	}

	public int bookFlight(int user_id, int flight_id,String seat_type,int seats,int fare_with_miles,int fare_without_miles,int miles_used,int miles_remaining, int miles_earned, String payment_choice, String cc_number, String cc_expiry, String cc_cvv){
		
		Statement stmt = null;
		String query_start_trans = "START TRANSACTION";
		String query_start_commit = "COMMIT";
		String query_start_rollback = "ROLLBACK";
		Boolean retval = false;
		int booking_id = -1;

		try{
			stmt = con.createStatement();
			//start transaction
			ResultSet queryRes = stmt.executeQuery(query_start_trans);

			//check if seats still available
			if(checkAvailability(flight_id,seat_type,seats)){
				//make the payment
				booking_id = makePayment(user_id, flight_id,seat_type,seats,fare_with_miles,fare_without_miles,miles_used,miles_remaining, miles_earned, payment_choice,cc_number,cc_expiry,cc_cvv);
				if(booking_id != -1){
					retval = true;
				}else{
					throw new Exception();
				}
			}else{
				throw new Exception();
			}
			//commit
		}catch(Exception e){
			retval = false;
		}

		try{
			if(retval){
				ResultSet queryRes = stmt.executeQuery(query_start_commit);
			}else{
				ResultSet queryRes = stmt.executeQuery(query_start_rollback);
			}			
		}catch(Exception e){
			System.out.println(e);
			retval = false;
		}
		if(retval) return booking_id;
		else return -1;
	}

	public void refreshMiles(HttpSession session){
		try{
			int user_id = Integer.parseInt(session.getAttribute("user_id").toString());

			Statement stmt = con.createStatement();
			//start transaction
			ResultSet queryRes = stmt.executeQuery("SELECT * FROM flt_users WHERE user_id = "+user_id+";");

			queryRes.next();

			int air_miles = queryRes.getInt("air_miles");

			session.setAttribute("air_miles",air_miles);			
		}catch(Exception e){
			System.out.println(e);
		}
	}

	public Boolean cancelBooking(int booking_id){

		Statement stmt = null;
		String query_start_trans = "START TRANSACTION";
		String query_start_commit = "COMMIT";
		String query_start_rollback = "ROLLBACK";
		Boolean retval = false;

		try{
			stmt = con.createStatement();
			//start transaction
			ResultSet queryRes = stmt.executeQuery(query_start_trans);

			// get booking details
			String query = "select * from flt_booking,flt_flight,flt_route where flt_booking.flight_id = flt_flight.flight_id AND flt_flight.route_id = flt_route.route_id AND flt_booking.booking_id="+booking_id+";";
			queryRes = stmt.executeQuery(query);
			System.out.println(query);

			int user_id;
			int flight_id;
			String seat_type;
			int seats;
			int miles_used;
			int total_amount;
			int route_miles;

			queryRes.next();
			user_id = queryRes.getInt("user_id");
			flight_id = queryRes.getInt("flight_id");
			seat_type = queryRes.getString("class");
			seats = queryRes.getInt("seats");
			miles_used = queryRes.getInt("miles_used");
			total_amount = queryRes.getInt("total_amount");
			route_miles = queryRes.getInt("miles");

			// add back seats
			query = "UPDATE flt_flight SET vacancy_"+seat_type+"=vacancy_"+seat_type+" + "+seats+" WHERE  flight_id="+flight_id+";";
			int queryResInt = stmt.executeUpdate(query);
			System.out.println(query);

			// reclaim added miles
			query = "UPDATE flt_users SET air_miles= air_miles - '"+route_miles+"' WHERE  user_id="+user_id+";";
			queryResInt = stmt.executeUpdate(query);
			System.out.println(query);

			// remove booking entry
			query = "DELETE FROM flt_booking WHERE booking_id="+booking_id+";";
			queryResInt = stmt.executeUpdate(query);			
			System.out.println(query);
			
			retval = true;
			//commit
		}catch(Exception e){
			retval = false;
			System.out.println(e);
		}

		try{
			if(retval){
				ResultSet queryRes = stmt.executeQuery(query_start_commit);
			}else{
				ResultSet queryRes = stmt.executeQuery(query_start_rollback);
			}			
		}catch(Exception e){
			System.out.println(e);
		}
		return retval;
	}

	public int makePayment(int user_id, int flight_id,String seat_type,int seats,int fare_with_miles,int fare_without_miles,int miles_used,int miles_remaining, int miles_earned, String payment_choice,String cc_number, String cc_expiry, String cc_cvv){
		int booking_id = -1;
		try{
			Statement stmt = con.createStatement();
			
			//reduce seat count
			String query = "UPDATE flt_flight SET vacancy_"+seat_type+"=vacancy_"+seat_type+" -"+seats+" WHERE  flight_id="+flight_id+";";
			int queryRes = stmt.executeUpdate(query);
			
			//add entry to booking table
			if(payment_choice.equals("with_miles")){
				query = "INSERT INTO flt_booking (user_id, flight_id, class, seats, miles_used, total_amount,cc_number,cc_expiry,cc_cvv) VALUES ('"+user_id+"', '"+flight_id+"', '"+seat_type+"', '"+seats+"', '"+miles_used+"', '"+fare_with_miles+"' , '"+cc_number+"','"+cc_expiry+"','"+cc_cvv+"' );";
			}else{
				query = "INSERT INTO flt_booking (user_id, flight_id, class, seats, miles_used, total_amount,cc_number,cc_expiry,cc_cvv) VALUES ('"+user_id+"', '"+flight_id+"', '"+seat_type+"', '"+seats+"', '0', '"+fare_without_miles+"' , '"+cc_number+"','"+cc_expiry+"','"+cc_cvv+"');";
			}
			queryRes = stmt.executeUpdate(query);

			// get booking id
			query = "SELECT LAST_INSERT_ID() as booking_id";
			ResultSet qs = stmt.executeQuery(query);
			qs.next();
			booking_id = qs.getInt("booking_id");

			//deduct chosen miles from user's account
			query = "UPDATE flt_users SET air_miles='"+miles_remaining+"' WHERE  user_id="+user_id+";";
			queryRes = stmt.executeUpdate(query);
			
			//add current miles to user's account
			query = "UPDATE flt_users SET air_miles= air_miles + '"+miles_earned+"' WHERE  user_id="+user_id+";";
			queryRes = stmt.executeUpdate(query);			
		}catch(Exception e){
			System.out.println(e);
			return -1;
		}
		
		return booking_id;
		
	}

	public Boolean checkAvailability(int flight_id, String seat_type, int seats){
		Boolean op = null;
		try{
			String query = "select  count(*) as flight_available from flt_flight where flight_id="+flight_id+" and vacancy_"+seat_type+" >= "+seats+";";

			Statement stmt = null;
			ResultSet queryRes = null;

			stmt = con.createStatement();
			queryRes = stmt.executeQuery(query);

			int flight_available = -1;

			queryRes.next();
			
			flight_available = queryRes.getInt("flight_available");

			if(flight_available == 1){
				op = true;
			}else{
				op = false;
			}
		}catch(Exception e){
			System.out.println(e);
			op = false;
		}
		return op;		
	}

	public int[] getFare(int flight_id, String seat_type, int seats, int user_miles){
		int op[] = new int[4];
		
		op[0] = calculateFare_withMiles(flight_id,seat_type,seats,user_miles);
		op[1] = calculateFare_withoutMiles(flight_id,seat_type,seats);
		// miles used
		int miles_remaining = user_miles - (op[1] * 2);
		if(miles_remaining < 0){
			miles_remaining = 0;
		}
		op[2] = miles_remaining;
		op[3] = getMilesEarned(flight_id);

		return op;
	}

	public int getMilesEarned(int flight_id){
		int miles_earned = 0;
		try{
			String query = "select * from flt_flight as t1,flt_route as t2 where t1.route_id = t2.route_id AND flight_id="+flight_id+";";

			Statement stmt = null;
			ResultSet queryRes = null;

			stmt = con.createStatement();
			queryRes = stmt.executeQuery(query);

			queryRes.next();
			miles_earned = queryRes.getInt("miles");
		}catch(Exception e){
			System.out.println(e);
		}
		return miles_earned;
	}

	public int calculateFare_withMiles(int flight_id, String seat_type, int seats, int user_miles){

		int total_price_without_miles = calculateFare_withoutMiles(flight_id, seat_type, seats);

		// int miles = 0;
		int miles_discount = (int)(user_miles * 0.5);
		int final_fare = total_price_without_miles - miles_discount;
		if(final_fare < 0){
			return 0;
		}else{
			return final_fare;
		}
	}

	public int calculateFare_withoutMiles(int flight_id, String seat_type, int seats){
		int total_price = 0;
		try{
			String query = "select * from flt_flight as t1,flt_route as t2 where t1.route_id = t2.route_id AND flight_id="+flight_id+";";

			Statement stmt = null;
			ResultSet queryRes = null;

			stmt = con.createStatement();
			queryRes = stmt.executeQuery(query);

			// int miles = 0;
			int miles_discount = 0;

			int seat_price = 0;

			queryRes.next();
			seat_price = queryRes.getInt("price_"+seat_type);

			total_price = seat_price * seats;			
		}catch(Exception e){
			System.out.println(e);
		}
		
		return total_price;
				
	}

	public String carrierName(int flight_id){
		String retval = "";
		try {
			String query = "select flt_carrier.carrier_name from flt_carrier, flt_flight where flt_flight.carrier_id = flt_carrier.carrier_id AND flt_flight.flight_id ="+flight_id+";";
			Statement stmt = null;
			ResultSet queryRes = null;

			stmt = con.createStatement();
			queryRes = stmt.executeQuery(query);

			queryRes.next();
			retval = queryRes.getString("carrier_name");
			
		}catch(Exception e){
			System.out.println(e);
		}
		
		return retval;
				
	}

	public HashMap<String, String> getBooking(int booking_id){

		HashMap<String, String> booking = new HashMap<String, String>();

		//search for routes	
		Statement stmt = null;
		ResultSet rs = null;

		try{
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM flt_route,flt_flight,flt_booking,flt_carrier,flt_airport WHERE  flt_route.route_id = flt_flight.route_id AND flt_flight.flight_id = flt_booking.flight_id AND (flt_airport.airport_id = flt_route.source_id OR flt_airport.airport_id = flt_route.destination_id) AND (flt_flight.carrier_id = flt_carrier.carrier_id AND flt_flight.flight_type = flt_carrier.flight_type) AND flt_booking.booking_id = "+booking_id+";");

			String source_id = null;
			String source_name = null;
			String destination_id = null;
			String destination_name = null;
			String carrier_id = null;
			String carrier_name = null;
			String seat_type = null;
			String seats = null;
			String total_amount = null;
			
			while(rs.next()){
				source_id = rs.getString("source_id");
				if(source_id.equals(rs.getString("airport_id"))){
					source_name = rs.getString("airport_name");
				}

				destination_id = rs.getString("destination_id");
				if(destination_id.equals(rs.getString("airport_id"))){
					destination_name = rs.getString("airport_name");
				}

				carrier_id = rs.getString("carrier_id");
				carrier_name = rs.getString("carrier_name");
				
				seats = ""+rs.getInt("seats");
				seat_type = rs.getString("class");

				total_amount = ""+rs.getInt("total_amount");
			}


			booking.put("source_id",source_id);
			booking.put("source_name",source_name);
			booking.put("destination_id",destination_id);
			booking.put("destination_name",destination_name);
			booking.put("carrier_id",carrier_id);
			booking.put("carrier_name",carrier_name);
			booking.put("seat_type",seat_type);
			booking.put("seats",seats);
			booking.put("total_amount",total_amount);


			System.out.println("source_id : "+source_id);
			System.out.println("source_name : "+source_name);
			System.out.println("destination_id : "+destination_id);
			System.out.println("destination_name : "+destination_name);
			System.out.println("carrier_id : "+carrier_id);
			System.out.println("carrier_name : "+carrier_name);
			System.out.println("seat_type : "+seat_type);
			System.out.println("seats : "+seats);
			System.out.println("total_amount : "+total_amount);
			//search for all flights of given routes on given date and with required vacancy

		}catch(Exception e){
			System.out.println(e);
		}

		return booking;
		
	}


}