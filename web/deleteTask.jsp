<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
            <form action="Router" method="post" name="delete" id="Router">
                <p align="center"><b>Are you sure you want to delete this task?</b></p>
                <p align="center"><b>Name: </b><%=name%></p>
                <!--<label for="itemName" id="itemName" name="itemName"><%=name%></label>-->
                <p align="center"><b>Description: </b><%=des%></p>
                <!--<label id="description"  name="description"><%=des%></label>-->
                <a href="#popupDialog" data-rel="popup" style=" margin: 0 auto; max-width: 100px;" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-shadow ui-btn-center  ui-icon-delete ui-btn-icon-left ui-btn-b">Delete task</a>
                <div data-role="popup" id="popupDialog" data-overlay-theme="b" data-theme="b" data-dismissible="false" style="max-width:400px;">
                        <div data-role="header" data-theme="a">
                        <h1>Delete Page?</h1>
                        </div>
                        <div role="main" class="ui-content">
                            <h3 class="ui-title" style="color: #FA7922">Are you sure you want to delete this item?</h3>
                        <p>This action cannot be undone.</p>
                            <button href="#"  name="actionTask" value="addTask"
                                    onclick="{document.delete.itemName='<%=name%>';document.delete.newDescription='<%=des%>';document.delete.flag.value='canceled';document.delete.submit();}" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back">Cancel</button>
                            <button type="button"  name="actionTask" value="deleteTask"
                                    onclick="{ document.delete.flag.value='run';document.delete.submit();}" href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b" data-rel="back" data-transition="flow">Delete</button>
                        </div>
                </div>

                <input id="dataPage" type="hidden" name="page" value="deleteTask">
                <input id="isDelete" type="hidden" name="isDelete" value="true">
                <input id="taskId" type="hidden" name="deleteId" value="<%=taskId%>">
                <input id="flag" type="hidden" name="flag" value="">
            </form>
        </div><!-- /task -->

        <div data-role="footer" data-theme="b" data-position="fixed">
            <h6 class="mc-text-center">Copyleft Sanad & Melak <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
        </div>

    </div><!-- /page -->

</body>
</html>
