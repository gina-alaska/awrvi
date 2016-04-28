class ReviewsController < ApplicationController
  before_action :set_index
  before_action :set_review, only: :destroy
  authorize_resource

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = @index.reviews.build(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review.index, notice: 'Index was marked as reviewed' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @review.index, notice: 'Index is no longer marked as reviewed' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def review_params
    { user: current_user }
  end

  def set_index
    @index = Index.find(params[:index_id]) if params[:index_id].present?
  end
end
