$(function(){

  $('.order-by-distance').click(function(){
    var divList = $('.pilot-on-map');
    divList.sort(function(a, b){
      local_a = parseFloat( $(a).data("flight-length") );
      local_b = parseFloat( $(b).data("flight-length") );

      return local_b - local_a
    });

    $("#pilot-names").html(divList);

    $(this).parents('.list-group-item').remove();

  })


})