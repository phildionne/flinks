require 'flinks'

Dir[File.dirname(__FILE__) + '/shared/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.filter_run focus: true
  config.filter_run_excluding skip: true
  config.run_all_when_everything_filtered = true
end
