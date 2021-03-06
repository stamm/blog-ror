ZagirovName::Application.routes.draw do
  constraints format: // do
    root to: 'main#posts'
    get '/about' => 'static_pages#about', as: 'about'
    post '/markitup/preview' => 'markitup#preview'

    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end

    namespace :admin do
      get '' => 'admin#index'
      resources :users
      resources :comments do
        member do
          put 'spam' => 'comments#spam', as: :spam
          put 'approve' => 'comments#approve', as: :approve
        end
      end
      resources :posts do
        get 'page/:page', action: :index, on: :collection
      end
    end

    controller :main do
      get '/posts/page/:page' => :posts
      get '/tags' => :tags
      get '/tag/:tag' => :posts, page: '1'
      get '/tag/:tag/:page' => :posts
      get '/search' => :search
      get '/search/page/:page' => :search
      match '/:url' => :article, url: /[^\/]+/, as: :article,
            via: [:get, :post]
    end
  end
end
