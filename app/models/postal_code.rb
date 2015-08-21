class PostalCode < ActiveRecord::Base

  has_many :locations, dependent: :destroy	
  belongs_to :account
  
end
