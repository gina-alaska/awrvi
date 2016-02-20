# Be sure to restart your server when you modify this file.

# Require `belongs_to` associations by default. This is a new Rails 5.0 default,
# so introduced as a config to ensure apps made with earlier versions of Rails aren't affected when upgrading.

# Fix for Friendly_ID #73
# https://github.com/norman/friendly_id/issues/730
ActiveRecord::Base.belongs_to_required_by_default = true
