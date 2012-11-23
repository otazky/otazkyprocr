
function error_or_tasklist(data){
    if (data['status']=='ok'){
        $('#question_tasks').html(data['html']);
        $('#dialog_citizen').dialog("close");
        tasklist_init();
    }else{
        $('#dialog_citizen #error_explanation').html(data['html']);
    }
}



function tasklist_init(){

    $('.add_subtask').bind("ajax:success", function(evt, data, status, xhr){   // link from task index

        $('#dialog_citizen').html(data);
        $('#dialog_citizen').dialog({title:$(this).attr('title') });

        $("#new_subtask").bind("ajax:success", function(evt, data, status, xhr){
            error_or_tasklist(data);
        });

    });

    $('.accept_subtask').bind("ajax:success", function(evt, data, status, xhr){
        $('#question_tasks').html(data);
        tasklist_init();
    //  for acceptation in 2 steps use this:
    //    $('#dialog_citizen').html(data);
    //    $('#dialog_citizen').dialog({title:$(this).attr('title') });

    //    $('#accept_step2_subtask').bind("ajax:success", function(evt, data, status, xhr){
    //        error_or_tasklist(data);
    //    });
    });



$('.citizen_task_nochange, .subtask_verify, .task_verify').bind("ajax:success", function(evt, data, status, xhr){
    $('#question_tasks').html(data);
});

$('.new_citizen_task_dialog').bind("ajax:success", function(evt, data, status, xhr){

    $('#dialog_citizen').html(data);
    //  $('#dialog_citizen').dialog();
    $('#dialog_citizen').dialog({title:$(this).attr('title') });

    $('#new_citizens_task').bind("ajax:success", function(evt, data, status, xhr){
        error_or_tasklist(data);
    });

});

    $('.set_done').bind("ajax:success", function(evt, data, status, xhr){

        $('#dialog_citizen').html(data);
        $('#dialog_citizen').dialog({title:$(this).attr('title') });
        $('form#task_approv').bind("ajax:success", function(evt, data, status, xhr){
            error_or_tasklist(data);
        });
    });

    $('.subtask_edit_done').bind("ajax:success", function(evt, data, status, xhr){
        $('#dialog_citizen').html(data);
        $('#dialog_citizen').dialog({title:$(this).attr('title') });
        $('form#subtask_done').bind("ajax:success", function(evt, data, status, xhr){
            error_or_tasklist(data);
        });
    });


}