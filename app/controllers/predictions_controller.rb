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
    # what param or code do i need to use to get the numbers the user entered in for predictions
    prediction_weight = Prediction.find(params[:id]).weight
    prediction_height = Prediction.find(params[:id]).height

    @posterior_male_height = Classifier.posterior_height(prediction_height, "male")
    @posterior_male_weight = Classifier.posterior_weight(prediction_weight, "male")
    @posterior_female_height = Classifier.posterior_height(prediction_height, "female")
    @posterior_female_weight = Classifier.posterior_weight(prediction_weight, "female")

    @female_product = @posterior_female_weight * @posterior_female_height
    @male_product = @posterior_male_weight * @posterior_male_height

    @predicted_gender = @female_product > @male_product ? "PREDICTED TO BE FEMALE" : "PREDICTED TO BE MALE"
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
