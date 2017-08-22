<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.* , FlightPackage.*" %>
<jsp:useBean id="obj" class="FlightPackage.Booking" />

<!-- CODE STARTS HERE -->

<!-- check login -->

<%! int flight_id; %>
<%! String seat_type; %>
<%! int seats; %>

<% if(request.getParameter("flight_id") != null && request.getParameter("seat_type") != null && request.getParameter("seats") != null) {
	flight_id = Integer.parseInt(request.getParameter("flight_id"));
	seat_type = request.getParameter("seat_type");
	seats = Integer.parseInt(request.getParameter("seats"));
}

	if(session.getAttribute("isLoggedIn") == null) { 
		response.sendRedirect("login.jsp?message=login_before_booking&flight_id="+flight_id+"&seat_type="+seat_type+"&seats="+seats);
	}
%>
<!-- CODE ENDS HERE -->

<jsp:include page="header.jsp" />

<br><br><br><br><br><br>
<h2>Enter passenger details</h2>

<form action="makePayment.jsp" method="POST">
<table class="table">
	<tr>
		<th>Passenger Number</th>
		<th>Passenger Name</th>
	</tr>
	<% for(int i = 0; i < seats; i++) { %>
		<tr>
			<td><%= i+ 1%></td>
			<td><input type="text" name="passenger_<%= i %>"></td>
		</tr>
	<% } %>
</table>
	<input type="hidden" name="flight_id" value="<%= flight_id %>">
	<input type="hidden" name="seat_type" value="<%= seat_type %>">
	<input type="hidden" name="seats" value="<%= seats %>">

	<input type="submit" class="btn btn-primary" name="make_payment_submit" value="Make Payment">
</form>

<jsp:include page="footer.jsp" />
