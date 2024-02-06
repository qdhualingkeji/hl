<link type="text/css" rel="stylesheet" href="css/owl.carousel.css">
<link type="text/css" rel="stylesheet" href="css/owl.theme.css">
<style type="text/css">

#scroll{width:1200px;margin:0 auto;padding-top:30px;font-family:"Microsoft Yahei";}
#scroll .owl-wrapper-outer{margin:0 auto;}
.owl-theme .owl-controls .owl-buttons div{position:absolute;top:30px;width:30px;height:60px;margin:0;padding:0;border-radius:0;font:60px/60px "宋体";background-color:transparent;overflow:hidden;_display:none;}
.owl-theme .owl-controls .owl-buttons .owl-prev{left:-40px;}
.owl-theme .owl-controls .owl-buttons .owl-next{right:-40px;}
.owl-theme .owl-controls .owl-buttons .owl-prev:before{content:"<"; color:#ddd; font-family:serif;}
.owl-theme .owl-controls .owl-buttons .owl-next:before{content:">"; color:#ddd; font-family:serif;}
</style>

<!--<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>-->
<script type="text/javascript" src="js/owl.carousel.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#scroll').owlCarousel({
		items: 6,
		autoPlay: true,
		navigation: true,
		navigationText: ["",""],
		scrollPerPage: true
	});
});
</script>

<!-- #include file="202335103348794.jpg" -->

<div class="scroll-outer">
	<div id="scroll" class="owl-carousel">
<% 
set rshomelogo=server.CreateObject("adodb.recordset")
rshomelogo.Open "select * from homelogo order by id desc ",conn, 1,1
do while not rshomelogo.eof  
%>  
		<div class="item">
			<img src="../upload/<%= rshomelogo("pic1") %>"  title="<%= rshomelogo("note") %>" width="140" height="60" style="border:1px solid #CCC;"/></a>
		</div>
				
<%
rshomelogo.movenext
loop
rshomelogo.close
set rshomelogo=nothing
%>

	</div>
</div>

