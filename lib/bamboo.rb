require 'sinatra'
require_relative 'bamboo/project'
require_relative 'bamboo/template'

class Bamboo < Sinatra::Base
  set :public, 'static'

  def initialize
    @projects = Project.collect 'projects'
    super
  end

  get '/' do
    'Hello world!'
  end

  get '/projects' do
    Template.new("projects").render({'projects' => @projects.values})
  end

  get '/projects/:name' do |name|
    @projects[name].html
  end
end
