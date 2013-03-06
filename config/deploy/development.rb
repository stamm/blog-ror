server "localhost", :web, :app, :db, :primary => true
set :deploy_to, "/Users/stamm/unicorn/#{application}-development"
set :rails_env, "production"
set :user, 'stamm'
#set :group, 'www-data'