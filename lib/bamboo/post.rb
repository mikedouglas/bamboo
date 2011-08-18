require 'date'

class Post < Page
  def initialize(fname)
    super(fname)
    @template = Template.new 'post'
    fname =~ /\/(\d{4}-\d{2}-\d{2})/
    @config['date'] = Date.parse($1)
  end

  def to_liquid
    super.merge({
      'paths' => ['posts'],
      'url' => '/posts/' + @config['stub']
    })
  end
end
