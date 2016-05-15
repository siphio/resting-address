<!DOCTYPE html>
<html lang="en">

<head>


    <!-- Basic Page Needs
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
    <meta charset="utf-8">
    <title>Resting-Address</title>
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Mobile Specific Metas
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- FONT
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
    <link href="http://fonts.googleapis.com/css?family=Raleway:400,300,600" rel="stylesheet" type="text/css">

    <!-- CSS
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/skeleton.css">

    <!-- Favicon
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
    <link rel="icon" type="image/png" href="/static/images/favicon.png">

    <script>

		var data = {{!results}}
		
		var previous_search="{{!previous_search}}";

    </script>

    <style>
        .address_list {
            list-style-type: none;
        }
        
        .address_list li {
            margin-top: 2rem;
        }
        
        .address_list a {
            text-decoration: none;
            color: #000000;
            /* unvisited link */
        }
        
    	#maxResultsWarning {
    		display: none;
    		color: red;
    	}
    	
    	#noResultsWarning {
    		display: none;
    	}
    </style>

</head>

<body>
    <div class="container">
        <div class="row">
            <div class="two-thirds column">
                <h2>Restful-Address</h2>
            </div>
        </div>
            <div class="row">
                <div class="two-thirds column">
                    <input class="u-full-width" type="search" placeholder="1 High street, B60 1AA" id="searchBox" onkeypress= "enter_pressed_check(event)">
                </div>
                <div class="one-third column">
                    <input type="button" class="button-primary u-full-width" value="Search" onclick = "searchButtonPressed()">
                </div>
            </div>
        <div class="row">
            <div class="twelve columns">
            	<p id="noResultsWarning"">No results match this search. Please try again.</p>
                <ul id="address_list" class="address_list"> </ul>
            </div>
        </div>
    	<div class= "row">
    		<div class="twelve columns">
    		    <p id="javascriptWarning">This page requires Javascript.</p>
    			<small id="maxResultsWarning">Showing first <span id="resultsCount">N</span> results. If your property isn't shown, try a more detailed search.</small>
    		</div>
    	</div>
    </div>

    <script>
        var listElement = document.getElementById("address_list");
        var pageWarning = document.getElementById("maxResultsWarning");
        var resultsCount = document.getElementById("resultsCount");
        var noResultsWarning = document.getElementById("noResultsWarning");
        var searchBox = document.getElementById('searchBox');

        function toTitleCase(str) //not used currently, as it messes up the postcode.
        {
            return str.replace(/\w\S*/g, function (txt) {
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
            });
        }

        function featureCollection_to_addresslist(data, listID) {
            var result = '';
            var l = data.features.length;
            for (var i = 0; i < l; i++) {
            	var url = "/map/"+data.features[i]["properties"]["uprn"]
                result += "<li><a href='"+url+"'>" + data.features[i]["properties"]["address"] /*.replace(/,/g, ",</br>") */ + "</a></li>";
            }
            listID.innerHTML = result;
        }
        
        function enter_pressed_check(e){
        	if(e.keyCode === 13){
            	searchButtonPressed();
            }
        }
        
        function searchButtonPressed(){
        	window.open("/search/"+searchBox.value, "_self");
        }

        function displayPageWarning(data){
        	resultsCount.innerHTML = data.features.length;
        	if (data.metadata.results_throttled){
        		pageWarning.style.display="inline";
        		}
        }
        
        function displayNoResultsWarning(data){
	        if (data.features.length == 0){
    	    	noResultsWarning.style.display="inline";
       		}
        }
        
        function fill_search_box(contents){
        	searchBox.value = contents;
        }
        
        function hideRequiresJavascriptWarning() {
        	document.getElementById("javascriptWarning").style.display="none";
        }
        
        hideRequiresJavascriptWarning()
        displayNoResultsWarning(data)
        featureCollection_to_addresslist(data, listElement)
        displayPageWarning(data)
        fill_search_box(previous_search)

    </script>
</body>

</html>