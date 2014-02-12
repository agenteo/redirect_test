require 'rack'
require 'rack/rewrite'
require 'unicorn'

use Rack::Rewrite do
  r301 '/download', '/'
  r302 '/download_stuff', '/'
  r301 %r{/regexp_test/(\w*)},    '/?$1'
end


app = proc do |env|
    [200, { 'Content-Type' => 'text/html' }, ['Hello simple rack application!']]
end
run app
