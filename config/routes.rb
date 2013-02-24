ZagirovName::Application.routes.draw do
  #mount Markitup::Rails::Engine, at: "markitup", as: "markitup"

  match "/about" => "static_pages#about"
  match "/markitup/preview" => "markitup#preview"

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


  scope "/admin" do
    resources :posts, :comments
  end

  match "/:url" => "main#article", as: :article

end
