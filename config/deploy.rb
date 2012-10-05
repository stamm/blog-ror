require "rvm/capistrano"
require 'bundler/capistrano'
require 'capistrano_colors'

default_run_options[:pty] = true

set :application, "blog-ror"
set :repository,  "git://github.com/Stamm/blog-ror.git"


set :rails_env, "production"
set :using_rvm, true
set :rvm_type, :user


server "174.129.240.218", :web, :app
set :user, 'www-data'
set :use_sudo, false


set :scm, :git
set :scm_verbose, true
set :deploy_via, :remote_cache
set :branch, "master"
set :keep_releases, 4
set :deploy_to, "/var/www/#{application}"


after "deploy:update", "deploy:cleanup"
set :bundle_without, [:test, :development]


set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

# интеграция rvm с capistrano настолько хороша, что при выполнении cap deploy:setup установит себя и указанный в rvm_ruby_string руби.
before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby'

####################

##set :rvm_ruby_string, 'ree' # Это указание на то, какой Ruby интерпретатор мы будем использовать.
#set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
set :rvm_ruby_string, 'ruby-1.9.3-p194@gemset'


after 'deploy:update_code', :roles => :app do
  # Здесь для примера вставлен только один конфиг с приватными данными - database.yml.
  # Обычно для таких вещей создают папку /srv/myapp/shared/config и кладут файлы туда.
  # При каждом деплое создаются ссылки на них в нужные места приложения.
  run "rm -f #{current_release}/config/database.yml"
  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
end

# Далее идут правила для перезапуска unicorn. Их стоит просто принять на веру - они работают.
namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end