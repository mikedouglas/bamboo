require_relative 'page'
require_relative 'template'

class Project < Page
  def initialize(fname)
    super(fname)
    @template = Template.new 'project'
  end

  def to_liquid
    super.merge({
      'paths' => ['projects'],
      'url' => '/projects/' + @config['stub']
    })
  end
end
