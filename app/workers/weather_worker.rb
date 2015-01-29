# This worker will run for every 15 mins and will get updated into cassandra database.

class WeatherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(name)
    cluster = Cassandra.cluster
    session  = cluster.connect()
    session.execute("USE enos_#{name}")
    w_api = Wunderground.new(Location::WunderGroundKey) #constant declared in the class location
    result = w_api.conditions_for(Location::WunderGroundSecret) #constant declared in the class location
    time = Time.now.utc.to_i
    location = result['current_observation']['observation_location']['city']
    temp = result['current_observation']['temp_c'].to_s
    session.execute("INSERT INTO weather_min_by_data(station, asof_min, value) VALUES ('#{location}', #{time}, #{temp})")
    session.close
  end
end
