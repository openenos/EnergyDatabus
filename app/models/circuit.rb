class Circuit < ActiveRecord::Base
	require 'cassandra'
  belongs_to :elec_load_type
  belongs_to :panel

  def self.cassandra_db
  	cluster = Cassandra.cluster # connects to localhost by default

		cluster.each_host do |host| # automatically discovers all peers
		  puts "Host #{host.ip}: id=#{host.id} datacenter=#{host.datacenter} rack=#{host.rack}"
		end
  end
end
