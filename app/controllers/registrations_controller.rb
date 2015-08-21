class RegistrationsController <  Devise::RegistrationsController

	def create
	  build_resource(sign_up_params)
      if resource.save
       #raise resource.inspect
        if params[:user][:is_admin].present? && params[:company_name].present? 
          @account = Account.create :company_name => params[:company_name], :company_reference => params[:company_reference]		
          resource.update :is_admin => params[:user][:is_admin], :account_id => @account.id
        end
        yield resource if block_given?
        if resource.active_for_authentication?
          set_flash_message :notice, :send_instructions,  :username => resource.email 
          sign_up(resource_name, resource)
          respond_with resource, :location => new_user_session_path
        else
          set_flash_message :notice, :send_instructions, :username => resource.email 
          respond_with resource, :location => new_user_session_path
        end
      else
        clean_up_passwords resource
        respond_with resource
      end
	end		
end
