require 'rubygems'
require 'mocha'
$:.push(File.expand_path(File.dirname(__FILE__) + '/../lib'))
RSpec.configure do |config|
  config.mock_with :mocha
end

require 'ofx'
require 'coop_scraper'
require 'hpricot'

def full_fixture_path(fixture_dir, fixture_filename)
  File.dirname(__FILE__) + "/fixtures/#{fixture_dir}/" + fixture_filename
end

def read_fixture(fixture_filename)
  File.read(fixture_path(fixture_filename))
end