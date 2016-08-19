$(function(){
  //var google loads from an external script
  if (typeof google !== 'undefined') {
    google.maps.event.addDomListener(window, 'load', initialize);
  }
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

  var query_string = {};
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  var ids;
  if (vars[0].length > 0){
    ids = vars[0].split("=")[1];
  }else{
    ids = ''
  }
  $.ajax({
      type: "GET",
      url: "/fetch_coordinates?pilot_ids="+ids,
      success: function(data) {
        //each user
        for(var i = 0; i<data.length;i++){
          //each hash of lat/lon per point for that user (one flight)
          flight_path_coords = []

          for( var j = 0; j < data[i].length; j++){
            flight_path_coords.push({lat: parseFloat(data[i][j]['latitude']), lng:parseFloat(data[i][j]['longitude'])})

            marker = new google.maps.Marker({
              position: new google.maps.LatLng(parseFloat(data[i][j]['latitude']), parseFloat(data[i][j]['longitude'])),
              map: map,
              title: 'test'
            })
            bounds.extend(marker.position);
          }
          var flightPath = new google.maps.Polyline({
            path: flight_path_coords,
            geodesic: true,
            strokeColor: '#FF0000',
            strokeOpacity: 1.0,
            strokeWeight: 1
          });

          flightPath.setMap(map);
        }
        map.fitBounds(bounds);

      }
  });
}


function resetbounds(map){

}
