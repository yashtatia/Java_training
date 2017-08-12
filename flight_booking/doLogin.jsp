<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.* , FlightPackage.*" %>
<jsp:useBean id="obj" class="FlightPackage.User" />

<%! int flight_id; %>
<%! String seat_type; %>
<%! int seats; %>
<%! Boolean isRedirected; %>

<%
	if( request.getParameter("flight_id")!= null && request.getParameter("seat_type") != null && request.getParameter("seats") != null){
	    flight_id = Integer.parseInt(request.getParameter("flight_id"));
	    seat_type = request.getParameter("seat_type");
	    seats = Integer.parseInt(request.getParameter("seats"));	
	    isRedirected = true;

	    out.println(flight_id);
	    out.println(seat_type);
	    out.println(seats);
	}else{
		isRedirected =false;
	}
%>

<% if(request.getParameter("email") != null && request.getParameter("password") != null) {
	if(obj.login(request.getParameter("email"),request.getParameter("password"),session)){
		if(isRedirected){
    		response.sendRedirect("makePayment.jsp?flight_id="+flight_id+"&seat_type="+seat_type+"&seats="+seats);
		}else{
			response.sendRedirect("index.jsp?message=login_success");		
		}
	}else{
		response.sendRedirect("index.jsp?message=login_failed");
	}
}else{
	response.sendRedirect("index.jsp");
}
%>