<%--
  Created by IntelliJ IDEA.
  User: Sanad
  Date: 18/07/2017
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="il.ac.hit.mvcdemo.model.Router" %>
<%@ page import="il.ac.hit.mvcdemo.model.HibernateToDoListDAO" %>
<%@ page import="il.ac.hit.mvcdemo.model.User" %>
<%@ page import="il.ac.hit.mvcdemo.model.Items" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <title>Error</title>
</head>
<body>
<%
    String errorMessage = (String)request.getAttribute("error");
%>
<div data-role="page">
    <div data-role="header">
        <h1>Page Title</h1>
    </div>
    <div data-role="content">
        Page Content
        <div data-role="popup" id="myPopup" data-history="false">
            <p><%=errorMessage%><p>
        </div>
        <script type="text/javascript" language="JavaScript">

            $(document).bind("pageinit", function(){
                $("#myPopup").popup( "open" )
            });
        </script>
    </div>
</div>
</body>
</html>
