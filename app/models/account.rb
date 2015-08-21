class Account < ActiveRecord::Base
  
  has_many :users, dependent: :destroy
  has_many :circuits, dependent: :destroy
  has_many :elec_meters, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :panels, dependent: :destroy
  has_many :postal_codes, dependent: :destroy
  has_many :sites, dependent: :destroy
  has_many :site_groups, dependent: :destroy
  has_many :site_group_mappings, dependent: :destroy

  validates_uniqueness_of :company_reference, :company_name

end
