<%--
  Created by IntelliJ IDEA.
  User: Sanad
  Date: 18/07/2017
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="il.ac.hit.mvcdemo.controller.Router" %>
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
    <div data-role="header" data-theme="a">
        <h1>Error</h1>
    </div>
    <div data-role="content">
        <p><b>Error description:</b></p>
        <%if (errorMessage==null||errorMessage.equals("")||errorMessage == "null") {
            errorMessage = "something went wrong, try again in a few seconds";
        %><p align="center"><b><%=errorMessage%></b><p><%
        } else {%>
        <p align="center"><%=errorMessage%><p>
        <%}%>
    </div>
    <div data-role="footer" data-theme="a">
        <h6 class="mc-text-center">Copyleft Sanad & Melak <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
    </div>
</div>
</body>
</html>
