class Site < ActiveRecord::Base
  belongs_to :location
  has_many :site_group_mappings
  has_many :panels, dependent: :destroy
  has_many :elec_meters, dependent: :destroy
  has_many :site_groups, through: :site_group_mappings	
end
