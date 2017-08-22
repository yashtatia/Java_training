<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.* , FlightPackage.*" %>
<jsp:useBean id="obj" class="FlightPackage.Booking" />

<!-- CODE STARTS HERE -->

<%
	if(session.getAttribute("isLoggedIn") == null) { 
		response.sendRedirect("index.jsp?message=not_logged_in");
	}
%>

<%! int user_id; %>
<%! int flight_id; %>
<%! int booking_id; %>
<%! String seat_type; %>
<%! int seats; %>
<%! int fare_with_miles; %>
<%! int fare_without_miles; %>
<%! int miles_used; %>
<%! int miles_remaining; %>
<%! int miles_earned; %>
<%! String payment_choice; %>
<%! String cc_number; %>
<%! String cc_expiry; %>
<%! String cc_cvv; %>
<%! String url; %>
<%! HashMap<String, String> booking; %>

<jsp:include page="header.jsp" />

<style type="text/css">
</style>

<% if(request.getParameter("flight_id") != null && request.getParameter("seat_type") != null && request.getParameter("seats") != null) {
	flight_id = Integer.parseInt(request.getParameter("flight_id"));
	seat_type = request.getParameter("seat_type");
	seats = Integer.parseInt(request.getParameter("seats"));
	fare_with_miles = Integer.parseInt(request.getParameter("fare_with_miles"));
	fare_without_miles = Integer.parseInt(request.getParameter("fare_without_miles"));
	miles_used = Integer.parseInt(request.getParameter("miles_used"));
	miles_remaining = Integer.parseInt(request.getParameter("miles_remaining"));
	miles_earned = Integer.parseInt(request.getParameter("miles_earned"));
	payment_choice = request.getParameter("payment_choice");
	cc_number = request.getParameter("cc_number");
	cc_expiry = request.getParameter("cc_expiry");
	cc_cvv = request.getParameter("cc_cvv");

	user_id = Integer.parseInt(session.getAttribute("user_id").toString());

	booking_id = obj.bookFlight(user_id,flight_id,seat_type,seats,fare_with_miles,fare_without_miles,miles_used,miles_remaining,miles_earned,payment_choice,cc_number,cc_expiry,cc_cvv);

	if(booking_id != -1){
		obj.refreshMiles(session);
		//response.sendRedirect("bookingStatus.jsp?"+url+"&message=booking_success");

		booking = obj.getBooking(booking_id);
		String source_id = booking.get("source_id");
		String source_name = booking.get("source_name");
		String destination_id = booking.get("destination_id");
		String destination_name = booking.get("destination_name");
		String carrier_id = booking.get("carrier_id");
		String carrier_name = booking.get("carrier_name");
		String seat_type = booking.get("seat_type");
		String seats = booking.get("seats");
		String total_amount = booking.get("total_amount");

		//show itenerary
		%>
			<div class="row" style="margin-top:140px;">
				<div class="col-lg-8 col-lg-offset-2">
					<h2><strong>Ticket Itenerary</strong></h2>
					<table class="table">
						<tr>
							<td colspan="2">
								Flight : <%= source_id+" - "+source_name %> <i class="fa fa-plane" aria-hidden="true"></i> <%= destination_id+" - "+destination_name %>
							</td>
							<td colspan="2">
								<%= session.getAttribute("fname") +" - "+ session.getAttribute("lname") %>
							</td>
						</tr>
						<tr>
							<td>
								Booking ID : <%= booking_id %>
								Carrier : <%= carrier_id+" - "+carrier_name %>
							</td>
							<td>
								<%= source_id+" - "+source_name %>
							</td>
							<td><i class="fa fa-plane" aria-hidden="true" style="font-size: 20px;"></i></td>
							<td>
								<%= destination_id+" - "+destination_name %>
							</td>
						</tr>
						<tr>
							<td>Seat Type : <%= (seat_type.equals("eco"))?"Economy":(seat_type.equals("bus")?"Business":"Elite") %></td>
							<td>Seats Booked : <%= seats %></td>
							<td>Seat Numbers : E3,G2,A5</td>
							<td>Total Fare : $2930</td>
						</tr>
						<tr>
							<td colspan="4">
								<button class="btn btn-primary" onclick="window.print()">Print Ticket</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
		<%

	}else{
		response.sendRedirect("index.jsp?"+url+"&message=booking_failure");
	}
}
%>

<!-- CODE ENDS HERE -->

<jsp:include page="footer.jsp" />