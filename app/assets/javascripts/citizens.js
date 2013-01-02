

function own_questions_bind(){


    $('#ownq_form').bind("ajax:success", function(evt, data, status, xhr){
        $(".own_question_show").html(data)      ;


    });

    $("#destroy_own_question").bind("ajax:success", function(evt, data, status, xhr){
        $(".own_question_show").html(data)      ;


    });

}