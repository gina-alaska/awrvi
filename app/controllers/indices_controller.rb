class IndicesController < ApplicationController
  layout 'communities'

  before_action :set_community, only: [:index, :create, :new]
  before_action :set_index, only: [:show, :edit, :update, :destroy, :finalize]

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
    category = Category.root
    @index = @community.indices.build awrvi_version: category
  end

  # GET /indices/1/edit
  def edit
  end

  # POST /indices
  # POST /indices.json
  def create
    @index = @community.indices.build(index_params)
    @index.user_id = current_user

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

  def finalize
    respond_to do |format|
      if @index.update(finalized_at: Time.zone.now)
        format.html { redirect_to @index, notice: 'Index was successfully finalized.' }
        format.json { render :show, status: :ok, location: @index }
      else
        format.html { redirect_to @index, error: 'Finalize index was not successful.' }
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
      :finalized_at, :awrvi_version_id, :awrvi_index,
      :rejected_at, :rejected_reason,
      index_category_choices_attributes: [:category_id, :choice_id, :id])
  end
end
