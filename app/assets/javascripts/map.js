$(function(){
  //var google loads from an external script
  if (typeof google !== 'undefined') {
    google.maps.event.addDomListener(window, 'load', initialize);
  }
});

function initialize() {
  var mapProp = {
    center: new google.maps.LatLng(37,-100),
    zoom: 4,
    mapTypeId:google.maps.MapTypeId.TERRAIN,
    disableDefaultUI: true
  };

  var bounds = new google.maps.LatLngBounds();
  console.log(bounds);
  var waypoints = 0;
  var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);

  $('.pilot').each(function(){
    waypoints = 0
    var flight_path_coords = []
    $(this).find('.waypoint').each(function(i){
      waypoints++
      var $waypoint = $(this);

      var latitude = $waypoint.data('latitude');
      var longitude = $waypoint.data('longitude');
      var elevation = $waypoint.data('elevation');
      var velocity = $waypoint.data('velocity');
      var name = $waypoint.data('name');
      var timestamp = $waypoint.data('timestamp');
      var text = $waypoint.data('text');

      var zIndex = 0
      var icon = 'http://maps.google.com/mapfiles/ms/icons/red.png';

      if (text){
        icon = 'http://maps.google.com/mapfiles/ms/icons/green.png'
        zIndex = 1
      }

      flight_path_coords.push({lat: parseFloat(latitude), lng: parseFloat(longitude)})

      var marker = new google.maps.Marker({
        // Supply the map and position parameters as usual.
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        label: name[0],
        //opacity: 0, this will come from equation like ( 100 - (16.6 * n) ) / 100
        icon: {
          url: icon,
          origin: new google.maps.Point(0, -6),
        },
        zIndex: zIndex
      });

      bounds.extend(marker.position);

      var infowindow = new google.maps.InfoWindow()

      var content = '<div id="content">'+
        '<strong>Name:</strong> '+ name +'<br>'+
        '<strong>Latitude:</strong> '+ latitude +'<br>'+
        '<strong>Longitude:</strong> '+ longitude +'<br>'+
        '<strong>Velocity:</strong> '+ velocity +'<br>'+
        '<strong>Elevation:</strong> '+ elevation +'<br>'+
        '<strong>Time (Local):</strong> '+ timestamp +'<br>'+
        '<strong>Text:</strong> <a class="map-link" href="https://maps.google.com/?daddr='+ latitude +','+ longitude +' " target="_blank">'+ text +'</a> <br>'+
        '</div>';

      google.maps.event.addListener(marker, 'click', (function(marker, content, infowindow){
        return function() {
          infowindow.setContent(content);
          infowindow.open(map, marker);
        };
      })(marker, content, infowindow));

    }) //waypoints each

    var flightPath = new google.maps.Polyline({
      path: flight_path_coords,
      geodesic: true,
      strokeColor: '#000',
      strokeOpacity: 1.0,
      strokeWeight: 1
    });

    flightPath.setMap(map);
  }); //pilots each

  if (waypoints > 0){
    map.fitBounds(bounds);
  }

  removeLoading();
}

function removeLoading(){
  $('#loading').fadeOut(500, function(){
    $(this).remove();
  });
}
