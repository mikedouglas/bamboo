require 'pandoc-ruby'

class Markdown
  def self.convert(text)
    PandocRuby.convert(text, {:f => :markdown, :to => :html}, :smart, :html5, 'email-obfuscation=references')
  end
end
