class Prediction < ActiveRecord::Base
  before_save :set_gender

  validates :height, presence: true,
    numericality: { greater_than: 0 }
  validates :weight, presence: true,
    numericality: { greater_than: 0 }

  def set_gender
    if male?
      self.gender = 'male'
    elsif female?
      self.gender = 'female'
    else
      self.gender = 'not determined'
    end
  end

  def male_classifier
    Classifier.new(prediction: self, respondents: Respondent.male_respondents)
  end

  def female_classifier
    Classifier.new(prediction: self, respondents: Respondent.female_respondents)
  end


  private

  def male?
    male_classifier.posterior_numerator > female_classifier.posterior_numerator
  end

  def female?
    female_classifier.posterior_numerator > male_classifier.posterior_numerator
  end
end

