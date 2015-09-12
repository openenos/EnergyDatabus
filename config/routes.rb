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
    

  get 'site_appliances/index' 
  get 'site_usage/index'
  get 'site_snapshots/index' => "site_snapshots#index"

  #devise_for :users

  devise_for :users, controllers: { registrations: 'registrations'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#dashboard'

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



  namespace :api, defaults: {format: 'json'} do
    #routes for index page 
    match "/get_monthly_data" => "web_services#get_monthly_data_by_site_by_month", via: :get
    match "/get_last_month_data_by_load_type" => "web_services#get_last_month_data_by_load_type", via: :get
    match "/get_last_month_data_by_site" => "web_services#get_last_month_data_by_site", via: :get
    match "/get_live_data_by_site" => "web_services#get_live_data_by_site", via: :get
    match "/get_last_year_data" => "web_services#get_last_year_data", via: :get

    #routes for site snapshot
    match "/get_top_circuits_by_site" => "sites#get_top_circuits_by_site", via: :get
    match "/get_last_day_demand" => "sites#get_last_day_demand", via: :get
    match "/get_weather_forecast" => "sites#get_weather_forecast", via: :get
    match "/get_site_demand" => "sites#get_site_demand", via: :get
    match "/get_appliances_usage_by_site" => "sites#get_appliances_usage_by_site", via: :get
    match "/get_top_demand" => "sites#get_top_demand", via: :get
    match "/get_solar_power" => "sites#get_solar_power", via: :get

    #routes for site usage

    match "/get_year_usage_data_by_site" => "site_usage#get_year_usage_data_by_site", via: :get
    match "/get_year_production_data_by_site" => "site_usage#get_year_production_data_by_site", via: :get
    match "/get_month_usage_data_by_site" => "site_usage#get_month_usage_data_by_site", via: :get
    match "/get_month_production_data_by_site" => "site_usage#get_month_production_data_by_site", via: :get
    match "/get_week_usage_data_by_site" => "site_usage#get_week_usage_data_by_site", via: :get
    match "/get_week_production_data_by_site" => "site_usage#get_week_production_data_by_site", via: :get
    match "/get_day_usage_data_by_site" => "site_usage#get_day_usage_data_by_site", via: :get
    match "/get_day_production_data_by_site" => "site_usage#get_day_production_data_by_site", via: :get
    
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
