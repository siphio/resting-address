<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8 />
<title>Resting-Address - map page</title>
<meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
<script src='https://api.mapbox.com/mapbox.js/v2.4.0/mapbox.js'></script>
<link href='https://api.mapbox.com/mapbox.js/v2.4.0/mapbox.css' rel='stylesheet' />

<!--
<script>



var data = {"features": [{"type": "Feature", "geometry": {"type": "Point", "coordinates": [-2.0490497, 52.4492121]}, "properties": {"postcode_type": "S", "rm_start_date": "2012-03-19", "building_name": "", "sub_building_name": "", "la_start_date": "2008-01-03", "long": -2.0490497, "change_type": "I", "country": "E", "dep_thoroughfare": "", "y": 283472, "x": 396763, "post_town": "HALESOWEN", "udprn": 822681, "postcode": "B63 3HN", "os_address_toid": "osgb1000002247852706", "organisation_name": "", "class": "R", "PO_box": "", "building_number": "1", "dd_locality": "", "rpc": 1, "last_update": "2015-08-23", "lat": 52.4492121, "dependent_locality": "", "department_name": "", "uprn": 90057151, "thoroughfare": "BIRMINGHAM STREET"}}], "type": "FeatureCollection", "metadata": {"results_throttled": false, "OS License": "copyright etc, etc, etc."}};


</script>
-->

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

// data.features[0].properties["marker-color"] = "#33C3F0";

L.mapbox.accessToken = '{{!api_key}}';
var map = L.mapbox.map('map', 'mapbox.streets')
    .setView( [data.features[0].geometry.coordinates[1],data.features[0].geometry.coordinates[0]], 18);
   // .featureLayer.setGeoJSON(data);

var marker = L.marker([data.features[0].geometry.coordinates[1], data.features[0].geometry.coordinates[0]]);//.addTo(map);
marker.addTo(map);
marker.bindPopup(pretty_address( data.features[0].properties )).openPopup();

function toTitleCase(str)
{
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}

function pretty_address(properties){
var address = "";
if (properties["organisation_name"] != ""){ address += toTitleCase(properties["organisation_name"]) + "<br>";}
if (properties["sub_building_name"] != ""){ address += toTitleCase(properties["sub_building_name"]) + "<br>";}
if (properties["building_name"] != ""){ address += toTitleCase(properties["building_name"]) + "<br>";}
if (properties["building_number"] != "" && properties["building_number"] != null){ address += toTitleCase(properties["building_number"])+" ";}
if (properties["po_box_number"] != ""){ address += properties["po_box_number"] + "<br>";}
if (properties["dependent_thoroughfare"] != ""){ address += toTitleCase(properties["dependent_thoroughfare"]) + "<br>";}
if (properties["thoroughfare"] != ""){ address += toTitleCase(properties["thoroughfare"]) + "<br>";}
if (properties["double_dependent_locality"] != ""){ address += toTitleCase(properties["double_dependent_locality"]) + "<br>";}
if (properties["dependent_locality"] != ""){ address += toTitleCase(properties["dependent_locality"]) + "<br>";}
if (properties["post_town"] != ""){ address += properties["post_town"] + "<br>";}
address += properties["postcode"]
return address
}

</script>
</body>
</html>
