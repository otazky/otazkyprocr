

function own_questions_bind(){


    $('#ownq_form').bind("ajax:success", function(evt, data, status, xhr){
        $(".own_question_show").html(data)      ;
        own_questions_bind();
        reload_oq_votelist();

    });

    $("#destroy_own_question").bind("ajax:success", function(evt, data, status, xhr){
        $(".own_question_show").html(data)      ;
        own_questions_bind();
        reload_oq_votelist();

    });

}

function reload_oq_votelist(){
    jQuery.ajax({
        type: 'get',
        data: {},
        url: "/oqvotelist",
        success: function(data){

            $("#ownquestions_voting").html(data);
            oq_vote_bind();
        }
    });
}


function oq_vote_bind(){

    $(".votelink").bind("ajax:success", function(evt, data, status, xhr){
        $("#ownquestions_voting").html(data);
        oq_vote_bind();
    });
}