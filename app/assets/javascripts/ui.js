$(function(){

  $('.order-by-name').click(function(){
    var divList = $('.pilot-on-map');
    divList.sort(function(a, b){
        return $(a).data("name")-$(b).data("name")
    });

    $("#pilot-names").html(divList);

  })

  $('.order-by-distance').click(function(){
    var divList = $('.pilot-on-map');
    divList.sort(function(a, b){
        return $(a).data("length")-$(b).data("length")
    });

    $("#pilot-names").html(divList);
  })


})