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
        <div class= "row">
    		<div class="twelve columns">
    		    <p id="javascriptWarning">This page requires Javascript.</p>
    		</div>
    	</div>
    </div>

    <script>
        var searchBox = document.getElementById('searchBox');

        
        function enter_pressed_check(e){
        	if(e.keyCode === 13){
            	searchButtonPressed();
            }
        }
        
        function searchButtonPressed(){
        	window.open("/search/"+searchBox.value, "_self");
        }

        
        function hideRequiresJavascriptWarning() {
        	document.getElementById("javascriptWarning").style.display="none";
        }
        
        hideRequiresJavascriptWarning()

    </script>
</body>

</html>
