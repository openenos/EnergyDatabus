class SiteGroupMapping < ActiveRecord::Base
  
  belongs_to :site
  belongs_to :site_group	
  belongs_to :account

end
