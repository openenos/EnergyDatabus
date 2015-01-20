#this helper which will run when we create an account and for each account a keyspace will be created 

require 'cassandra'

module EnergySchemaHelper

include ApplicationHelper

def create_schema(name)
# Defaults to the system keyspace
puts "Create Cassandra Schema enos_#{name}"
cluster = Cassandra.cluster

session  = cluster.connect()

# Creating a simple keyspace with replication factor 1
session.execute("CREATE KEYSPACE enos_#{name} WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 }")

session.execute("USE enos_#{name}")
# Creating a table
# panel or site_ref both are same in db perspective

session.execute("CREATE TABLE emon_min_by_data(panel text, channel text, asof_min int, value int, PRIMARY KEY((panel,channel),asof_min)) WITH COMPACT STORAGE AND CLUSTERING ORDER BY(asof_min desc)")

session.execute("CREATE TABLE emon_hourly_data(panel text, channel text, asof_hr int, value int, PRIMARY KEY((panel,channel),asof_hr)) WITH COMPACT STORAGE AND CLUSTERING ORDER BY(asof_hr desc)")

session.execute("CREATE TABLE emon_hourly_runtime(panel text, channel text, asof_hr int, value int, PRIMARY KEY((panel,channel),asof_hr)) WITH COMPACT STORAGE AND CLUSTERING ORDER BY(asof_hr desc)")

session.execute("CREATE TABLE weather_min_by_data(station text, asof_min int, value float, PRIMARY KEY(station, asof_min)) WITH COMPACT STORAGE AND CLUSTERING ORDER BY(asof_min desc)")

#db.execute("CREATE TABLE emon_daily_runtime(panel text, channel text, asof_day bigint, value int, PRIMARY KEY((panel,channel),asof_day)) WITH COMPACT STORAGE AND CLUSTERING ORDER BY(asof_day desc)")

puts "Completed Cassandra Schema"
end

end
