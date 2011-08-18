require 'date'

class Post < Page
  def initialize(fname)
    super(fname)
    @template = Template.new 'post.html'
    fname =~ /\/(\d{4}-\d{2}-\d{2})/
    @config['date'] = DateTime.parse($1)
  end

  def to_liquid
    super.merge({
      'paths' => ['posts'],
      'url' => '/posts/' + @config['stub']
    })
  end
end
