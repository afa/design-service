$(function() {
  function black_content(){
    $("#black_content").css("height",$(document).height());
    $("#black_content").css("display","block");
  };


  $(".registration").click(function(){
    black_content();
    $("#register").css("display","block");
  });

  $(".login").click(function(){
    black_content();
    $("#login").css("display","block");
  });

  $(".close_fly_window").click(function(){
    //alert($(this).attr("class"));
    $(this).parent().css("display","none").parent().css("display","none");
  });
});
