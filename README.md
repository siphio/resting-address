# resting-address

## A rest API and simple gazetteer over the Ordnance Survey Addressbase dataset.

A straightforward and relatively minimalist addressbase gazetteer, with web interface for search and  display, and a geoJSON API. The web interface is designed for easy embedding in another page (e.g., with iframes).

Resting-address currently uses Mapbox for maps, and is SQLite dependent. The intention is for it to also support sqlite with FTS4 and Postgres as a datastore, and  

My intention is to update and load a connecting QGIS plugin for gazetteer lookups.

## todo: 

1. Page and project titles to be pulled from config.py
2. Basic address lookup should include commercial and residential property indicators.
3. Support for sqlite databases with the FTS plugins enabled for full text search.
4. Finish addressbase loader (to include COUs).
5. Add web interface for the addressbase loader.
6. Support for other leaflet-supported basemaps, not just mapbox.
