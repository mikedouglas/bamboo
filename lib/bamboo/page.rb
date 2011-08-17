require_relative 'markdown'
require_relative 'yamlable'

class Page
  include YAMLable

  attr_reader :config, :body

  # returns a map of stubs to page-like objects
  def self.collect(dir)
    Dir[dir + '/*'].reduce({}) do |map, fname|
      fname =~ /\/([^\/\.]+).[^.\/]+/
      map[$1] = self.new(File.read(fname, :encoding => "UTF-8")); map
    end
  end

  def initialize(text)
    @config, @body = filter_config(text)
  end

  def html
    Markdown.convert(@body)
  end

  def to_liquid
    @config
  end
end
