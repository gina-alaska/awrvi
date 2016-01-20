class WelcomeController < ApplicationController
  def index
    @q = Community.ransack(params[:q])
  end
end
