package FlightPackage;

import java.io.*;
import java.sql.*;
import java.util.*;
import com.google.gson.Gson;

public class FlightSearch {

	public FlightSearch(){

	}

	public ArrayList<Flight> searchFlight(String source_airport, String destination_airport, String flight_date, String seat_class, int seats){

		DatabaseConn dbCon = new DatabaseConn();
		Connection con = dbCon.getConnection();

		//search for routes
		
		Statement stmt = null;
		ResultSet queryRes = null;
		ArrayList<Flight> searchedFlights = null;
		try{
			stmt = con.createStatement();
			String query = "";
			switch(seat_class){
				case "eco":{
					query = "select * from flt_route INNER JOIN flt_flight ON flt_route.route_id = flt_flight.route_id where flt_route.source_id = '"+source_airport+"' and flt_route.destination_id = '"+destination_airport+"' AND flight_date = '"+flight_date+"' AND vacancy_eco >= "+seats+";";
					break;
				}
				case "bus":{
					query = "select * from flt_route INNER JOIN flt_flight ON flt_route.route_id = flt_flight.route_id where flt_route.source_id = '"+source_airport+"' and flt_route.destination_id = '"+destination_airport+"' AND flight_date = '"+flight_date+"' AND vacancy_bus >= "+seats+";";
					break;
				}
				case "elt":{
					query = "select * from flt_route INNER JOIN flt_flight ON flt_route.route_id = flt_flight.route_id where flt_route.source_id = '"+source_airport+"' and flt_route.destination_id = '"+destination_airport+"' AND flight_date = '"+flight_date+"' AND vacancy_elt >= "+seats+";";
					break;
				}
				default:{
					break;
				}
			}
			queryRes = stmt.executeQuery(query);
	
			searchedFlights = new ArrayList<Flight>();
	
			while(queryRes.next()){
	
				searchedFlights.add( new Flight(
									queryRes.getString("source_id"),
									queryRes.getString("destination_id"),
									queryRes.getInt("miles"),
									queryRes.getInt("flight_id"),
									queryRes.getString("carrier_id"),
									queryRes.getString("flight_type"),
									queryRes.getInt("route_id"),
									queryRes.getString("flight_date"),
									queryRes.getString("flight_time"),
									queryRes.getInt("vacancy_eco"),
									queryRes.getInt("vacancy_bus"),
									queryRes.getInt("vacancy_elt"),
									queryRes.getInt("price_eco"),
									queryRes.getInt("price_bus"),
									queryRes.getInt("price_elt")
									)
						);
			}
			//search for all flights of given routes on given date and with required vacancy
			dbCon.closeConnection(con);
		
		}catch(Exception e){
			System.out.println("Ya pe Exception" + e);
		}

		return searchedFlights;
	}

	public String searchHelpAjaxHandler(String partial_airport_name){

		DatabaseConn dbCon = new DatabaseConn();
		Connection con = dbCon.getConnection();

		//search for routes
		
		Statement stmt = null;
		ResultSet queryRes = null;
		ArrayList<Flight> searchedFlights = null;

		ArrayList<String> res = null;

		try{
			stmt = con.createStatement();
			String query = "select * from flt_airport WHERE airport_name LIKE '"+partial_airport_name+"%' OR airport_id LIKE '"+partial_airport_name+"%';";
			
			queryRes = stmt.executeQuery(query);

			res = new ArrayList<String>();

			while(queryRes.next()){
				String op_airport_id = queryRes.getString("airport_id");
				String op_airport_name = queryRes.getString("airport_name");

				String op = op_airport_id+" - "+op_airport_name;

				res.add(op);
			}

			//search for all flights of given routes on given date and with required vacancy
			dbCon.closeConnection(con);
		
		}catch(Exception e){
			System.out.println("Ya pe Exception");
		}
		
		// return res;
		String json = new Gson().toJson(res);
		return json;
	}
}
