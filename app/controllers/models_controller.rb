class ModelsController < ApplicationController
  before_action :set_model, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index show]  

  # GET /models or /models.json
  def index
    @models = Model.where(brand_id: params[:brand_id])
    authorize @models
  end

  # GET /models/1 or /models/1.json
  def show
    @model = Model.find(params[:id])
    authorize @model
  end

  # GET /models/new
  def new
    authorize :model, :new?
    @model = Model.new
  end

  # GET /models/1/edit
  def edit
    authorize :model, :edit?
  end

  # POST /models or /models.json
  def create
    authorize :model, :create?
    @model = Model.new(model_params)

    respond_to do |format|
      if @model.save
        format.html { redirect_to model_url(@model), notice: "Model was successfully created." }
        format.json { render :show, status: :created, location: @model }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /models/1 or /models/1.json
  def update
    authorize :model, :update?
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to model_url(@model), notice: "Model was successfully updated." }
        format.json { render :show, status: :ok, location: @model }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1 or /models/1.json
  def destroy
    authorize :model, :destroy?
    @model.destroy

    respond_to do |format|
      format.html { redirect_to models_url, notice: "Model was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def model_params
      params.require(:model).permit(:name, :brand_id)
    end
end
