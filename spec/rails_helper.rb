require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 90
  add_filter 'app/admin'
end

require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara'
require 'capybara/rails'
require 'capybara/rspec'
require 'yaml'
require 'i18n'
require 'capybara/poltergeist'
require 'webdrivers'
require 'selenium-webdriver'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include(Shoulda::Matchers::ActionController, { type: :model, file_path: %r{spec/controllers} })

  config.include FactoryBot::Syntax::Methods

  config.include Warden::Test::Helpers

  config.include Devise::Test::ControllerHelpers, type: :controller
end

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
Capybara.default_driver = :selenium_chrome

Capybara.javascript_driver = :poltergeist

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

module ActiveRecord
  class Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
end

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
