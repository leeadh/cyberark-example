# myapp.rb
require 'sinatra'
require 'conjur-api'
require 'openssl'

get "/api" do
    Conjur.configuration.appliance_url = ENV['CONJUR_URL']
    Conjur.configuration.account = ENV['CONJUR_ACCOUNT']
    
    conjur_api= Conjur::API.new_from_key(ENV['CONJUR_USER'], ENV['CONJUR_API_KEY'])
    puts "loaded"
    value = conjur_api.resource("#{Conjur.configuration.account}:variable:db/password").value
    puts value
end

get "/" do
    <<-CONTENT
      <html>
        <head></head>
        <body>
          <h1>Welcome to the Demo App</h1>
          <p><strong>DB Password: #{retrieve_secret()}</p>
        </body>
      </html>
    CONTENT
end

def retrieve_secret()
    
    Conjur.configuration.appliance_url = ENV['CONJUR_URL']
    Conjur.configuration.account = ENV['CONJUR_ACCOUNT']
    
    conjur_api= Conjur::API.new_from_key(ENV['CONJUR_USER'], ENV['CONJUR_API_KEY'])
    puts "loaded"
    value = conjur_api.resource("#{Conjur.configuration.account}:variable:db/password").value
end
