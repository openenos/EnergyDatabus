class Location < ActiveRecord::Base
  belongs_to :postal_code
  belongs_to :utility
  has_many :sites, dependent: :destroy	
end
