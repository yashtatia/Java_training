package Bean;

import java.io.*;
import java.sql.*;

public class MyBooking{
int bookingId;
int flightId;
int userId;
//enum fltClass{eco, bus, elt}
String fltClass;
int seats;
int milesUsed;
String ccNumber;
String ccExpiry;
String ccSecurityPin;
float totalAmount;


public MyBooking(){
}

public MyBooking(int bookingId, int userId, int flightId, String fltClass,
		int seats, int milesUsed, String ccNumber, String ccExpiry,
		String ccSecurityPin, float totalAmount) {

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
public void setBookingId(int bookingId) {
	this.bookingId = bookingId;
}
public int getFlightId() {
	return flightId;
}
public void setFlightId(int flightId) {
	this.flightId = flightId;
}
public int getUserId() {
	return userId;
}
public void setUserId(int userId) {
	this.userId = userId;
}
public int getSeats() {
	return seats;
}
public void setSeats(int seats) {
	this.seats = seats;
}
public int getMilesUsed() {
	return milesUsed;
}
public void setMilesUsed(int milesUsed) {
	this.milesUsed = milesUsed;
}
public String getCcNumber() {
	return ccNumber;
}
public void setCcNumber(String ccNumber) {
	this.ccNumber = ccNumber;
}
public String getCcExpiry() {
	return ccExpiry;
}
public void setCcExpiry(String ccExpiry) {
	this.ccExpiry = ccExpiry;
}
public String getCcSecurityPin() {
	return ccSecurityPin;
}
public void setCcSecurityPin(String ccSecurityPin) {
	this.ccSecurityPin = ccSecurityPin;
}
public float getTotalAmount() {
	return totalAmount;
}
public void setTotalAmount(float totalAmount) {
	this.totalAmount = totalAmount;
}

public String getFltClass(){
	return fltClass;
}

}