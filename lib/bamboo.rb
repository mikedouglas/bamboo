require 'sinatra'
require_relative 'bamboo/project'
require_relative 'bamboo/template'

class Bamboo < Sinatra::Base
  set :public, 'static'

  def initialize
    @projects = Project.collect 'projects'
    @pages = Page.collect 'pages'
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

  get '/:name' do |name|
    @pages[name].html
  end
end
