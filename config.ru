require 'rack'
require 'unicorn'
require 'redis'

redis = Redis.new(:host => "127.0.0.1", :port => 6379)
redis.set('/casa', 'home')

REDIRECT_MESSAGE = 'Redirecting now.'

app = proc do |env|
  value = redis.get(env['REQUEST_PATH'])

  if value.nil? || value == '/' 
    message = <<EOF
    <h1>Fake redirect landing page</h1>
    <p>Lucky you, I could find your stuff!</p>
    <p>Query string? #{env['QUERY_STRING']}</p>
    <pre>#{env}</pre>
EOF
    [200, { 'Content-Type' => 'text/html' }, [message]]
  else
    [301, { 'Content-Type' => 'text/html', 'Location' => "/?go_to=#{value}"}, [REDIRECT_MESSAGE]]
  end
end
run app
