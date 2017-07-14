<%@ page import="il.ac.hit.mvcdemo.model.Router" %>
<%@ page import="il.ac.hit.mvcdemo.model.HibernateToDoListDAO" %>
<%@ page import="il.ac.hit.mvcdemo.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <title>update task</title>
</head>
<body>
  <%
      String name=(String)request.getAttribute("name");
      String des=(String)request.getAttribute("desc");
  %>
    <div data-role="page">
        <div data-role="header" data-theme="b">
            <h1>Update Task</h1>
        </div><!-- /header -->

        <div id="task">
            <form action="Router" method="post" name="Router" id="Router">
                <label for="itemName">Name</label>
                <input type="text" id="itemName" name="itemName" value="<%=name%>"  placeholder="Task name...">
                <label for="description">Description</label>
                <input  id="description"  name="description" value="<%=des%>" cols="30" rows="10" placeholder="Add description..">
                <button type="submit" id="createTaskItem"
                        name="actionTask" value="addTask" class="addBtn"
                        onclick="document.Router.isUpdate='true';document.isUpdate.submit();"
                >
                    Update
                </button>
                <input id="dataPage" type="hidden" name="page" value="updateTask">
                <input id="isUpdate" type="hidden" name="isUpdate" value="false">
            </form>
        </div>

        <div data-role="footer" data-theme="b">
            <h6 class="mc-text-center">Copyleft Sanad & Melak <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
        </div>
    </div><!-- /page -->
</body>
</html>
