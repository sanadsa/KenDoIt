<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <title>delete task</title>
</head>
<body>
<%
    String name = (String)request.getAttribute("taskName");
    String des = (String)request.getAttribute("description");
    String taskId = (String)request.getAttribute("taskId");
%>
    <div data-role="page">
        <div data-role="header" data-theme="b">
            <h1>Delete Task</h1>
        </div><!-- /header -->

        <div id="task">
            <form action="Router" method="post" name="Router" id="Router">
                <label for="itemName">Name</label>
                <label for="itemName" id="itemName" name="itemName"><%=name%></label>
                <label for="description">Description</label>
                <label id="description"  name="description"><%=des%></label>
                <button type="submit" id="deleteItem" name="actionTask" value="deleteTask" class="addBtn">Delete</button>
                <input id="dataPage" type="hidden" name="page" value="deleteTask">
                <input id="isDelete" type="hidden" name="isDelete" value="true">
                <input id="taskId" type="hidden" name="deleteId" value="<%=taskId%>">
            </form>
        </div><!-- /task -->

        <div data-role="footer" data-theme="b">
            <h6 class="mc-text-center">Copyleft Sanad & Melak <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
        </div>
    </div><!-- /page -->
</body>
</html>
