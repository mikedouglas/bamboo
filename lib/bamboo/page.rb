require_relative 'markdown'
require_relative 'yamlable'

class Page
  include YAMLable

  attr_reader :config, :body

  # returns a map of stubs to page-like objects
  def self.collect(dir)
    Dir[dir + '/*'].reduce({}) do |map, fname|
      fname =~ /\/([^\/\.]+).[^.\/]+/
      map[$1] = self.new(File.read(fname, :encoding => 'UTF-8')); map
    end
  end

  def initialize(text)
    @config, @body = filter_config(text)
    @template = Template.new 'page'
  end

  def html
    content = Markdown.convert(@body)
    if @config
      @template.render({'content' => content, 'page' => self})
    else
      content
    end
  end

  def to_liquid
    @config
  end
end
