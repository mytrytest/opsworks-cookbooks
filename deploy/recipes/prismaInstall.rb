include_recipe 'deploy'
Chef::Log.info("prisma install")

execute("sudo npm install -g prisma1")
execute(" sudo npm install -g dotenv")
#execute("cd #{deploy[:current_path]} && sudo docker-compose up -d")

