require_relative 'page'
require 'yaml'
require 'liquid'

class Project < Page
  def html
    content = super
    config, template = filter_config(File.read('templates/project.html'))
    html = Liquid::Template.parse(template).render({'page' => self, 'content' => content})

    if config
      template = File.read('templates/' + (config['layout'] || 'layout') + '.html')
      Liquid::Template.parse(template).render(config.merge({'page' => self, 'content' => html}))
    else
      html
    end
  end

  def to_liquid
    super.merge({
      'paths' => ['projects']
    })
  end
end
