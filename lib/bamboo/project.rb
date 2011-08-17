require_relative 'page'
require_relative 'template'

class Project < Page
  def initialize(text)
    super(text)
    @template = Template.new 'project'
  end

  def to_liquid
    super.merge({
      'paths' => ['projects'],
      'url' => '/projects/' + @config['title']
    })
  end
end
