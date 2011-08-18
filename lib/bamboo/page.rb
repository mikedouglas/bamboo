require_relative 'markdown'
require_relative 'yamlable'
require 'digest'

class Page
  include YAMLable
  include Comparable

  attr_reader :last_modified, :config

  # returns a map of stubs to page-like objects
  def self.collect(dir)
    Dir[dir + '/*'].reduce({}) do |map, fname|
      fname =~ /\/([^\/\.]+).[^.\/]+/
      map[$1] = self.new(fname); map
    end
  end

  def initialize(fname)
    @config, @body = filter_config(File.read(fname, :encoding => 'UTF-8'))
    @last_modified = File.mtime(fname)
    @template = Template.new 'page'
    fname =~ /\/([^\/\.]+).[^.\/]+/
    @config['stub'] = $1
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

  def sha1
    Digest::SHA1.hexdigest(@body)
  end

  def <=>(other)
    (@config['date'] || @last_modified) <=> (other.config['date'] || other.last_modified)
  end
end
