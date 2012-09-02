require "rvm/capistrano"
require 'bundler/capistrano'
require 'capistrano_colors'

set :application, "ror-unicorn"
set :repository,  "git://github.com/Stamm/ror-unicorn.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "50.17.209.45", :web, :app
default_run_options[:pty] = true
set :using_rvm, true
set :rvm_type, :user
set :scm_verbose, true
#set :deploy_via, :remote_cache
set :user, 'www-data'
set :use_sudo, false
#set :stack, :passenger
after "deploy:update", "deploy:cleanup"
set :branch, "master"
set :keep_releases, 4
set :deploy_to, '/var/www/test.am.zagirov.name'
set :bundle_without, [:test, :development]



#role :app, "50.17.209.45"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end