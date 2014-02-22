JetclipApi::Application.routes.draw do
  scope 'api/v1' do
    get 'videos/:id', to: 'videos#show', as: :videos
  end
end
