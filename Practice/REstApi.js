function clicked() {
    var location = document.getElementById('location').value;
    // console.log(location);
    if (location != "null") {
        console.log(location);
        mapUrl = "http://maps.googleapis.com/maps/api/geocode/json?address=" + location;
        console.log(mapUrl);
        var lat;
        var lng;
        loadJSON(mapUrl,
            function (data) {
                console.log(data);
                lat = data.results[0].geometry.location.lat;
                lng = data.results[0].geometry.location.lng;
                console.log(lat, lng); // end here
                instaUrl="https://api.instagram.com/v1/media/search?lat="+lat+"&lng="+lng+"&client_id=5549545833.1677ed0.46746a047f9241fd8d010a6df642a75c";
                console.log(instaUrl);
            },
            function (xhr) { console.error(xhr); }
        );
       console.log(lat, lng); //use setTimeout
        /*using the location as the key use the value of lat and lng to feed the api of
         insta to get the pics of the related location entered */
         // require client id
    }
}
  /* getting the json data from the mapUrl */
  function loadJSON(path, success, error) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                if (success)
                    success(JSON.parse(xhr.responseText));
            } else {
                if (error)
                    error(xhr);
            }
        }
    };
    xhr.open("GET", path, true);
    xhr.send();
}