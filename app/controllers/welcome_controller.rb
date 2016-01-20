class WelcomeController < ApplicationController
  def index
    @communities = Community.all
  end

  def search
  end
end
