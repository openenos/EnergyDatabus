#require 'redis'
class SiteGroup < ActiveRecord::Base

  has_many :site_group_mappings
  has_many :sites, through: :site_group_mappings
  belongs_to :account
  
end
