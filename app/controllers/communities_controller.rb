class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  def index
    @community = Community.all

    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @community = Community.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def create
    @community = Community.new(community_params)

    respond_to do |format|
      if @community.save
        format.html { redirect_to @community, notice: "Community #{@community.name} was created." }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render action: 'new' }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @community.update_attributes(community_params)
        format.html { redirect_to @community, notice: "Community #{@community.name} was updated." }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render action: 'edit' }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @community.destroy

    respond_to do |format|
      format.html { redirect_to communities_path, notice: "Community #{@community.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end

  def community_params
    params.require(:community).permit(:name, :gnis_id, :census_id, :location)
  end
end
