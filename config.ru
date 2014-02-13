require 'rack'
require 'unicorn'

REDIRECT_MESSAGE = 'Redirecting now.'

app = proc do |env|
  case env['REQUEST_PATH']

  when '/download'
    [301, { 'Content-Type' => 'text/html', 'Location' => '/?from=download'}, [REDIRECT_MESSAGE]]

  when '/hello'
    [301, { 'Content-Type' => 'text/html', 'Location' => '/?from=hello'}, [REDIRECT_MESSAGE]]

  when '/'
    message = <<EOF
    <h1>Fake redirect landing page</h1>
    <p>Lucky you, I could find your stuff!</p>
    <p>Query string? #{env['QUERY_STRING']}</p>
    <pre>#{env}</pre>
EOF
    [200, { 'Content-Type' => 'text/html' }, [message]]

  else
    message = <<EOF
    <h1>Fallback</h1>
    <p>I couldn't find your stuff</p>
    <pre>#{env}</pre>
EOF
    [200, { 'Content-Type' => 'text/html' }, [message]]
  end
end
run app
