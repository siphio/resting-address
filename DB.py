import sqlite3, config

class sqlite_noFTS:
    def __init__(self, dbfile):
        self.conn = sqlite3.connect(dbfile)

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
        sql = "select uprn, address_label, latitude, longitude from vlookup where address_label like ?"
        cursor = self.conn.execute( sql, ["%"+search_string+"%"] )
        for row in cursor:
        	featureList.append( self.feature_to_geojson(row) )
        if (not config.max_results) or (len(featureList) < config.max_results):
        	return featureList
        else:
        	return featureList[0:config.max_results]



if __name__ == "__main__":
    db = sqlite_noFTS(config.database_filename)
    results = db.address_query("fish")
    import json
    print len( results )
    
