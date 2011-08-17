require_relative 'page'
require_relative 'template'

class Project < Page
  def html
    if @config
      template = Template.new("project")
      template.render({'content' => super, 'page' => self})
    else
      super
    end
  end

  def to_liquid
    super.merge({
      'paths' => ['projects'],
      'url' => '/projects/' + @config['title']
    })
  end
end
