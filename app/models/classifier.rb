class Classifier
  MALE_GENDER = 'male'
  FEMALE_GENDER = 'female'

  def initialize(prediction, respondents = Respondent.all)
  end

  def self.posterior_height(prediction, gender)
    ((1/(Math.sqrt(2*Math::PI*variance_height("#{gender}"))))*Math.exp((-1*((prediction - mean_height("#{gender}"))**2))/(2*variance_height("#{gender}")))).to_f
  end

  def self.posterior_weight(prediction, gender)
    ((1/(Math.sqrt(2*Math::PI*variance_weight("#{gender}"))))*Math.exp((-1*((prediction - mean_weight("#{gender}"))**2))/(2*variance_weight("#{gender}")))).to_f
  end
end
