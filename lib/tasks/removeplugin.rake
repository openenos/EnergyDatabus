task :subpluginremove , [:sub_plugin] do |t, args|
  system("rm -rf plugins/#{args[:sub_plugin]}")	
end