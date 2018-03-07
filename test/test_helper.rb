# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 2

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  include Warden::Test::Helpers

  Warden.test_mode!

  def login(user)
    u = users(user)
    visit('/users/auth/developer')
    fill_in('Name', with: u.name)
    fill_in('Email', with: u.email)
    click_button('Sign In')
  end

  def logout
    visit('/')
    click_on('Sign Out')
  end
end
