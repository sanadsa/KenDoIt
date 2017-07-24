<%@ page import="il.ac.hit.mvcdemo.model.Items" %>
<%@ page import="il.ac.hit.mvcdemo.model.HibernateToDoListDAO" %>
<%@ page import="il.ac.hit.mvcdemo.model.User" %>
<%@ page import="javax.jws.soap.SOAPBinding" %>
<%@ page import="il.ac.hit.mvcdemo.controller.Router" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>task</title>
    <meta name="viewport"  content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body >
<div data-role="page" id="myDIV"><!-- my div-->
    <div data-role="header" data-theme="b">
        <h1>Just Do It</h1>
        <form action="Router" name="logOut" method="get">
            <button type="button"  data-role="button" id="button_logout" data-icon="false"
                    data-iconpos="false" class="ui-btn-right"
                    onclick="{document.logOut.submit();}">logout</button>
            <input type="hidden" name="page" value="logout" />
        </form>
    </div><!-- /header -->

        <div id="actionMenu" data-role="content">
            <div class="ui-grid-b">
                <div class="ui-block-c">
                <form action="Router" method="get">
                    <button id="addInput"  type="submit" name="addTask" class="action" data-theme="c">Add New Task</button>
                    <input  type="hidden" name="page" value="addTask">
                </form>
                </div>
                <div class="ui-block-c">
                <form action="Router" method="get">
                    <button id="updateInput" type="submit"  name="updateTask" onclick="getSelectedTask()"  class="updateBtn action">Update Task</button>
                    <input  type="hidden" name="page" value="updateTask">
                    <input  type="hidden"  name="update" value="" id="taskId">
                </form>
                </div>
                <div class="ui-block-c">
                <form action="Router" method="get">
                    <button id="deleteInput" type="submit" name="deleteTask" onclick="getSelectedTask()" class="deleteBtn action">Delete Task</button>
                    <input  type="hidden" name="page" value="deleteTask">
                    <input  type="hidden" name="delete" value="" id="taskDeleteId">
                </form>
                </div>
            </div>
        </div>

    <ul id="myUL" data-role="listview" data-theme="a" data-filter="true">
        <%
            HibernateToDoListDAO htdl = HibernateToDoListDAO.getInstance();
            User currentUser = Router.getCurrentUser();
            Items [] items=htdl.getItems(currentUser) ;
            for(int i=0; i<items.length; i++)
            {
        %>
        <li data-role="collapsible" id="<%= items[i].getId()%>">
            <h1><%= (String)items[i].getItemName() %></h1>
            <p><%= (String)items[i].getDescription() %></p>
        </li>
        <%
            }
        %>
    </ul>

    <div data-role="footer" data-theme="b">
        <h6 class="mc-text-center">Copyleft SanadS & MelakF <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
    </div>
</div><!-- my div-->


<script>
    var currentSelectedTask;

    $( document ).ready(function() {

    });

    // when task is clicked (for update or delete) change the li color to blue
    $('li').click(function(){
        setAction($(this)[0]);
        if ($(this).css('background-color') === 'rgba(0, 0, 0, 0)') {
            $(this).css('background-color', 'rgb(23, 150, 207)');
        } else {
            $(this).css('background-color', 'rgba(0, 0, 0, 0)');
        }
        for(var i=0;i<$('li').length;i++){
            if($('li')[i]!=$(this)[0])
                $($('li')[i]).css('background-color', 'rgba(0, 0, 0, 0)');
        }
    });

    // get the clicked task (for update or delete)
    function getSelectedTask(){
        if(currentSelectedTask!=null && currentSelectedTask!= undefined)
        {
            console.log('update =====> '+currentSelectedTask);
            $('#taskId').val(currentSelectedTask);
            $('#taskDeleteId').val(currentSelectedTask);
        }
    };

    function setAction(element){
        currentSelectedTask = element.id;
    };

    function openDialog() {
        var form=$('#task').fadeIn(2000);
    }
</script>
</body>
</html>
