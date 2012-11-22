
function tasklist_init(){
    $('.accept_subtask').bind("ajax:success", function(evt, data, status, xhr){

        $('#dialog_citizen').html(data);
        $('#dialog_citizen').dialog({title:$(this).attr('title') });

        $('#accept_step2_subtask').bind("ajax:success", function(evt, data, status, xhr){

            if (data['status']=='ok'){
                $('#question_tasks').html(data['html']);
                $('#dialog_citizen').dialog("close");

                tasklist_init();
            }else{
                $('#dialog_citizen #error_explanation').html(data['html']);

            }
        });
    });



$('.citizen_task_nochange').bind("ajax:success", function(evt, data, status, xhr){
    $('#question_tasks').html(data);
});

$('.new_citizen_task_dialog').bind("ajax:success", function(evt, data, status, xhr){

    $('#dialog_citizen').html(data);
    //  $('#dialog_citizen').dialog();
    $('#dialog_citizen').dialog({title:$(this).attr('title') });



    $('#new_citizens_task').bind("ajax:success", function(evt, data, status, xhr){
        $('#question_tasks').html(data);
        $('#dialog_citizen').hide();
    });



});

$('.set_done').bind("ajax:success", function(evt, data, status, xhr){
    $('#question_tasks').html(data);
});

}