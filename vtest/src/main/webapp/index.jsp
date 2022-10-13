<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript"
	src="https://apis.google.com/js/platform.js"></script>
<style type="text/css">
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" href="css/cloud3.css">

<title>WLS on Oracle Cloud - Runtime Environment Details</title>

</head>
<body>
	<div id="fb-root"></div>
	<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
	<header class="navbar-fixed-top">
		<hgroup class="container">
			<div class="cloudLogo columns img-center-align">
				<a href='http://cloud.oracle.com' target="_blank"></a>
			</div>
		</hgroup>
	</header>

	<div class="blueBanner">
		<div class="container">

			<div class="blueBannerLogo img-center-align">
				<a href='http://cloud.oracle.com' target="_blank">
					<img src='images/oracle-cloud-logo.png' alt="Oracle Cloud Infrastructure" />
				</a>
			</div>

			<div class="blueBannerHeading">
				<h1 class="blueBannerTitleWithSubtitle">
					<a href='https://www.oracle.com/cloud/' style="color: #ffffff">Dobar Dan HROUG</a>
				</h1>
				<h2 class="blueBannerSubTitle">Easy, rapid and agile deployment
					of any application.</h2>
				<h2 class="blueBannerSubTitle">Experience full control and
					flexibility of your application in public cloud.</h2>
			</div>

			<div class="blueBannerButton"></div>
		</div>
	</div>

	<div class="offerNavBarLayout categoryNavBarLayout">
		<div class="tab-background-nopadding">
			<div class="container">
				<ul>
					<li class='current'><a class='CatOverviewTab current'
						href='https://verrazzano.io/latest/'> Verrazzano Enterprise Container Platform </a>
					</li>
					<li class='current'><a class='CatOverviewTab current'
						href="https://www.oracle.com/cloud/why-oci/" target="_blank"  style="color:#333;text-decoration:none">Why Customers are Choosing OCI</a>
					</li>	
					<!-- TODO: add links to Weblogic on OCI Doc -->
				</ul>
			</div>
		</div>
	</div>

	<div class="container serviceContainer">
		<div class="overviewLayout">
			<div class="whyOracleVideoSection">



				<div class='overviewDemoSection'>


					<div class="whyOracleListing">
						<div class="whyOracleListingLayout">
							<h3>
								<span style="color: #333; text-decoration: none">Environment
									Variables</span>
							</h3>
							<table>
								<tr>
									<th style="text-align: left">Name</th>
									<th style="text-align: left">Value</th>
								</tr>
								<%
									TreeMap<String, String> sortedMap = new TreeMap<String, String>();
									sortedMap.putAll(System.getenv());
								    for (Map.Entry<String, String> f : sortedMap.entrySet()) {
									  out.println("<tr><td>");
								      out.println(f.getKey());
								      out.println("</td><td>");
								      out.println(f.getValue());
								      out.println("</td></tr>");
								    }
								%>

							</table>

						</div>
					</div>


					<div class="videoShadow"></div>
				</div>


			</div>
		</div>



	</div>


	<footer>
		<div class="opcGlobalFooter">
			<div class="container">
				<div class="footerLeft columns">
					<ul>
						<li><a href='http://www.oracle.com/corporate/index.html'
							target="_blank">About Oracle</a></li>
						<li><a
							href='https://www.oracle.com/corporate/contact/'
							target="_blank">Contact Us</a></li>
						<li><a href='https://www.oracle.com/events/'
							target="_blank">Events</a></li>
						<li><a href='https://www.oracle.com/news/'
							target="_blank">News</a></li>
						<li><a
							href='https://blogs.oracle.com/'
							target="_blank">Blogs</a></li>
					</ul>



					<p>Copyright &copy; 2022 Oracle and/or its affiliates.
						All rights reserved.</p>

				</div>

			</div>
		</div>
	</footer>
</body>
</html>
