class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :account
  
  def user_account(params)
  	 account = build_account(params)	
  	 if account.save
  	 	true
  	 else
  	 	false
  	 end
  end       
end
