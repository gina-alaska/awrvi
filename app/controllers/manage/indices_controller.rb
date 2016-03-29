class Manage::IndicesController < ManageController
  authorize_resource
  before_action :set_index, only: [:edit, :update]

  # GET /manage/indices/1/edit
  def edit
  end

  # PATCH/PUT /manage/indices/1
  # PATCH/PUT /manage/indices/1.json
  def update
    respond_to do |format|
      if @index.update(index_params.merge(hidden_at: Time.zone.now))
        format.html { redirect_to @index, notice: 'Index was successfully updated.' }
        format.json { render :show, status: :ok, location: @index }
      else
        format.html { render :edit }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_index
    @index = Index.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def index_params
    params.require(:index).permit(:hidden, :hidden_reason)
  end
end
