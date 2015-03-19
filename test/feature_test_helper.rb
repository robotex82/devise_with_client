require "test_helper"
require "minitest/rails/capybara"

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

class MiniTest::Spec
  before :each do
    DatabaseCleaner.clean
  end
end

class MiniTest::Spec
  include AuthenticationHelper
end

require 'user'
class User < ActiveRecord::Base
  # Constants
  DEFAULT_PASSWORD = 'password'
end
