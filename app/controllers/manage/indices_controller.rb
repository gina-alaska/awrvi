class Manage::IndicesController < ManageController
  before_action :set_index, only: [:edit, :update]
  authorize_resource

  # GET /manage/indices/1/edit
  def edit
  end

  # PATCH/PUT /manage/indices/1
  # PATCH/PUT /manage/indices/1.json
  def update
    hidden_params = index_params.merge(hidden_at: Time.zone.now, hidden: true)
    respond_to do |format|
      if @index.update(hidden_params)
        format.html { redirect_to communities_path, notice: 'Index was successfully updated.' }
        format.json { render :show, status: :ok, location: communities_path }
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
    params.require(:index).permit(:hidden_reason)
  end
end
