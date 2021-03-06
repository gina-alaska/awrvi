# frozen_string_literal: true

class IndicesController < ApplicationController
  include IndexReviewConcerns

  layout 'communities'

  before_action :set_community, only: %i[index create new]
  before_action :set_index, only: %i[show edit update destroy publish]
  before_action :fetch_users_review_for_index, only: [:show]

  authorize_resource

  # GET /indices
  # GET /indices.json
  def index
    @indices = @community.indices
  end

  # GET /indices/1
  # GET /indices/1.json
  def show
    @community = @index.community
  end

  # GET /indices/new
  def new
    category = Category.active_root.first
    @index = @community.indices.build awrvi_version: category
  end

  # GET /indices/1/edit
  def edit; end

  # POST /indices
  # POST /indices.json
  def create
    @index = @community.indices.build(index_params)
    @index.user = current_user

    respond_to do |format|
      if @index.save
        format.html { redirect_to @index, notice: 'Index was successfully created.' }
        format.json { render :show, status: :created, location: @index }
      else
        format.html { render :new }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indices/1
  # PATCH/PUT /indices/1.json
  def update
    respond_to do |format|
      if @index.update(index_params)
        format.html { redirect_to @index, notice: 'Index was successfully updated.' }
        format.json { render :show, status: :ok, location: @index }
      else
        format.html { render :edit }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indices/1
  # DELETE /indices/1.json
  def destroy
    @index.destroy
    respond_to do |format|
      format.html { redirect_to community_url(@index.community), notice: 'Index was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish
    respond_to do |format|
      if @index.publish!
        format.html { redirect_to @index, notice: 'Index was successfully published.' }
        format.json { render :show, status: :ok, location: @index }
      else
        format.html { redirect_to @index, error: 'Publishing index was not successful.' }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_index
    @index = Index.find(params[:id])
  end

  def set_community
    @community = Community.friendly.find(params[:community_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def index_params
    params.require(:index).permit(
      :published_at, :awrvi_version_id, :awrvi_index,
      index_category_choices_attributes: %i[category_id choice_id id]
    )
  end
end
