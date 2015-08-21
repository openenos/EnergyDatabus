class ElecMeter < ActiveRecord::Base
  belongs_to :site
  belongs_to :account
  belongs_to :electric_meter, :foreign_key => "main_loc"
  has_many :electric_meters, :foreign_key => "main_loc" 	
end
