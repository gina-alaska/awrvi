# frozen_string_literal: true

class ManageController < ApplicationController
  def current_ability
    Ability.new(current_user, 'manage')
  end
end
