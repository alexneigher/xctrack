$(function(){
  //var google loads from an external script
  google.maps.event.addDomListener(window, 'load', initialize);
});


function initialize() {
  var mapProp = {
    center: new google.maps.LatLng(0,0),
    zoom:4,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  var bounds = new google.maps.LatLngBounds();

  var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
  var marker;

  $.ajax({
      type: "GET",
      url: "/fetch_coordinates",
      success: function(data) {
        console.log(data);
        for(var i = 0; i<data.length;i++){
          marker = new google.maps.Marker({
            position: new google.maps.LatLng(data[i][1], data[i][0]),
            map: map,
            title: 'test'
          })
          bounds.extend(marker.position);
          map.fitBounds(bounds);
        }


      }
  });
}

