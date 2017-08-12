package FlightPackage;

import java.io.*;
import java.sql.*;

public class MyBooking{
int bookingId;
int flightId;
int userId;
//enum fltClass{eco, bus, elt}
private String fltClass;
private int seats;
private int milesUsed;
private String ccNumber;
private String ccExpiry;
private String ccSecurityPin;
private float totalAmount;

public MyBooking(int bookingId, int userId, int flightId, String fltClass,
		int seats, int milesUsed, String ccNumber, String ccExpiry,
		String ccSecurityPin, float totalAmount) {
	super();
	this.bookingId = bookingId;
	this.userId = userId;
	this.flightId = flightId;
	this.fltClass = fltClass;
	this.seats = seats;
	this.milesUsed = milesUsed;
	this.ccNumber = ccNumber;
	this.ccExpiry = ccExpiry;
	this.ccSecurityPin = ccSecurityPin;
	this.totalAmount = totalAmount;
}

	public int getBookingId() {
		return bookingId;
	}
	public int getFlightId() {
		return flightId;
	}
	public int getUserId() {
		return userId;
	}
	public int getSeats() {
		return seats;
	}
	public int getMilesUsed() {
		return milesUsed;
	}
	public String getCcNumber() {
		return ccNumber;
	}
	public String getCcExpiry() {
		return ccExpiry;
	}
	public String getCcSecurityPin() {
		return ccSecurityPin;
	}
	public float getTotalAmount() {
		return totalAmount;
	}
}