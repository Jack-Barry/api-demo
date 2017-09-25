Rails.application.routes.draw do
  get    'examples',     to: 'examples#index'
  get    'examples/:id', to: 'examples#show'
  post   'examples',     to: 'examples#create'
  put    'examples/:id', to: 'examples#update'
  delete 'examples/:id', to: 'examples#destroy'
end
