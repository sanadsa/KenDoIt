

    var currentSelectedTask;
    $("li").click(function(){
        setAction($(this)[0]);
        if ($(this).css("background-color") === "rgba(0, 0, 0, 0)") {
            $(this).css("background-color", "rgb(23, 150, 207)");
        } else {
            $(this).css("background-color", "rgba(0, 0, 0, 0)");
        }
        for(var i=0;i<$("li").length;i++){
            if($("li")[i]!=$(this)[0])
                $($("li")[i]).css("background-color", "rgba(0, 0, 0, 0)");
        }
    });
    function getSelectedTask(){
        if(currentSelectedTask!=null && currentSelectedTask!= undefined)
        {
            console.log("update =====> "+currentSelectedTask);
            $('#taskId').val(currentSelectedTask);
            $('#taskDeleteId').val(currentSelectedTask);
        }
    };
    function setAction(element){
        currentSelectedTask = element.id;

    };

    function openDialog() {
        var form=$("#task").fadeIn(2000);
    };

