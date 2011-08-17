require 'liquid'

class Template
  include YAMLable

  def initialize(fname)
    @config, @body = filter_config(File.read("templates/" + fname + ".html"))
    @body = Liquid::Template.parse(@body)
  end

  def render(hash)
    out = @body.render(hash)
    if @config
      template = Template.new(@config['layout'] || 'layout')
      template.render(hash.merge(@config.merge({'content' => out})))
    else
      out
    end
  end
end
