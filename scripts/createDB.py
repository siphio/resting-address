import sqlite3, config

sqlscript = "database_creation_sqlite.sql"

con = sqlite3.connect(config.database_filename)

with open(sqlscript, 'r') as sql:
	con.executescript( sql.read() )
