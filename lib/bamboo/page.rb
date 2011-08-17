require_relative 'markdown'
require 'yaml'

class Page
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

  protected
  # returns [map of headers, body]
  def filter_config(text)
    if text =~ /^---\n(.*)^---\n(.*)/m
      return YAML.load($1), $2
    else
      return {}, text
    end
  end
end
