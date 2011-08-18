require 'rubygems'
require 'bundler'

Bundler.require

Encoding.default_internal = Encoding.default_external = 'UTF-8'

require './lib/bamboo'
run Bamboo.new({
  'author' => 'Mike Douglas',
  'url' => 'http://entropy.io/',
  'email' => 'hello@entropy.io'
})
