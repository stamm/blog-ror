#server '192.168.1.103', :web, :app, :db, :primary => true
server 'localhost', :web, :app, :db, :primary => true
set :deploy_to, "/Users/stamm/unicorn/#{application}-development"
set :rails_env, "production"
set :user, 'stamm'
#set :group, 'www-data'
#set :shell, '/usr/local/bin/zsh'
set :shell, '/bin/bash'
set :default_environment, {
    'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}