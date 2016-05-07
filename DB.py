import sqlite3, config

class sqlite_noFTS:
    def __init__(self, dbfile=config.database_filename, max_results=config.max_results):
        self.conn = sqlite3.connect(dbfile)
        self.max_results = max_results

    def feature_to_geojson(self, item):
        return {"type"      : "Feature",
                "properties": {
                    "uprn"      : item[0],
                    "address"   : item[1]
                    },
                "geometry"  : {
                    "type" : "Point",
                    "coordinates": [ item[3], item[2] ]
                    }
                }

    def address_query(self, search_string):
        featureList = []
        if self.max_results:
            sql = "select uprn, address_label, latitude, longitude from vlookup where address_label like ? limit ?"
            cursor = self.conn.execute( sql, [ "%"+search_string+"%", str(self.max_results) ] )
        else:
            sql = "select uprn, address_label, latitude, longitude from vlookup where address_label like ?"
            cursor = self.conn.execute( sql,  ["%"+search_string+"%"] )
        for row in cursor:
            featureList.append( self.feature_to_geojson(row) )
        return {"type": "FeatureCollection", "metadata": "metadata goes here.", "features": featureList }
        
    def uprn_query(self, uprn):
    	featureList = []
    	sql = "select uprn, address_label, latitude, longitude from vlookup where uprn = ?"
    	cursor = self.conn.execute( sql, [ str(uprn) ] )
    	for row in cursor:
    		featureList.append( self.feature_to_geojson(row))
    	# a single feature returned is totally within geojson spec, but feature collection has scope for metadata.
    	return {"type": "FeatureCollection", "metadata": "metadata goes here.", "features": featureList }


if __name__ == "__main__":
    # tested against data covering Worcestershire, UK.
    db = sqlite_noFTS()
    print len( db.address_query("council")['features'] )
    db.max_results = False # override config.
    print len( db.address_query("FiSh")['features'] )
    db.max_results = 100
    import json
    with open('tests.js', 'w') as f:
    	json.dump( db.address_query("council"), f )
    print json.dumps( db.uprn_query(10015253452) )
    
