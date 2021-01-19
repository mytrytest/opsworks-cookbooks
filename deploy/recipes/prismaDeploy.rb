Chef::Log.info("Docker start and prisma deploy")


node[:deploy].each do |current_path, deploy, environment_variables|

	Chef::Log.info(deploy[:environment_variables])
	deploy[:environment_variables].each do |name, value|
		ENV["#{name}"] = "#{value}"
	end

	Chef::Log.info("Writing variables to ./env file")
	#if(File.directory?('/srv/www/serversetup_demo/current')) 
	if(File.directory?(deploy[:current_path]))
	     Chef::Log.info("directory available")
	     template "#{deploy[:current_path]}/.env" do
                source "environment.erb"
                mode "0644"
                owner "ubuntu"
                group "ubuntu"
                variables({
                  :environment_variables => deploy[:environment_variables]
                })
	     end
	     #execute("sudo mkdir #{deploy[:current_path]}/src")
	     #execute("sudo mkdir #{deploy[:current_path]}/src/generated")
	     IS_RUNNING= `sudo docker ps -q`
	     Chef::Log.info(IS_RUNNING)
	     if(IS_RUNNING == '')
		      Chef::Log.info("to start docker")  
		      execute("cd #{deploy[:current_path]} && sudo docker-compose up -d")
		 		  sleep(10)
		   else
		      Chef::Log.info("start prisma deploy")
	        execute("cd #{deploy[:current_path]} && sudo prisma1 deploy")
	     end
	 else	
		Chef::Log.info("no current directory")     
 	 end

end
Chef::Log.info("Prisma deploy end")
