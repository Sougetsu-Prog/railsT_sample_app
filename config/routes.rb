Rails.application.routes.draw do
  # root 'info#index' でinfoコントローラのindexアクションを呼び出す
  root 'static_pages#home'
  get '/help', to:'static_pages#help'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'
  get '/signup', to:'users#new'
  # ユーザーのURLを作成するための名前付きルート・Usersリソースで必要なアクションを利用できるようになる
  resources :users
end
