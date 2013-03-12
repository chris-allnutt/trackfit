Trackfit::Application.routes.draw do
  get '/' => 'main#index'
  post '/track' => 'workout#track'
  get '/standings' => 'report#standings'
end
