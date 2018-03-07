# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.1'

gem 'coffee-rails', '~> 4.1.0'
gem 'pg', '0.21.0'
gem 'rails', '>= 5.0.0', '< 5.1'
gem 'sass-rails', '~> 5.0.4'
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'cancancan'
gem 'closure_tree'
gem 'devise', github: 'plataformatec/devise'
gem 'dotenv-rails'
gem 'foreman'
gem 'friendly_id'
gem 'haml'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'kaminari', git: 'https://github.com/amatsuda/kaminari.git' # Master has the fixes needed for rails 5
gem 'kramdown', require: 'tilt/kramdown'
gem 'omniauth'
gem 'omniauth-openid'
gem 'puma'
gem 'simple_form'
gem 'turbolinks', '~> 5.0.0.beta'

gem 'active_link_to'
gem 'georuby', require: ['georuby', 'geo_ruby/ewk', 'geo_ruby/geojson']
gem 'high_voltage', github: 'thoughtbot/high_voltage'
gem 'rails_12factor', group: :production

group :development, :test do
  gem 'byebug'
  gem 'capybara'
  gem 'poltergeist'
  gem 'rubocop'
end

group :development do
  gem 'pry-rails'
  gem 'spring'
  gem 'web-console', '~> 3.0'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
end
gem "font-awesome-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
