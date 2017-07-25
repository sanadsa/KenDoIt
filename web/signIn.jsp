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
<div data-role="page"  id="signInPage">
    <div data-role="header" data-theme="b">
        <form action="Router" name="home"  method="post">
            <button type="button"  data-role="button" data-icon="home" data-iconpos="left"
                     onclick="{document.home.submit();}">Home</button>
            <input id="back" type="hidden" name="page" value="main">
        </form>
        <h1>Just Do It</h1>
    </div>

    <form id="Router" name="melak" action="Router" method="post">
        <div role="main" class="ui-content">
            <h3>Sign In</h3>
            <label for="txt-email">Email Address</label>
            <input type="text" name="txt-email" id="txt-email" value="">
            <label for="txt-password">Password</label>
            <input type="password" name="txt-password" id="txt-password" value="">
            <button type="button"  data-rel="popup" data-transition="pop"  onsubmit="return true;"  data-position-to="window"
                    id="btn-submit" class="ui-btn ui-btn-b ui-corner-all mc-top-margin-1-5"
                    onclick="{document.melak.submit();}">Submit</button>
            <p class="mc-top-margin-1-5"><a href="begin-password-reset.html">Can't access your account?</a></p>
            <%
                        if(request.getAttribute("loginResult") != null){

            %>
            <div  id="dlg-invalid-credentials"  class="pop ui-popup ui-body-inherit ui-overlay-shadow ui-corner-all" data-dismissible="false"
                  style="max-width:400px;position: absolute;height: 200px;width: 400px;margin: -135px 0 0 -200px;top: 50%;left: 50%;">
                <div role="main" class="ui-content">
                    <h3 class="mc-text-danger" style="color:red">Login Failed</h3>
                    <p>Did you enter the right credentials?</p>
                    <div class="mc-text-center"><a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-b mc-top-margin-1-5">OK</a></div>
                </div>
            </div>
            <%
                }
            %>

            <input id="dataPage" type="hidden" name="page" value="signIn">
        </div><!-- /content -->
    </form>
    <div data-role="footer" data-theme="b">
        <h6 class="mc-text-center">Copyleft Sanad & Melak <span style="display:inline-block;
  transform: rotate(180deg);" class="copyleft">&copy;</span> 2017</h6>
    </div>

</div><!-- /page -->

<script type="text/javascript">

    // toggle between to options logout or home
    $(document).on('pagebeforeshow', function () {
        $('#button_logout').toggle();
    });
    // handle when click login we change the logo
    $(document).on('click', '#button_login', function () {
        $('#button_logout').addClass('ui-btn-right').toggle();
        $(this).removeClass('ui-btn-right').toggle();
    });
    // handle when click logout we change the logo
    $(document).on('click', '#button_logout', function () {
        $('#button_login').addClass('ui-btn-right').toggle();
        $(this).removeClass('ui-btn-right').toggle();
    });

</script>
</body>
</html>
