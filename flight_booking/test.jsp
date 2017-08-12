<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.* , FlightPackage.*" %>
<jsp:useBean id="obj" class="FlightPackage.Booking" />

<!-- CODE STARTS HERE -->

<% if(request.getParameter("flight_id") != null && request.getParameter("seat_type") != null && request.getParameter("seats") != null) {
	int flight_id = Integer.parseInt(request.getParameter("flight_id"));
	String seat_type = request.getParameter("seat_type");
	int seats = Integer.parseInt(request.getParameter("seats"));

	Boolean op = obj.checkAvailability(flight_id , seat_type, seats);
	out.println(op.toString())
	if(op)
		out.println("AVAILABLE");
	else
		out.println("NOT AVAILABLE");
	
	}
%>

<!-- CODE ENDS HERE -->