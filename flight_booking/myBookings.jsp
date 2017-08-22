<%@page import="javax.servlet.http.*,java.util.*,Bean.*" %>
<jsp:useBean id = "test" class = "Bean.User"/>
<HTML>
<HEAD>
My Booking
</HEAD>
<STYLE>
.header h1 {
            margin-top: 50;
            text-align: center;
            height: 100px;
            width: 100%;
        }
#qw {
	color: white;
    padding: 14px 25px;
    text-align: center; 
    text-decoration: none;
    display: inline-block;
}
		
a:hover, a:active {
    background-color: red;
}
</STYLE>
<BODY>

<%! ArrayList<Booking> bookedFlights = new ArrayList<Booking> () ; %>
<%
	if(session.getAttribute("isLoggedIn") == null) {
		response.sendRedirect("index.jsp?message=not_logged_in");
	}else{
		//response.sendRedirect("index.jsp?message=error");
		bookedFlights = test.getUserBookings(session);
	}
%>

<% 

//session.setAttribute("userName","c.sritej@gmail.com");

%>

<jsp:include page = "header.jsp"/>
<style type="text/css">
	table tr th, table tr td{
		text-align: center;
	}
</style>
<div style="margin-top:150px;">
	
</div>

				<%
				  if(bookedFlights.size()!=0)
				  {
				%>
				<table class="table table-bordered table-hover" style="width:90%;margin:0px auto 100px auto;position:relative;">
				<tr>
					<th>Booking Id</th>
					<th>Carrier Name</th>
					<th>Source</th>
					<th>Destination</th>
					<th>Class</th>
					<th>Total seats</th>
					<th>Date</th>
					<th>Time</th>
					<th>Cancel</br>Booking</th>
				</tr>
				<%  
					for( int i=0;i<bookedFlights.size();i++){
						%>
						<tr>
						<td> <%= bookedFlights.get(i).getBookingId() %> </td>
						<td> <%= bookedFlights.get(i).getCarrierName() %> </td>
						<td> <%= bookedFlights.get(i).getSource() %> </td>
						<td> <%= bookedFlights.get(i).getDestination() %> </td>
						<td> <%= (bookedFlights.get(i).getTypeClass().equals("eco"))?("Economy"):(bookedFlights.get(i).getTypeClass().equals("bus")?"Business":"Elite") %> </td>
						<td> <%= bookedFlights.get(i).getTotalSeats() %> </td>
						<td> <%= bookedFlights.get(i).getDate() %> </td>
						<td> <% if( Integer.parseInt(bookedFlights.get(i).getTime().substring(0,2)) >= 12 ){
								out.write((Integer.parseInt(bookedFlights.get(i).getTime().substring(0,2))-12)+bookedFlights.get(i).getTime().substring(2,5));
								%>PM<%
							} else { 
								out.write(bookedFlights.get(i).getTime().substring(0,5));
							%>AM <% } %>
						</td>
						<td> <a href="cancelBooking.jsp?booking_id=<%=bookedFlights.get(i).getBookingId()%>" class="btn btn-large btn-primary">Cancel</a> 
						</td>
						
						</tr>
						<%
				  }
				  %>
				  </table>
				  <%
				  }
				  else {
				%>
				<div class="header">
				<h1>No Bookings</h1>
				
				</div>
				<div class="container" style="max-height: 300px;">
					<div class="row row-content">
					<div class="col-lg-offset-5">
						<a href="index.jsp" class="btn btn-large btn-primary" id="qw">Book flight</a>
					</div>
					
				</div>
				</div>
				
				<br />
				<br />
				<br />
				<br />
				<br />
				<br /><br /><br /><br /><br /><br />

				
				<%
				  }
				  %>
				  
				
<jsp:include page = "footer.jsp"/>
		
</BODY>
</HTML>