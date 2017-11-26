$(function(){
  $('#toggleLocation').click(function(){
    $(this).remove();

    if (navigator.geolocation) {
      pollUserLocation();
    } else {
      alert("Geolocation is not supported by this browser.");
    }
  })
})

function pollUserLocation() {
  setInterval(function(){ 
    navigator.geolocation.getCurrentPosition(showPosition);
  }, 5000);
}

function showPosition(position) {
  console.log("Latitude: " + position.coords.latitude);

  console.log("Longitude: " + position.coords.longitude); 
}