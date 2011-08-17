require 'yaml'

module YAMLable
  protected
  # returns [map of headers, body]
  def filter_config(text)
    if text =~ /^---\n(.*)^---\n(.*)/m
      return YAML.load($1) || {}, $2
    else
      return nil, text
    end
  end
end
