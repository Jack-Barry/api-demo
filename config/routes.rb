Rails.application.routes.draw do
  post   'examples',             to: 'examples#create'
  get    'examples',             to: 'examples#index'
  get    'examples/validations', to: 'examples#validations'
  get    'examples/:id',         to: 'examples#show'
  put    'examples/:id',         to: 'examples#update'
  delete 'examples/:id',         to: 'examples#destroy'

  post    'auth/login',          to: 'authentication#authenticate'
end
