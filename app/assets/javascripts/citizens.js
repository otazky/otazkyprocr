

function own_questions_bind(){


    $('#ownq_form').bind("ajax:success", function(evt, data, status, xhr){
        $(".own_question_show").html(data)      ;
        own_questions_bind();

    });

    $("#destroy_own_question").bind("ajax:success", function(evt, data, status, xhr){
        $(".own_question_show").html(data)      ;
        own_questions_bind();

    });

}

function oq_vote_bind(){

    $(".votelink").bind("ajax:success", function(evt, data, status, xhr){
        $("#ownquestions_voting").html(data);
        oq_vote_bind();
    });
}