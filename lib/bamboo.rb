require 'sinatra'
require_relative 'bamboo/project'
require_relative 'bamboo/post'
require_relative 'bamboo/template'

class Bamboo < Sinatra::Base
  set :public, 'static'

  def initialize(config)
    @site = config
    @projects = Project.collect 'projects'
    @pages = Page.collect 'pages'
    @posts = Post.collect 'posts'
    @site['posts'] = @posts.values.sort {|a, b| b <=> a }
    @site['time'] = @site['posts'].first.last_modified
    super
  end

  def index(coll, name)
    Template.new(name+'.html').render({name => coll.values.sort {|a, b| b <=> a}})
  end

  before do
    if ENV['RACK_ENV'] == 'production'
      cache_control :public, :max_age => 36000
    else
      cache_control :no_cache, :must_revalidate
    end
  end

  get '/' do
    cache_control :no_cache, :must_revalidate
    halt 307, {'Location' => 'http://github.com/mikedouglas'}, ''
  end

  get '/posts' do
    index @posts, 'posts'
  end

  get '/posts/:title' do |title|
    post = @posts[title] || not_found('404')
    last_modified post.last_modified
    etag post.sha1
    post.html
  end

  get '/projects' do
    index @projects, 'projects'
  end

  get '/projects/:name' do |name|
    page = @projects[name] || not_found('404')
    last_modified page.last_modified
    etag page.sha1
    page.html
  end

  get '/:name' do |name|
    page = @pages[name] || not_found('404')
    last_modified page.last_modified
    etag page.sha1
    page.html
  end
end
