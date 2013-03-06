server "174.129.240.218", :web, :app, :db, :primary => true
set :deploy_to, "/var/www/#{application}-staging"
set :rails_env, "production"
set :user, 'www-data'
set :group, 'www-data'