Rails.application.routes.draw do

  root 'public#index'
  get'show/:permalink' => 'public#show'

  get 'admin' => 'access#index'
  get 'admin/login' => 'access#login'
  post 'admin/attempt_login' => 'access#attempt_login'
  get 'admin/logout' => 'access#logout'

  get 'adminusers/index' => 'admin_users#index'
  get 'adminusers/new' => 'admin_users#new'
  post 'adminusers/create' => 'admin_users#create'
  get 'adminusers/edit' => 'admin_users#edit'
  put 'adminusers/update' => 'admin_users#update'
  get 'adminusers/delete' => 'admin_users#delete'
  delete 'adminusers/destroy' => 'admin_users#destroy'

  resources :subjects do
    member do
      get :delete
    end
    resources :pages do
      member do
        get :delete
      end
      resources :sections do
        member do
          get :delete
        end
      end
    end
  end

  # get 'subjects/index' => 'subjects#index'
  # get 'subjects/show' => 'subjects#show'
  # get 'subjects/new' => 'subjects#new'
  # post 'subjects/create' => 'subjects#create'
  # get 'subjects/edit' => 'subjects#edit'
  # put 'subjects/update' => 'subjects#update'
  # get 'subjects/delete' => 'subjects#delete'
  # delete 'subjects/destroy' => 'subjects#destroy'

  # get 'pages/index' => 'pages#index'
  # get 'pages/show' => 'pages#show'
  # get 'pages/new' => 'pages#new'
  # post 'pages/create' => 'pages#create'
  # get 'pages/edit' => 'pages#edit'
  # put 'pages/update' => 'pages#update'
  # get 'pages/delete' => 'pages#delete'
  # delete 'pages/destroy' => 'pages#destroy'

  # get 'sections/index' => 'sections#index'
  # get 'sections/show' => 'sections#show'
  # get 'sections/new' => 'sections#new'
  # post 'sections/create' => 'sections#create'
  # get 'sections/edit' => 'sections#edit'
  # put 'sections/update' => 'sections#update'
  # get 'sections/delete' => 'sections#delete'
  # delete 'sections/destroy' => 'sections#destroy'




  
end
