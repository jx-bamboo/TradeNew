Rails.application.routes.draw do
  root 'welcome#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  #authenticate :user, lambda { |u| u.admin? } do
  #  mount Sidekiq::Web => '/sidekiq'
  #end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
