<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script src="http://maps.google.com/maps?file=api&v=1&key=ABQIAAAA-9MxuMZWgzRiU_FdEvuCNBQaUYZ7Vxo7K1r5Sxxg_wft4GhHCxRZbj_mH_zlPIXTZAfAW2spMKr70Q" type="text/javascript"></script>
  </head>
  <body onload="ShowMeTheMap();">
    <center>
    <div id="map" style="width: 800px; height: 600px"></div>
    </body>
    <script type="text/javascript">
    //<![CDATA[
    function ShowMeTheMap()
    {
    if ( (navigator.userAgent.toLowerCase()).indexOf('msie 5') + 1 ) 
    {
        alert('Sorry, this site makes use of Google Maps, which is not supported by Internet Explorer 5.');
    } 
    else 
    {
        var map = new GMap(document.getElementById("map"));

        map.addControl(new GLargeMapControl());
        map.addControl(new GMapTypeControl());
        map.centerAndZoom(new GPoint(-79.3854904174805, 43.6599240747891), 6);
        GEvent.addListener(map, "click", function(marker, point) {  if (marker) {    map.removeOverlay(marker);  } else {    alert(point.x + ", " + point.y);  }});
          }
    }
    //]]>
    </script>
    </center>
</html>