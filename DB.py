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
        return featureList



if __name__ == "__main__":
    db = sqlite_noFTS()
    results = db.address_query("fish")
    import json
    print len( results )
    
