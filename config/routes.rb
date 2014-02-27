RedditClone::Application.routes.draw do
  root :to => 'subs#index'

  resources :users, :only => [:new, :create] do
    resources :subs, shallow: true
  end

  resource :session, :only => [:new, :create, :destroy]

end
