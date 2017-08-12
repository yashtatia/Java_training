<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.* , FlightPackage.*" %>
<jsp:useBean id="obj" class="FlightPackage.Booking" />

<!-- CODE STARTS HERE -->
<%
	if(session.getAttribute("isLoggedIn") == null) { 
		response.sendRedirect("index.jsp?message=not_logged_in");
	}
%>

<%! int booking_id; %>

<% if(request.getParameter("booking_id") != null) {
	booking_id = Integer.parseInt(request.getParameter("booking_id"));

	Boolean res = obj.cancelBooking(booking_id);
	
	if(res){
		obj.refreshMiles(session);
		response.sendRedirect("myBookings.jsp?message=cancel_booking_success");
	}else{
		response.sendRedirect("myBookings.jsp?message=cancel_booking_failed");
	}
}
%>

<!-- CODE ENDS HERE -->