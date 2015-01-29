Rails.application.routes.draw do
  resources :accounts

  get 'home/index'

  resources :utilities

  resources :sites do
    collection do
      get 'getWeather'
    end
  end

  resources :site_group_mappings

  resources :site_groups

  resources :elec_meters

  resources :locations

  resources :postal_codes

  resources :panels

  resources :elec_load_types

  resources :circuits 
    

  devise_for :users

  namespace :ws, defaults: {format: 'json'} do
    get '/getAllGroups' => 'site_groups#get_all_groups'
    get '/getUsageByGroup' => 'site_groups#get_usage_by_group'
    get '/getSiteByGroup' => 'site_groups#get_site_by_group'
    get '/getDemandByGroup' => 'site_groups#get_demand_by_group'
    get '/usageByGroup' => 'site_groups#usage_by_group'

    get '/currentDemandByGroup' => "site_groups#current_demand_by_group"
    get '/solarPowerByGroup' => "site_groups#solar_power_by_group"
    get '/utilityPower' => "site_groups#utility_power"


  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

  Dir.glob File.expand_path("plugins/*", Rails.root) do |plugin_dir|
    file = File.join(plugin_dir, "config/routes.rb")
    if File.exists?(file)
      begin
        instance_eval File.read(file)
      rescue Exception => e
        puts "An error occurred while loading the routes definition of #{File.basename(plugin_dir)} plugin (#{file}): #{e.message}."
        exit 1
      end
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
