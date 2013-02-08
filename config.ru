use Rack::Deflater

require ::File.expand_path('../config/environment',  __FILE__)
run Trackfit::Application
