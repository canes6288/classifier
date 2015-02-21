class PredictionsController < ApplicationController
  before_action :set_prediction, only: [:show]

  # GET /predictions
  # GET /predictions.json
  def index
    @prediction = Prediction.all
  end

  # GET /predictions/1
  # GET /predictions/1.json
  def show
    @prediction = Prediction.find(params[:id])
    @male_classifier = @prediction.male_classifier
    @female_classifier = @prediction.female_classifier
  end

  # GET /predictions/new
  def new
    @prediction = Prediction.new
  end

  # GET /predictions/1/edit
  def edit
  end

  # POST /predictions
  # POST /predictions.json
  def create
    @prediction = Prediction.new(prediction_params)

    respond_to do |format|
      if @prediction.save
        format.html { redirect_to @prediction, notice: 'Prediction was successfully created.' }
        format.json { render :show, status: :created, location: @prediction }
      else
        format.html { render :new }
        format.json { render json: @prediction.errors, status: :unprocessable_entity }
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prediction
      @prediction = Prediction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prediction_params
      params.require(:prediction).permit(:id, :height, :weight)
    end
end
