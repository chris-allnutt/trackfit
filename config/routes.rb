Trackfit::Application.routes.draw do
  get '/' => 'main#index'
  post '/track' => 'workout#track'
end
