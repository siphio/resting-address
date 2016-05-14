from bottle import route, run, template, get, debug, static_file
import json, DB, config

@route('/api/addresses/<value>')
def address_search( value ):
    db = DB.sqlite_noFTS()
    return db.address_query(value)

@route('/api/uprn/<value>')
def uprn_search( value ):
    db = DB.sqlite_noFTS()
    return db.uprn_query(value)

@route('/static/<filename:path>')
def static(filename):
    return static_file(filename, root="static")

@route('/search/<value>')
def displaySearch(value):
    results = address_search(value)
    return template("searchresults.tpl", results=json.dumps( results ))

run(host='localhost', port=8080, debug=True)
