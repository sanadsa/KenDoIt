<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <title>ToDoList</title>
</head>
<body>
<div data-role="page" id="signUpPage">
    <div data-role="header" data-theme="b">
        <form action="Router" name="signUpHome" method="post">
            <button data-role="button" data-icon="home" data-iconpos="left"
                    onclick="{document.signUpHome.submit();}">Home</button>
            <input id="back" type="hidden" name="page" value="main">
        </form>
    </div>
        <h1>Just Do It</h1>
    <form id="Router" name="signUp" action="Router" method="post">
        <div role="main" class="ui-content">
            <h3>Sign Up</h3>
            <label for="txt-first-name">First Name</label>
            <input type="text" name="txt-first-name" id="txt-first-name" value="">
            <label for="txt-last-name">Last Name</label>
            <input type="text" name="txt-last-name" id="txt-last-name" value="">
            <label for="txt-email">Email Address</label>
            <input type="email" name="txt-email" id="txt-email" value="">
            <label for="txt-password">Password</label>
            <input type="password" name="txt-password" id="txt-password" value="">
            <label for="txt-password-confirm">Confirm Password</label>
            <input type="password" name="txt-password-confirm" id="txt-password-confirm" value="">
            <button type="button"  data-rel="popup" data-transition="pop" data-position-to="window"
                    id="btn-submit" class="ui-btn ui-btn-b ui-corner-all mc-top-margin-1-5"
                    onclick="{document.signUp.submit();}">Submit</button>
            <%
                if(request.getAttribute("isRegister") != null){
            %>
            <div  id="dlg-sign-up-sent" class="ui-popup ui-body-inherit ui-overlay-shadow"  data-dismissible="false"
                style="max-width:400px;position: absolute;height: 33%;width: 400px;margin: -135px 0 0 -200px;top: 50%;left: 50%;">
                <div data-role="header" role="banner" class="ui-header ui-bar-inherit">
                    <h1 class="ui-title">Almost done...</h1>
                </div>
                <div role="main" class="ui-content">
                    <h3 style="color: blue">congratulations you have successfully registered</h3>
                    <p>Let's go and create a Weekly Attack Plan.</p>
                    <div class="mc-text-center"><button id="popupSuccessBtn" type="button"  class="ui-btn ui-corner-all ui-shadow ui-btn-b mc-top-margin-1-5">OK</button></div>
                </div>
            </div>
            <%
                }
            %>

            <%
                if(request.getAttribute("signUpResult") != null){
                    String message=(String)request.getAttribute("message");
                    String title=(String)request.getAttribute("title");
            %>
            <div  id="dlg-invalid-inputs"  class="pop ui-popup ui-body-inherit ui-overlay-shadow ui-corner-all" data-dismissible="false"
                  style="max-width:400px;position: absolute;height: 200px;width: 400px;margin: -135px 0 0 -200px;top: 50%;left: 50%;">
                <div role="main" class="ui-content">
                    <h3 class="mc-text-danger" style="color:red"><%=title%></h3>
                    <p><%=message%> </p>
                    <div class="mc-text-center"><button id="popupOkBtn" href="#"  onclick="{$('#dlg-invalid-inputs').popup('close')}"  class="ui-btn ui-corner-all ui-shadow ui-btn-b mc-top-margin-1-5">OK</button></div>
                </div>
            </div>
            <%
                }
            %>
        </div><!-- /content -->
        <input id="dataPage" type="hidden" name="page" value="signUp">
        <input id="registerSuccess" type="hidden" name="registerSuccess" value="">
    </form>
    <div data-role="footer" data-theme="b">
        <h6 class="mc-text-center">Copyleft Sanad & Melak <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
    </div>
    <%
        String alert = (String)request.getAttribute("error");
    %>
</div><!-- /page -->
<script type="text/javascript">

    $(document).on('click','#popupSuccessBtn' ,function () {
        $('#dlg-sign-up-sent').popup();
        $('#dlg-sign-up-sent').popup('close');
        document.signUp.registerSuccess.value='success';
        document.signUp.submit();
    });
    $(document).on('click','#popupOkBtn' ,function () {
        $('#dlg-invalid-inputs').popup();
        $('#dlg-invalid-inputs').popup('close');
    });
    $(document).on("pagecreate","#signUpPage", function(){
        console.log("111  ============================>");
        $("#btn-submit").on("click", function(){
            var firstName=$("#txt-first-name").value;
            var lastName=$("#txt-last-name").value;
            var email=$("#txt-email").value;
            var password=$("#txt-password").value;
            var passwordConfirm=$("#txt-password-confirm").value;
            var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
            if (testEmail.test(email) && password===passwordConfirm)
            {
                console.log("222  ============================>");
                $("#dlg-sign-up-sent").popup("open");
                setTimeout(function(){  $("#p").popup("close"); }, 5000);
            }
        });
    });
    $(document).on('pagebeforeshow', function () {
        $('#button_logout').toggle();
    });
    $(document).on('click', '#button_login', function () {
        $('#button_logout').addClass('ui-btn-right').toggle();
        $(this).removeClass('ui-btn-right').toggle();
    });

    $(document).on('click', '#button_logout', function () {
        $('#button_login').addClass('ui-btn-right').toggle();
        $(this).removeClass('ui-btn-right').toggle();
    });


</script>
</body>

</html>
