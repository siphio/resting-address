import sqlite3, config, os

class sqlite_noFTS:
    def __init__(self):
        if os.path.isfile(config.database_filename):
            self.conn = sqlite3.connect( config.database_filename)
        else:
            raise ValueError('database file with the name '+ config.database_filename +' does not exist.')
        self.max_results = config.max_results
        self.metadata = config.metadata
    
    def __del__(self):
    	self.conn.close()

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
        wrapper = {
            "type": "FeatureCollection",
            "metadata": self.metadata,
            "features": featureList
        }
        if len(featureList) ==self.max_results:
            wrapper["metadata"]["results_throttled"] = True
        else:
            wrapper["metadata"]["results_throttled"] = False
        return wrapper


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
        
    def uprn_query_old(self, uprn):
        featureList = []
        sql = "select uprn, address_label, latitude, longitude from vlookup where uprn = ?"
        cursor = self.conn.execute( sql, [ str(uprn) ] )
        for row in cursor:
            featureList.append( self.feature_to_geojson(row))
        # a single feature returned is totally within geojson spec, but feature collection has scope for metadata.
        return self.featureList_wrapper( featureList )

    def uprn_query(self, uprn):
        sql = "select * from addressbase where uprn = ?"
        cursor = self.conn.execute( sql, [ str(uprn) ] )
        for row in cursor:
        	 result = {
        	 "type"      : "Feature",
        	 "properties" : {
        	 "uprn": row[0],
        	 "os_address_toid": row[1],
        	 "udprn": row[2],
        	 "organisation_name": row[3],
        	 "department_name": row[4],
        	 "po_box_number" : row[5],
        	 "sub_building_name": row[6],
        	 "building_name": row[7],
        	 "building_number": row[8],
        	 "dependent_thoroughfare": row[9],
        	 "thoroughfare": row[10],
        	 "post_town": row[11],
        	 "double_dependent_locality": row[12],
        	 "dependent_locality": row[13],
        	 "postcode": row[14],
        	 "postcode_type": row[15],
        	 "x": row[16],
        	 "y": row[17],
        	 "lat": row[18],
        	 "long": row[19],
        	 "rpc": row[20],
        	 "country": row[21],
        	 "change_type": row[22],
        	 "la_start_date": row[23],
        	 "rm_start_date": row[24],
        	 "last_update": row[25],
        	 "class": row[26],
        	 },
        	 "geometry": {
        	 	"type" : "Point",
        	 	"coordinates": [ row[19], row[18] ]
        	 }
        	 }
        return self.featureList_wrapper( [ result ] )


if __name__ == "__main__":
    # suggest overwrite live config values.
    config.max_results = 50
    db = sqlite_noFTS()
    print( len( db.address_query("council")['features'] ))
    print( len( db.address_query("FiSh")['features'] ))
    print( len( db.address_query("boundary")['features'] ))
    db.max_results = 100
    import json
    with open('tests.js', 'w') as f:
        json.dump( db.address_query("council"), f )
    print( json.dumps( db.uprn_query_2(10015253452) ))
