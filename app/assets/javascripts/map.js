$(function(){
  //var google loads from an external script
  if (typeof google !== 'undefined') {
    google.maps.event.addDomListener(window, 'load', initialize);
  }

  //bind click to enable location
  $('#toggleLocation').click(function(){
    $(this).html('working...');
    
    if (navigator.geolocation) {
      options = {
        enableHighAccuracy: false,
        timeout: 5000,
        maximumAge: 0
      };

      navigator.geolocation.watchPosition(showPosition, function(d){alert(d.message)}, options);
    } else {
      alert("Geolocation is not supported by this browser.");
    }
  })
});

function initialize() {
  var mapProp = {
    center: new google.maps.LatLng(37,-100),
    zoom: 4,
    mapTypeId:google.maps.MapTypeId.TERRAIN,
    zoomControl: false,
    mapTypeControl: true,
    scaleControl: false,
    streetViewControl: false,
    rotateControl: false,
    fullscreenControl: false
  };

  bounds = new google.maps.LatLngBounds();
  var waypoints = 0;
  map = new google.maps.Map(document.getElementById("googleMap"),mapProp);

  $('.pilot').each(function(){
    waypoints = 0
    var flight_path_coords = []
    $(this).find('.waypoint').sort(function(a, b) {
          return +$(a).data('counter') - +$(b).data('counter');
      }).each(function(i){
      waypoints++
      var $waypoint = $(this);

      var latitude = $waypoint.data('latitude');
      var longitude = $waypoint.data('longitude');
      var elevation = $waypoint.data('elevation');
      var velocity = $waypoint.data('velocity');
      var name = $waypoint.data('name');
      var timestamp = $waypoint.data('timestamp');
      var text = $waypoint.data('text');
      var counter = $waypoint.data('counter');
      var zIndex = counter
      var icon = 'https://maps.google.com/mapfiles/ms/icons/red.png';

      if (waypoints == 1){
        //first point, make it blue
        icon = 'https://maps.google.com/mapfiles/ms/icons/blue.png'
        zIndex = 9999
      }

      if (text){
        icon = 'https://maps.google.com/mapfiles/ms/icons/green.png'
        zIndex = 9999
      }

      flight_path_coords.push({lat: parseFloat(latitude), lng: parseFloat(longitude)})

      var marker = new google.maps.Marker({
        // Supply the map and position parameters as usual.
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        label: {text: name[0], color: "white", fontSize: "10px"},
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
        '<strong>Time:</strong> '+ timestamp +'<br>'+
        '<strong>Text:</strong> ' + parse_text_for_link(text, latitude, longitude);

      google.maps.event.addListener(marker, 'click', (function(marker, content, infowindow){
        return function() {
          infowindow.setContent(content);
          infowindow.open(map, marker);
        };
      })(marker, content, infowindow));

    }) //waypoints each

    var lineSymbol = {
      path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW
    };

    var flightPath = new google.maps.Polyline({
      path: flight_path_coords,
      geodesic: true,
      strokeColor: '#000',
      strokeOpacity: 1.0,
      strokeWeight: 1,
      icons: [{
        icon: lineSymbol,
        offset: '50%',
        repeat: '30px'
      }],
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

function parse_text_for_link(text, latitude, longitude){
  var str = ''
   if (text.length > 0){
    str = text +'<a class="map-link"' +
         'href="https://maps.google.com/?daddr=' +
         + latitude +','+ longitude +
         '" target="_blank">' +
         ' Click here for directions to me' +
         '</a> <br></div>';
   }else{
    str = text +'<a class="map-link"' +
         'href="https://maps.google.com/?daddr=' +
         + latitude +','+ longitude +
         '" target="_blank">' +
         'Click for directions to this pin' +
         '</a> <br></div>';
   }

   return str;
}


function showPosition(position) {
  $('#toggleLocation').remove();
  var myLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
  
  if (typeof(customMarker) == 'undefined'){
    console.log('first time');
    customMarker = new google.maps.Marker({
      position: myLatLng,
      icon:{
        url: 'https://maps.google.com/mapfiles/dir_0.png',
      },
      map: map,
    });

  }else{
    console.log('update it');
    customMarker.setPosition(myLatLng)
  }
  
  bounds.extend(customMarker.position);
  map.fitBounds(bounds);
}


