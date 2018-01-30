<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    This is my JSP page222. <br>
    
   	<script>
   		console.log(location.href);
   		$.ajax({ 
	        type: "post", 
	       	url: "/weixin/api",
	       	data:{
	       		code:"013YIFKC1Y13b30K7cLC1ruXKC1YIFKP"
	       	}, 
	       	cache:false, 
	       	async:false, 
	        success: function(data){ 
				console.log(data);
	        } 
		});
   	</script>
  </body>
</html>
