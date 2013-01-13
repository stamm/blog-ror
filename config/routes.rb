ZagirovName::Application.routes.draw do



  match "/about" => "static_pages#about"
  match "/ajax/markitup" => "ajax#markitup"

  get "admin" => 'admin#index'

  #resources :users

  controller :sessions do
    get 'login' => :new, as: 'login'
    post 'login' => :create
    delete 'logout' => :destroy, as: 'logout'
  end

  controller :main do
    match "/tags" => :tags
  end

  root to: 'main#posts', page: 1
  match "/posts/page/:page" => "main#posts"
  match "/tag/:tag" => "main#posts", page: 1
  match "/tag/:tag/:page" => "main#posts"

  resources :posts
  resources :comments

  match "/:url" => "main#article", as: :article

end
