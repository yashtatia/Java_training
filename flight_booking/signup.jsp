<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.* , FlightPackage.*" %>
<jsp:useBean id="obj" class="FlightPackage.User" />

<%! int flight_id; %>
<%! String seat_type; %>
<%! int seats; %>
<%! Boolean isRedirected; %>

<%
    if(request.getParameter("flight_id") != null && request.getParameter("seat_type") != null && request.getParameter("seats") != null){
        flight_id = Integer.parseInt(request.getParameter("flight_id"));
        seat_type = request.getParameter("seat_type");
        seats = Integer.parseInt(request.getParameter("seats"));    
        isRedirected = true;
    }else{
        isRedirected = false;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<title>Search Flights</title>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="assets/css/jquery-ui.css">
	<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
        .alert{
            margin-top:100px;
        }
    </style>
</head>
<body>
<% if(request.getParameter("message") != null && request.getParameter("message").toString().equals("login_before_booking")) { %>
    <div class="alert alert-warning">
        <strong>Hi!</strong> Please login before you continue booking your ticket.
    </div>
<% } %>
<div class="row" style="margin-top:100px;">
    <div class="col-lg-4 col-lg-offset-4">
        <h3>Log In</h3>
        <% if(isRedirected){ %>
        <form class="form-horizontal" action="doLogin.jsp?flight_id=<%=flight_id%>&seat_type=<%=seat_type%>&seats=<%=seats%>" method="POST">
        <% } else { %>
        <form class="form-horizontal" action="doLogin.jsp" method="POST">
        <% } %>
            <div class="form-group">
                <label class="sr-only" for="InputEmail">Email address</label>
                <input type="email" class="form-control" id="Email" placeholder="Email" name="email">
            </div>
            <div class="form-group">   
                <label class="sr-only" for="Password">Password</label>
                <input type="password" class="form-control" id="Password" placeholder="Password" name="password">
            </div>
            <button type="submit" class="btn btn-default btn-info">Log in</button>
            <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Cancel</button>
        </form>
    </div>

    <div class="col-lg-4 col-lg-offset-4" style="margin-top:40px;">
    <h3>Sign Up</h3>
        <form class="form-horizontal" action="doSignup.jsp" method="POST" id="signUpForm">
            <div class="form-group">
                <label class="sr-only" for="InputEmail">Email address</label>
                <input type="email" class="form-control" id="Email" placeholder="Email" name="email" required>
            </div>
            <div class="form-group">   
                <label class="sr-only" for="Password">Password</label>
                <input type="password" class="form-control" id="Password" placeholder="Password" name="password" required>
            </div>
            <div class="form-group">
                <label class="sr-only" for="InputEmail">Contact</label>
                <input type="text" class="form-control" id="contact" placeholder="contact" name="contact">
            </div>
            <div class="form-group">
                <label class="sr-only" for="InputEmail">First name</label>
                <input type="text" class="form-control" id="fname" placeholder="fname" name="fname" required>
            </div>
            <div class="form-group">
                <label class="sr-only" for="InputEmail">Last name</label>
                <input type="text" class="form-control" id="lname" placeholder="lname" name="lname" required>
            </div>
            <div class="form-group">
                <label class="sr-only" for="InputEmail">Billing Address</label>
                <input type="text" class="form-control" id="billing_address" placeholder="billing_address" name="billing_address" required>
            </div>

            
            <button type="submit" class="btn btn-default btn-info">Sign Up</button>
            <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Cancel</button>
        </form>
    </div>
</div>
    

  

<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="assets/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>
</html>