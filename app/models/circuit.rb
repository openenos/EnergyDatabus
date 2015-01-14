class Circuit < ActiveRecord::Base
  belongs_to :elec_load_type
  belongs_to :panel
end
