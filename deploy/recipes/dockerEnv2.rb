Chef::Log.info("Setting environment variables")

Chef::Log.info("Setting environment variables for current process")

Chef::Log.info("Setting environment variables for current process")
Chef::Log.info("JP- Node Env----")

# Chef::Log.info(node[:environment_variables])
# Chef::Log.info(node[:deploy][APP_SHORTNAME][:environment_variables])
# Chef::Log.info(deploy[:environment_variables])


node[:deploy].each do |current_path, deploy, environment_variables|

	Chef::Log.info(deploy[:environment_variables])
	deploy[:environment_variables].each do |name, value|
		ENV["#{name}"] = "#{value}"
	end

	Chef::Log.info("Writing variables to /etc/environment/prisma to have them after restart")
	Chef::Log.info(deploy[:current_path])
	Chef::Log.info("ha ha")
	Chef::Log.info(File.directory?('/srv/www/serversetup_demo/current'))
	if(File.directory?('/srv/www/serversetup_demo/current')) 
	     Chef::Log.info("if")
	     template "/srv/www/serversetup_demo/current/.env" do
                source "environment.erb"
                mode "0644"
                owner "ubuntu"
                group "ubuntu"
		variables({
		  :environment_variables => deploy[:environment_variables]
		})
	 else	
		Chef::Log.info("else")     
    	  end
	end
	
	
end
Chef::Log.info("JP- Node END")
