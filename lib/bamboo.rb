require 'sinatra'

class Bamboo < Sinatra::Base
  get '/' do
    'Hello world!'
  end

  get '/projects/:name' do |name|
    name
  end
end
