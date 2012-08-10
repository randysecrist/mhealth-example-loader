MhealthExampleLoader::Application.routes.draw do
  root to: 'high_voltage/pages#show', id:'index'

  match '/start' => 'authorization#new', as: 'new_authorization'
  match '/auth/:provider/callback' => 'authorization#update'
end
