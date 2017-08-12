<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.* , FlightPackage.*" %>
<jsp:useBean id="obj" class="FlightPackage.Booking" />

<!-- CODE STARTS HERE -->

<%! int flight_id; %>
<%! String seat_type; %>
<%! int seats; %>
<%! int fare[]; %>
<%! int miles_used; %>
<%! int miles_remaining; %>
<%! int user_miles; %>
<%! int miles_earned; %>
<%! int choice; %>

<% if(request.getParameter("flight_id") != null && request.getParameter("seat_type") != null && request.getParameter("seats") != null) {
	flight_id = Integer.parseInt(request.getParameter("flight_id"));
	seat_type = request.getParameter("seat_type");
	seats = Integer.parseInt(request.getParameter("seats"));

	if(session.getAttribute("isLoggedIn") == null) { 
		response.sendRedirect("signup.jsp?message=login_before_booking&flight_id="+flight_id+"&seat_type="+seat_type+"&seats="+seats);
	}

	if(session.getAttribute("air_miles") != null)
		user_miles = Integer.parseInt(session.getAttribute("air_miles").toString());

	fare = obj.getFare(flight_id,seat_type,seats,user_miles);
	miles_remaining = fare[2];
	miles_earned = fare[3];
	miles_used = user_miles - miles_remaining;
}
%>

<!-- CODE STARTS HERE -->

<jsp:include page="header.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="container">
		<div class="well well-lg col-lg-offset-1" style="max-width: 80%;" >
			<h2 align="center">Make Payment</h2>
			<br />



			<p>Carrier : <%= obj.carrierName(flight_id) %></p>
			<p>Total seats : <%= seats %></p>
			<p>Seat Type : 
					<% switch(seat_type){
						case "eco":%> Economy <% break; 
						case "bus":%> Business <% break; 
						case "elt":%> Elite <% break; } %>
				
			</p>
			<form class="form-horizontal" action="processPayment.jsp" method="POST">
				<div class="radio">
				  <label >
				    <input type="radio" name="payment_choice" value="with_miles" checked>
				     Using Miles: <%= miles_used %> : <%= "$"+fare[0] %> CC payment
				     <br>(Miles Remaining : <%= miles_remaining %>)
				  </label>
				</div>
				<div class="radio">
				  <label>
				    <input type="radio" name="payment_choice" value="without_miles">
				    Without Using Miles :	<%= "$"+fare[1] %> CC payment
				  </label>
				</div>
				<br />

				<div class="form-group">
				    <label for="input1" class="col-sm-2 control-label">Name on CC</label>
				    <div class="col-sm-10">
				      <input type="text" name="cc_name" id="cc_name" placeholder="Name on Credit Card" class="form-control" style="max-width: 50%;"required>
				    </div>
				</div>
				<div class="form-group">
				    <label for="input2" class="col-sm-2 control-label">CC Number</label>
				    <div class="col-sm-10">
				      <input type="text" name="cc_number" id="cc_number" placeholder="Credit Card Number" class="form-control" style="max-width: 50%;"required>
				    </div>
				</div>
				<div class="form-group">
				    <label for="input3" class="col-sm-2 control-label">CCV</label>
				    <div class="col-sm-1">
				      <input type="password" name="cc_cvv" id="cc_cvv" placeholder="CVV" class="form-control" style="width: 140%" required>
				    </div>
				
				    <label for="input4" class="col-sm-2 control-label">Expiry</label>
				    <div class="col-sm-2">
				      <input type="text" name="cc_expiry" id="cc_expiry" placeholder="MM/YY" class="form-control" required>
				    </div>
				</div>

				<input type="hidden" name="flight_id" value="<%= flight_id %>">
				<input type="hidden" name="seat_type" value="<%= seat_type %>">
				<input type="hidden" name="seats" value="<%= seats %>">

				<input type="hidden" name="fare_with_miles" value="<%= fare[0] %>">
				<input type="hidden" name="fare_without_miles" value="<%= fare[1] %>">
				<input type="hidden" name="miles_used" value="<%= miles_used %>">
				<input type="hidden" name="miles_remaining" value="<%= miles_remaining %>">
				<input type="hidden" name="miles_earned" value="<%= miles_earned %>">

				<button type="submit" name="" value="Make Payment" class="btn btn-default col-lg-offset-10" >Make Payment</button>
			</form>		
		</div>	
	</div>

<jsp:include page="footer.jsp" />
	<script type="text/javascript">
		$( document ).ready(function() {
		    preProcess();
		});

		function preProcess(){
			if($('input[name=payment_choice]:checked').val() == "with_miles"){
				var cc_remaining = <%= fare[0] %>;
				if(cc_remaining == 0){
					$("#cc_name").prop("disabled", true);
					$("#cc_number").prop("disabled", true);
					$("#cc_cvv").prop("disabled", true);
					$("#cc_expiry").prop("disabled", true);
				}
			}
		}

		$('input[name=payment_choice]').on('change', function() {
			if($('input[name=payment_choice]:checked').val() == "with_miles"){
				var cc_remaining = <%= fare[0] %>;
				if(cc_remaining == 0){
					$("#cc_name").prop("disabled", true);
					$("#cc_number").prop("disabled", true);
					$("#cc_cvv").prop("disabled", true);
					$("#cc_expiry").prop("disabled", true);
				}
			}else{
				$("#cc_name").prop("disabled", false);
				$("#cc_number").prop("disabled", false);
				$("#cc_cvv").prop("disabled", false);
				$("#cc_expiry").prop("disabled", false);
			}
		});
	</script>

