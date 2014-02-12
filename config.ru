require 'rack'
require 'rack/rewrite'
require 'unicorn'

use Rack::Rewrite do
  r301 '/download', '/'
  r302 '/download_stuff', '/'
end


app = proc do |env|
    [200, { 'Content-Type' => 'text/html' }, ['Hello simple rack application!']]
end
run app
