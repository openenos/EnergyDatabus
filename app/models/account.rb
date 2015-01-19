class Account < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :company_reference, :company_name

end
