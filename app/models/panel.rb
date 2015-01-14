class Panel < ActiveRecord::Base
  belongs_to :site
  has_many :circuits, dependent: :destroy
  belongs_to :panel, :foreign_key => "parent_panel_id"
  has_many :panels, :foreign_key => "parent_panel_id"	
end
