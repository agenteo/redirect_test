require 'rack'
require 'rack/rewrite'
require 'unicorn'

use Rack::Rewrite do
  rewrite '/download', '/'
  rewrite '/download_stuff', '/'
end


app = proc do |env|
    [200, { 'Content-Type' => 'text/html' }, ['Hello simple rack application!']]
end
run app
