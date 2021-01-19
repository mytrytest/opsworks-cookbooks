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
	if(File.directory?(deploy[:current_path]))
		Chef::Log.info("directory available")
	else
		Chef::Log.info("directory not available")
	end
	#if(File.directory?('/srv/www/serversetup_demo/current')) 
	if(File.directory?(deploy[:current_path]))
	     Chef::Log.info("if")
	     #template "/srv/www/serversetup_demo/current/.env" do
             template "#{deploy[:current_path]}/.env" do
                source "environment.erb"
                mode "0644"
                owner "ubuntu"
                group "ubuntu"
		variables({
		  :environment_variables => deploy[:environment_variables]
		})
	     end
	     #execute("cd #{deploy[:current_path]} && sudo docker-compose up -d")
	     #Chef::Log.info("docker up")
	     #execute("sudo mkdir #{deploy[:current_path]}/src")
	     #execute("sudo mkdir #{deploy[:current_path]}/src/generated")
	     IS_RUNNING= `sudo docker ps -q`
	     Chef::Log.info("docker checking")
	     Chef::Log.info(IS_RUNNING)
	     if(IS_RUNNING == '')
		Chef::Log.info("no docker")  
		execute("cd #{deploy[:current_path]} && sudo docker-compose up -d")
		Chef::Log.info("waiting")
		sleep(150)
		
	     else
		Chef::Log.info("docker exist")  
		Chef::Log.info("start prisma deploy")
	        execute("cd #{deploy[:current_path]} && sudo prisma1 deploy")
	        Chef::Log.info("prisma deploy")     
	     end
	     
	    
	 else	
		Chef::Log.info("else")     
    	 end

end
Chef::Log.info("JP- Node END")
