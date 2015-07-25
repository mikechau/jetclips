JetclipApi::Application.routes.draw do
  get '/status', to: 'status#index', defaults: { format: 'json' }

  scope '/api/v1' do
    get '/videos/:id', to: 'videos#index', as: :videos, defaults: { format: 'json' }
    get '/video/:id', to: 'videos#show', as: :video, defaults: { format: 'json' }
  end
end
