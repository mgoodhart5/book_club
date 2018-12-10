Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :show, :new, :create, :destroy] do
    resources :reviews, shallow: true, only: [:new, :create, :destroy]
  end

  root 'welcome#index'
  resources :users, only: [:show]

  resources :authors, only: [:show, :destroy]
end
