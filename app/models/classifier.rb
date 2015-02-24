class Classifier

  attr_reader :prediction, :respondents

  def initialize(prediction:, respondents:)
    @prediction  = prediction
    @respondents = respondents
  end


  def posterior_height
    ((1/(Math.sqrt(2*Math::PI*variance_height)))*
      Math.exp((-1*((prediction.height - mean_height)**2))/(2*variance_height))).to_f
  end

  def posterior_weight
    ((1/(Math.sqrt(2*Math::PI*variance_weight)))*
      Math.exp((-1*((prediction.weight - mean_weight)**2))/(2*variance_weight))).to_f
  end

  def posterior_numerator
    posterior_weight * posterior_height
  end


  private

  def variance_height
    respondents.variance_height
  end

  def mean_height
    respondents.mean_height
  end

  def variance_weight
    respondents.variance_weight
  end

  def mean_weight
    respondents.mean_weight
  end
end
