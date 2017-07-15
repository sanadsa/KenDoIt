<%@ page import="il.ac.hit.mvcdemo.model.Items" %>
<%@ page import="il.ac.hit.mvcdemo.model.HibernateToDoListDAO" %>
<%@ page import="il.ac.hit.mvcdemo.model.User" %>
<%@ page import="javax.jws.soap.SOAPBinding" %>
<%@ page import="il.ac.hit.mvcdemo.model.Router" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
<div data-role="page" id="myDIV"><!-- my div-->
    <div data-role="header" data-theme="b">
        <h1>Just Do It</h1>
        <form action="Router" method="post">
            <button type="submit"  data-role="button" id="button_logout" data-icon="false" data-iconpos="false" class="ui-btn-right">logout</button>
            <input type="hidden" name="page" value="logout" />
        </form>
    </div><!-- /header -->

        <div id="actionMenu" data-role="content">
            <div class="ui-grid-b">
                <div class="ui-block-c">
                <form action="Router" method="post">
                    <button id="addInput"  type="submit" name="addTask" class="action" data-theme="c">Add New Task</button>
                    <input  type="hidden" name="page" value="addTask">
                </form>
                </div>
                <div class="ui-block-c">
                <form action="Router" method="post">
                    <button id="updateInput" type="submit"  name="updateTask" onclick="getSelectedTask()"  class="updateBtn action"  >Update Task</button>
                    <input  type="hidden" name="page" value="updateTask">
                    <input  type="hidden"  name="update" value="" id="taskId">
                </form>
                </div>
                <div class="ui-block-c">
                <form action="Router" method="post">
                    <button id="deleteInput" type="submit" name="deleteTask"   class="deleteBtn action"  >Delete Task</button>
                    <input  type="hidden" name="page" value="deleteTask">
                </form>
                </div>
            </div>
        </div>

    <ul id="myUL" data-role="listview" data-theme="a" data-filter="true">
        <%
            HibernateToDoListDAO htdl = HibernateToDoListDAO.getInstance();
            User currentUser = Router.getCurrentUser();
            Items [] items=htdl.getItems(currentUser);
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
    function getSelectedTask(){
        if(currentSelectedTask!=null && currentSelectedTask!= undefined)
        {
            alert("update=====> ",currentSelectedTask);
            $('#taskId').val(currentSelectedTask);
        }
    }
    $( document ).ready(function() {
        $("li").click(function (e) {
            setAction($(this));
        })
        var k=0;
        $(".page").each(function (i,obj) {
            console.debug("i = "+i);
            if(i!=0){
                this.style.display="none";
            }
        });
    });

    function setAction(element){
        alert.log("element: "+element);
        currentSelectedTask=element.id();
    }

    document.querySelector('body').addEventListener('click', function(event) {
        if (event.target.tagName.toLowerCase() === 'a') {
            toggle(event.target);
        }
    });

    function toggle( Link) {
        console.log("HIIII==========>>>>>>>");
        var listItem=Link.parentNode.parentNode;
        var className=listItem.className;
        var header= listItem.childNodes[0];
        var linker=header.childNodes[0];
        var div=header.nextSibling;
        //if the plus button is not clicked
        if(className.indexOf("ui-collapsible-collapsed")>0){
            console.log("collapse");
            listItem.className="ui-collapsible ui-collapsible-inset ui-corner-all ui-collapsible-themed-content ui-li-static ui-body-inherit ui-last-child";
            header.className="ui-collapsible-heading";
            linker.className="ui-collapsible-heading-toggle ui-btn ui-btn-icon-left ui-btn-inherit ui-icon-minus";
            linker.childNodes[0].innerText="click to collapse contents";
            div.className="ui-collapsible-content ui-body-inherit";
            div.setAttribute("aria-hidden",false);
        }
        else //the plus button clicked and now its a minus button
        {
            console.log("expand");
            listItem.className="ui-collapsible ui-collapsible-inset ui-corner-all ui-collapsible-themed-content ui-li-static ui-body-inherit ui-last-child ui-collapsible-collapsed";
            header.className="ui-collapsible-heading ui-collapsible-heading-collapsed";
            linker.className="ui-collapsible-heading-toggle ui-btn ui-btn-icon-left ui-btn-inherit ui-icon-plus";
            linker.childNodes[0].innerText="click to expand contents";
            div.className="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed";
            div.setAttribute("aria-hidden",true);
        }

    }

    function openDialog() {
        var form=$("#task").fadeIn(2000);
    }

    //the 'x' button to delete a specific item
    var myNodelist = document.getElementsByTagName("LI");
    var i;
    for (i = 0; i < myNodelist.length; i++) {
        var span = document.createElement("SPAN");
        var txt = document.createTextNode("\u00D7");
        span.className = "close";
        span.appendChild(txt);
        myNodelist[i].appendChild(span);
    }

    // Click on a close button to hide the current list item
    var close = document.getElementsByClassName("close");
    var i;
    for (i = 0; i < close.length; i++) {
        close[i].onclick = function() {
            var div = this.parentElement;
            div.style.display = "none";
        }
    }

    // Add a "checked" symbol when clicking on a list item
    var list = document.querySelector('ul');
    list.addEventListener('click', function(ev) {
        if (ev.target.tagName === 'LI') {
            // ev.target.classList.toggle('checked');
        }
    }, false);

    // Create a new list item when clicking on the "Add" button
    function newElement() {
        $("#task").fadeOut(2000);
        var inputValue = document.getElementById("itemName").value;
        var itemValue = document.createTextNode(inputValue);
        var desValue = document.getElementById("description").value;
        var descValue = document.createTextNode(desValue);
        var list = document.getElementById('myUL');
        var li = document.createElement("li");
        li.setAttribute("data-role","collapsible");
        li.className="ui-collapsible member-item ui-collapsible-inset ui-corner-all ui-collapsible-themed-content ui-collapsible-collapsed ui-li-static ui-body-inherit ui-first-child";
        li.setAttribute("href","#");
        console.log(li);
        var titleTask =document.createElement("H1");
        titleTask.className="ui-collapsible-heading ui-collapsible-heading-collapsed";

        var link=document.createElement("a");
        link.setAttribute("href","#");
        link.className="ui-collapsible-heading-toggle ui-btn ui-icon-plus ui-btn-icon-left ui-btn-inherit";
        link.innerText=inputValue;

        var spanTitle=document.createElement("SPAN");
        spanTitle.className="ui-collapsible-heading-status";
        spanTitle.innerText=" click to expand contents";
        var divContent=document.createElement("DIV");
        divContent.className="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed";
        divContent.setAttribute("aria-hidden","true");
        var textArea= document.createElement("P");
        textArea.innerHTML=desValue;
        divContent.appendChild(textArea);
        var txt = document.createTextNode("\u00D7");
        var spanClose=document.createElement("SPAN");
        spanClose.className="close";
        spanClose.innerText=txt;
        link.appendChild(spanTitle);
        titleTask.appendChild(link);
        li.append(titleTask);
        li.appendChild(divContent);

        if (inputValue === '') {
            alert("You must write something!");
        } else if (desValue === ''){
            alert("You must write description!");
        } else {
            list.appendChild(li);
            document.getElementById("itemName").value = "";
            document.getElementById("description").value = "";

            var span = document.createElement("SPAN");
            span.className = "close";
            span.appendChild(txt);
            li.appendChild(span);
            for (i = 0; i < close.length; i++) {
                close[i].onclick = function () {
                    var div = this.parentElement;
                    div.style.display = "none";
                }
            }
//           // $('#myUL').trigger('create');
//            $('#myUL').listview("refresh");
//           // $('#myUL').listview.refresh();
//            $('.member-item').collapsible('refresh');
        }
    }
</script>
</body>
</html>
