class Location < ActiveRecord::Base
  
  belongs_to :postal_code
  belongs_to :utility
  has_many :sites, dependent: :destroy
  belongs_to :account

  WunderGroundKey = "87e74b8d9511ea00"
  WunderGroundSecret = "pws:KFLPALME10"	
end
