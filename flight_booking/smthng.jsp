<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="obj" class="FlightPackage.FlightSearch" />
<%@page import="java.util.* , FlightPackage.*" %>

<!-- CODE STARTS HERE -->

<%! ArrayList<Flight> flightList = new ArrayList<Flight>(); %>


<!-- CODE ENDS HERE -->

	<jsp:include page="header.jsp" />


	<div class="container" style="margin-top:150px;">
		<div class="well well-lg" >
			<form method="GET">
				<div class="form-group row">
					<div class="col-lg-5">
						<input class="input-large form-control" type="text" placeholder="From: City or Airport" name="source_id" id="source_id" value="<%= (request.getParameter("source_id") != null)? request.getParameter("source_id"):"" %>" required>
					</div>
					<div class="col-lg-2" align="center"><span class="glyphicon glyphicon-arrow-right"></span></div>
					
					<div class="col-lg-5">
						<input class="input-large form-control" type="text" placeholder="To: City or Airport" name="destination_id" id="destination_id" value="<%= (request.getParameter("destination_id") != null)? request.getParameter("destination_id"):"" %>" required>
					</div>
				</div>
				
				<div class="form-group row">
					<div class="col-lg-5">
						<input class="input-large form-control" type="date" name="flight_date" data-date-inline-picker="true" value="<%= (request.getParameter("flight_date") != null)? request.getParameter("flight_date"):"" %>" required>
					</div>

					<div class="col-lg-5 col-lg-offset-2">
						<div class="col-lg-6 form-group">
							<select class="custom-select mb-2 mr-sm-2 mb-sm-0 form-control" name="seat_type">
								<!-- <option data-hidden="true">Class</option> -->
								<option selected value="eco">Economy</option>
								<option value="bus">Business</option>
								<option value="elt">Elite</option>
							</select>
						</div>
						<div class="col-lg-6">
							<input class="input-large form-control" type="number" name="seats" data-date-inline-picker="true" placeholder="Seats" value="<%= (request.getParameter("seats") != null)? request.getParameter("seats"):"1" %>" required>
						</div>
							
					</div>
				</div>
				<div class="form-group row">
					<div class="col-lg-12">
						<button type="submit" class="btn btn-large btn-block btn-primary" name="flightSearchFormSubmit" value="SEARCH">Lets Go!!!</button>	
					</div>
				</div>
			</form>
		</div>
		</div>
		<div class="" style="max-width:70%;padding-left:180px;">
		<div class="row row-content">
			<% if(request.getParameter("source_id") != null && request.getParameter("destination_id") != null && request.getParameter("flight_date") != null && request.getParameter("seat_type") != null && request.getParameter("seats") != null) { %>
				<table class="table table-bordered table-hover">
				<tr>
					<th>Source_id</th>
					<th>Destination_id</th>
					<th>Miles</th>
					<th>Flight_id</th>
					<th>Carrier_id</th>
					<th>Flight_type</th>
					<th>Route_id</th>
					<th>Flight_date</th>
					<th>Flight_time</th>
					<th>Vacancy_eco</th>
					<th>Vacancy_bus</th>
					<th>Vacancy_elt</th>
					<th>Price_eco</th>
					<th>Price_bus</th>
					<th>Price_elt</th>
					<th>Book</th>
				</tr>
				<%
					for( Flight flt : flightList){
						%>
						<tr>
						<td> <%= flt.getSource_id() %> </td>
						<td> <%= flt.getDestination_id() %> </td>
						<td> <%= flt.getMiles() %> </td>
						<td> <%= flt.getFlight_id() %> </td>
						<td> <%= flt.getCarrier_id() %> </td>
						<td> <%= flt.getFlight_type() %> </td>
						<td> <%= flt.getRoute_id() %> </td>
						<td> <%= flt.getFlight_date() %> </td>
						<td> <%= flt.getFlight_time() %> </td>
						<td> <%= flt.getVacancy_eco() %> </td>
						<td> <%= flt.getVacancy_bus() %> </td>
						<td> <%= flt.getVacancy_elt() %> </td>
						<td> <%= flt.getPrice_eco() %> </td>
						<td> <%= flt.getPrice_bus() %> </td>
						<td> <%= flt.getPrice_elt() %> </td>
						<!-- <td> <a href="bookFlight.jsp?flight_id=<%=flt.getFlight_id()%>&flight_date=<%=flt.getFlight_date()%>&seat_type=<%=request.getParameter("seat_type")%>&seats=<%=request.getParameter("seats")%>" class="btn btn-large btn-primary">Book Now</a> </td> -->
						<td> <a href="makePayment.jsp?flight_id=<%=flt.getFlight_id()%>&seat_type=<%=request.getParameter("seat_type")%>&seats=<%=request.getParameter("seats")%>" class="btn btn-large btn-primary">Book Now</a> </td>
						</tr>
						<%
					}
				%>
				</table>
			<% } %>
		</div>



		
	</div>

	<jsp:include page="footer.jsp" />