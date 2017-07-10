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
    <div data-role="page">
        <div data-role="header" data-theme="b">
            <h1>Update Task</h1>
        </div><!-- /header -->

        <div id="task">
            <form action="Router" method="post" id="Router">
                <label for="itemName">Name</label>
                <input type="text" id="itemName" name="itemName" value="" placeholder="Task name...">
                <%
                    int id = Integer.parseInt(request.getParameter("taskId"));
                    HibernateToDoListDAO htdl = HibernateToDoListDAO.getInstance();
                    User currentUser = Router.getCurrentUser();
                    String itemName = htdl.getItem(id);
                %>
                <label for="description">Description</label>
                <input  id="description"  name="description" value="" cols="30" rows="10" placeholder="Add description..">
                <button type="submit" id="createTaskItem" name="actionTask" value="addTask" class="addBtn">Create</button>
                <input id="dataPage" type="hidden" name="page" value="addTask">
            </form>
        </div>

        <div data-role="footer" data-theme="b">
            <h6 class="mc-text-center">Copyleft Sanad & Melak <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
        </div>
    </div><!-- /page -->
</body>
</html>
