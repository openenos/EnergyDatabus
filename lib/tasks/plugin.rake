namespace :db do 
  task :subdataremove , [:sub_plugin] do |t, args|
  	
  	migration_files = []
  	
  	#plugins = Dir.entries("#{Rails.root}/plugins/")

  	#plugins.shift(2)

  	#plugins.each do |plugin_dir|
    migration_files << Dir.entries("/#{Rails.root}/plugins/#{args[:sub_plugin]}/db/migrate/")
      #raise Dir.entries("#{Rails.root}/plugins/#{plugin_dir}/db/migrate/.").inspect
      #raise Rails.root.inspect
      #ActiveRecord::Migrator.rollback "#{Rails.root}/plugins/#{plugin_dir}/db/migrate/"
  	#end

  	#Rake::Task["db:migrate"].invoke
  	
  	migration_files.flatten.each do |file| 
  	  system("rake db:migrate:down VERSION=#{file.to_i}") if file.to_i!=0
  	end

  	 #ActiveRecord::Migrator.rollback "/home/eteki/IntegrationApp/plugins/NewPlugin/db/migrate/"
  	#raise migration_files.first.inspect
  	#migration_files.each do |file| 
  	  #db:migrate:down VERSION=file.first(14).to_i
  	
  	#end
  end	
end