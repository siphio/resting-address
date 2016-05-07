import sqlite3, config, os

class sqlite_noFTS:
    def __init__(self):
        if os.path.isfile(config.database_filename):
            self.conn = sqlite3.connect( config.database_filename)
        else:
            raise ValueError('database file with the name '+ config.database_filename +' does not exist.')
        self.max_results = config.max_results
        self.metadata = config.metadata

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
    def featureList_wrapper(self, featureList):
        return {
            "type": "FeatureCollection",
            "metadata": self.metadata,
            "features": featureList
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
        return self.featureList_wrapper( featureList )
        
    def uprn_query(self, uprn):
        featureList = []
        sql = "select uprn, address_label, latitude, longitude from vlookup where uprn = ?"
        cursor = self.conn.execute( sql, [ str(uprn) ] )
        for row in cursor:
            featureList.append( self.feature_to_geojson(row))
        # a single feature returned is totally within geojson spec, but feature collection has scope for metadata.
        return self.featureList_wrapper( featureList )



if __name__ == "__main__":
    # suggest overwrite live config values.
    config.max_results = 50
    db = sqlite_noFTS()
    print len( db.address_query("council")['features'] )
    print len( db.address_query("FiSh")['features'] )
    print len( db.address_query("boundary")['features'] )
    db.max_results = 100
    import json
    with open('tests.js', 'w') as f:
        json.dump( db.address_query("council"), f )
    print json.dumps( db.uprn_query(10015253452) )
