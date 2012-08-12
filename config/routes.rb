MhealthExampleLoader::Application.routes.draw do
  root to: 'high_voltage/pages#show', id:'index'

  match '/start' => 'authorization#new', as: 'new_authorization'
  match '/auth/:provider/callback' => 'authorization#update'

  match '/logout' => 'authorization#destroy', as: 'destroy_authorization'

  resource 'sample'

  mount SinatraExample, at: '/api/v1'
end
