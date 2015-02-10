# This worker will run for every 15 mins and will get updated into cassandra database.

#require 'yaml'

class WeatherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(name)
    cluster = Cassandra.cluster
    session  = cluster.connect()
    session.execute("USE enos_#{name}")
    #weather = YAML.load_file('config/weather.yml')
    #raise weather.inspect
    #$weather = weather[Rails.env]
    w_api = Wunderground.new(Location::WunderGroundKey)
    result = w_api.conditions_for(Location::WunderGroundSecret)
    time = Time.now.utc.to_i
    location = result['current_observation']['observation_location']['city']
    temp = result['current_observation']['temp_c'].to_s
    session.execute("INSERT INTO weather_min_by_data(station, asof_min, value) VALUES ('#{location}', #{time}, #{temp})")
    session.close
  end
end
