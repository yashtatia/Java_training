
	<footer class="row-footer">
        <div class="container">
            <div class="row">             
                
                <div class="col-xs-6 col-sm-5" style="padding-left:100px;">
                    <address>
		              Whitefield<br>
		              Bengaluru<br>
		              <i class="fa fa-envelope"></i>: 
                         <a href="mailto:flights@sap.net">
                         flights@sap.net</a>
                    </address>
                </div>
                <div class="col-xs-12 col-sm-4 pull-right">
                    <div class="nav navbar-nav" style="padding: 40px 10px;">
                        <a class="btn btn-social-icon btn-google-plus" href="http://google.com/+"><i class="fa fa-google-plus"></i></a>
                        <a class="btn btn-social-icon btn-facebook" href="http://www.facebook.com/profile.php?id="><i class="fa fa-facebook"></i></a>
                        <a class="btn btn-social-icon btn-linkedin" href="http://www.linkedin.com/in/"><i class="fa fa-linkedin"></i></a>
                        <a class="btn btn-social-icon btn-twitter" href="http://twitter.com/"><i class="fa fa-twitter"></i></a>
                        <a class="btn btn-social-icon btn-youtube" href="http://youtube.com/"><i class="fa fa-youtube"></i></a>
                        <a class="btn btn-social-icon" href="mailto:"><i class="fa fa-envelope-o"></i></a>
                    </div>
                </div>
                <div class="col-xs-12">
                    <p style="padding:10px;"></p>
                    <p align=center>© Copyright 2017 SAP Flights</p>
                </div>
            </div>
        </div>
    </footer>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="assets/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
$( function() {
	console.log( "document Ready!" );

	// $('#source_id').autocomplete("flightSearchHelpAjax.jsp");
	// $(this.target).find('source_id').autocomplete({
	$('#source_id').autocomplete({
		source:"flightSearchHelpAjax.jsp",
		minLength: 2
		// select: function( event, ui ) {
		// 	console.log( "Selected: " + ui.item.value + " aka " + ui.item.id );
		// }
	});
	$('#destination_id').autocomplete({
		source:"flightSearchHelpAjax.jsp",
		minLength: 2
		// select: function( event, ui ) {
		// 	console.log( "Selected: " + ui.item.value + " aka " + ui.item.id );
		// }
	});

});
</script>
<script>
        $().button('toggle');
        $(document).ready(function(){
            $("#login").click(function(){
                console.log("yo!");
                $("#loginModal").modal();
            });
        });
        
        $(document).ready(function(){
            $("#table").click(function(){
                $("#tableModal").modal();
            });
        });
</script>
</body>
</html>