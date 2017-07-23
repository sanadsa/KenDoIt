<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <title>add task</title>
</head>
<body>
<div data-role="page">
    <div data-role="header" data-theme="b">
        <h1>Add New Task</h1>
    </div><!-- /header -->

    <div id="task"  data-role="main">
        <form action="Router" name="addTask" method="post" id="Router">
            <div>
                <label for="itemName">Name</label>
                <input type="text" id="itemName" name="itemName" value="" placeholder="Task name...">
            </div>
           <div>
               <label for="description">Description</label>
               <input  id="description"  name="description" value="" cols="30" rows="10" placeholder="Add description..">
           </div>

            <button type="button" id="createTaskItem" name="actionTask" value="addTask"
                    onclick="{ document.addTask.flag.value='run';document.addTask.submit();}" class="addBtn">Create</button>
            <button type="button" id="canceledAddTaskItem"
                    name="actionTask" value="addTask"
                    onclick="{ document.addTask.flag.value='canceled'; document.addTask.submit();}" class="addBtn">
                Canceled
            </button>
            <input id="dataPage" type="hidden" name="page" value="addTask">
            <input id="flag" type="hidden" name="flag" value="">
        </form>
    </div>

    <div data-role="footer" data-theme="b">
        <h6 class="mc-text-center">Copyleft Sanad & Melak <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
    </div>
</div><!-- /page -->
</body>
</html>