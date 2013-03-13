Trackfit::Application.routes.draw do
  get  '/'          => 'main#index'
  post '/track'     => 'workout#track'
  get  '/standings' => 'report#standings'
  get  '/winner'    => 'report#winner'
  post '/winner'    => 'report#winner'
end
