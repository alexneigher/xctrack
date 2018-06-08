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


  //this controls the adding and removing pilot functionality
  $('.pilot-toggle-button').click(function(){
    $('#updateMapButton').removeClass('disabled');

    if ( $(this).hasClass('btn-success') ){
      $(this)
        .removeClass('btn-success')
        .addClass('btn-default')
        .html("&#43;");
    } else{
      $(this)
        .removeClass('btn-default')
        .addClass('btn-success')
        .html("&#10003;");
    }
    
    update_form_ids();
  })
})

function update_form_ids(){
  //find all "checked" buttons and add them to the input
  $form_input = $('#pilots');
  $form_input.val('');
  pilot_ids = new Array;
  
  $('.pilot-toggle-button').each(function(){
    //if btn-success is present, add this ID to the form
    if ( $(this).hasClass('btn-success') ){

      pilot_ids.push( $(this).data('pilot-id'));

    }else if ( $(this).hasClass('btn-default') ){
      var index = pilot_ids.indexOf($(this).data('pilot-id'));

      if (index !== -1){
        pilot_ids.splice(index, 1);
      }
    }
  });

  console.log(pilot_ids)
  $form_input.val(pilot_ids)
}