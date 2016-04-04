source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '>= 5.0.0.beta1', '< 5.1'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks', '~> 5.0.0.beta'
gem 'jbuilder', '~> 2.0'
gem 'puma'
gem 'foreman'
gem 'haml'
gem 'dotenv-rails'
gem 'friendly_id'
gem 'closure_tree'
gem 'simple_form'
gem 'devise', github: 'plataformatec/devise'
gem 'omniauth'
gem 'omniauth-openid'
gem 'cancancan'
gem 'kaminari', git: 'https://github.com/amatsuda/kaminari.git' # Master has the fixes needed for rails 5
gem 'kramdown', require: 'tilt/kramdown'

gem 'rails_12factor', group: :production
gem 'high_voltage', github: 'thoughtbot/high_voltage'
gem 'georuby', require: ['georuby', 'geo_ruby/ewk', 'geo_ruby/geojson']
gem 'active_link_to'

group :development, :test do
  gem 'byebug'
  gem 'rubocop'
  gem 'capybara'
  gem 'poltergeist'
end

group :development do
  gem 'web-console', '~> 3.0'
  gem 'spring'
  gem 'pry-rails'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
end
gem "font-awesome-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
