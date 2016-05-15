from app.bottle import route, run, template, get, debug, static_file
import json, app.DB as DB, config


# APIs
@route('/api/search/<value>')
def address_search( value ):
    db = DB.sqlite_noFTS()
    return db.address_query(value)

@route('/api/uprn/<value>')
def uprn_search( value ):
    db = DB.sqlite_noFTS()
    return db.uprn_query(value)



# CSS, thumbnails etc. Should be configured to cache.
@route('/static/<filename:path>')
def static(filename):
    return static_file(filename, root="static")


# web pages.

@route('/')
@route('/search')
@route('/search/')
def start_page():
    return template("templates/home.tpl")

@route('/search/<value>')
def displaySearch(value):
    results = address_search(value)
    return template("templates/searchresults.tpl", results=json.dumps( results ), previous_search=str(value))

@route('/map/<value>')
def display_Map(value):
    return template("templates/map_page.tpl", results = json.dumps( uprn_search( value )), api_key=config.mapbox_api_key )


run(host=config.host, port=8080, debug=True)