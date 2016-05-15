<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8 />
<title>Resting-Address - map page</title>
<meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
<script src='https://api.mapbox.com/mapbox.js/v2.4.0/mapbox.js'></script>
<link href='https://api.mapbox.com/mapbox.js/v2.4.0/mapbox.css' rel='stylesheet' />

<script>
var data = {{!results}};
</script>

<style>
  body { margin:0; padding:0; }
  #map { position:absolute; top:0; bottom:0; width:100%; }
</style>
</head>
<body>
<div id='map'></div>
<script>

data.features[0].properties["marker-color"] = "#33C3F0";

L.mapbox.accessToken = '{{!api_key}}';
var map = L.mapbox.map('map', 'mapbox.streets')
    .setView( [data.features[0].geometry.coordinates[1],data.features[0].geometry.coordinates[0]], 18)
    .featureLayer.setGeoJSON(data);
</script>
</body>
</html>
