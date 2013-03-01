ZagirovName::Application.routes.draw do
  #mount Markitup::Rails::Engine, at: "markitup", as: "markitup"

  get "/about" => "static_pages#about"
  post "/markitup/preview" => "markitup#preview"

  controller :sessions do
    get 'login' => :new, as: 'login'
    post 'login' => :create
    delete 'logout' => :destroy, as: 'logout'
  end

  root to: 'main#posts'
  #get "/" => "main#posts"
  get "/posts/page/:page" => "main#posts"

  controller :main do
    get "/tags" => :tags
  end
  get "/tag/:tag" => "main#posts", page: '1'
  get "/tag/:tag/:page" => "main#posts"

  scope "/admin" do
    get '' => 'admin#index', as: 'admin'
    resources :comments, :users
    resources :posts do
      get 'page/:page', :action => :index, :on => :collection
    end
  end

  match "/:url" => "main#article", as: :article, via: [:get, :post]

end
