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

  before do
    if ENV['RACK_ENV'] == "production"
      cache_control :public, :max_age => 36000
    else
      cache_control :no_cache, :must_revalidate
    end
  end

  get '/' do
    'Hello world!'
  end

  get '/projects' do
    Template.new("projects").render({'projects' => @projects.values})
  end

  get '/projects/:name' do |name|
    page = @projects[name] || not_found("404")
    last_modified page.last_modified
    etag page.sha1
    page.html
  end

  get '/:name' do |name|
    page = @pages[name] || not_found("404")
    last_modified page.last_modified
    etag page.sha1
    page.html
  end
end
