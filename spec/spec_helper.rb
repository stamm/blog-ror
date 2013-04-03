require 'rubygems'


if ENV['TRAVIS']
  # get stats only on ruby engine, exclude rubinius
  if RUBY_ENGINE.downcase.to_sym == :ruby
    require 'coveralls'
    Coveralls.wear! 'rails'
  end
elsif ! ENV['DRB']
  require 'simplecov'
  SimpleCov.start 'rails'
end




# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/rspec'
require 'ffaker'
require 'paperclip/matchers'

I18n.default_locale = :ru
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers

  config.include LoginMacros

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = true
  # Use the fail_fast option to tell RSpec to abort the run on first failure
  config.fail_fast = true
  # If set true set symbols without value to true
  config.treat_symbols_as_metadata_keys_with_true_values = true

end


