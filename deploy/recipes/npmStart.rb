include_recipe 'deploy'
Chef::Log.info("Ready to Deploy")
Chef::Log.info(node[:deploy])

node[:deploy].each do |current_path, deploy|
  Chef::Log.info("npm start --prefix #{deploy[:current_path]}");
#   Remove this tag comment in when we are going to user npm start.
  execute("sudo npm start --prefix #{deploy[:current_path]} &")
#   Chef::Log.info("sudo node #{deploy[:current_path]}/server.js &")
#   execute("sudo node #{deploy[:current_path]}/server.js &")
  Chef::Log.info("JP Custome Deployment Done")
end
