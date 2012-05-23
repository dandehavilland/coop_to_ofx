require 'rubygems'
require 'mocha'

$:.push(File.expand_path(File.dirname(__FILE__) + '/../lib'))

Dir[File.expand_path(File.dirname(__FILE__) + "/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :mocha
  config.include FixtureMacros
end

require 'ofx'
require 'coop_scraper'
require 'hpricot'