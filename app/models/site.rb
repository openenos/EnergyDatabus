class Site < ActiveRecord::Base

  belongs_to :location
  has_many :site_group_mappings
  has_many :panels, dependent: :destroy
  has_many :elec_meters, dependent: :destroy
  has_many :site_groups, through: :site_group_mappings	

  belongs_to :account


  def get_all_channels
  	list_of_circuits = {}
    site = Site.find_by_site_ref(site_ref)
    site.panels.each do |panel|
    	panel.circuits.where(input: 0, active: 1).each do|circuit|
        list_of_circuits[circuit.id] = circuit.display
    	end
    end
    return list_of_circuits
  end

  def get_all_channel_names
		list_of_circuits = {}
    site = Site.find_by_site_ref(site_ref)
    site.panels.each do |panel|
    	panel.circuits.each do|circuit|
        list_of_circuits["CH-#{circuit.channel_no}"] = circuit.display
    	end
    end
    return list_of_circuits
  end

end

