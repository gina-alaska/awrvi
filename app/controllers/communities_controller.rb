# frozen_string_literal: true

class CommunitiesController < ApplicationController
  include IndexReviewConcerns

  helper_method :search_params

  before_action :set_community, only: %i[show edit update destroy]
  before_action :fetch_latest_community_index, only: [:show]
  before_action :fetch_users_review_for_index, only: [:show]

  authorize_resource

  # GET /communities
  # GET /communities.json
  def index
    @search_text = search_params[:q]

    ##    If showing all is the behavior desired uncomment next 2 ruby lines and
    ## comment out the lines after the next comment section.
    # @communities = Community.all
    # @communities = Community.where('name ilike ?', "%#{@search_text}%") if search_params.present?

    ##    This fools the search to find the community "" an empty
    ## which does not exist, so communites will only show up when searced
    ## for directly(The second line).
    @communities = Community.where('name ilike ?', "")
    @communities = Community.where('name ilike ?', "%#{@search_text}%") if search_params.present? && @search_text != ''

    redirect_to community_path(@communities.first) if @communities.count == 1
    @communities = @communities.order(:name).page(params[:page])
  end

  # GET /communities/1
  # GET /communities/1.json
  def show; end

  # GET /communities/new
  def new
    @community = Community.new
  end

  # GET /communities/1/edit
  def edit; end

  # POST /communities
  # POST /communities.json
  def create
    @community = Community.new(community_params)

    respond_to do |format|
      if @community.save
        format.html { redirect_to @community, notice: 'Community was successfully created.' }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    respond_to do |format|
      if @community.update(community_params)
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    @community.destroy
    respond_to do |format|
      format.html { redirect_to communities_url, notice: 'Community was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def fetch_latest_community_index
    @index ||= @community.current_index
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_community
    @community = Community.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def community_params
    params.require(:community).permit(:name, :gnis_id, :census_id, :location)
  end

  def search_params
    params.permit(:q)
  end
end
