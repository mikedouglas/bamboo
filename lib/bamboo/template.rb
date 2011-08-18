require 'liquid'
require 'cgi'
require 'time'

class Template
  include YAMLable

  def initialize(fname)
    @config, @body = filter_config(File.read("templates/" + fname, :encoding => 'UTF-8'))
    @body = Liquid::Template.parse(@body)
  end

  def render(hash)
    out = @body.render(hash, {:filters => [Filters]})
    if @config && @config['layout']
      template = Template.new(@config['layout'])
      template.render(hash.merge(@config.merge({'content' => out})))
    else
      out
    end
  end
end

# borrowed from Jekyll
module Filters
  def date_to_xmlschema(date)
    date.xmlschema
  end

  def xml_escape(input)
    CGI.escapeHTML(input)
  end
end
