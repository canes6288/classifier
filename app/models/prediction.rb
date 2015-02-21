class Prediction < ActiveRecord::Base

  validates :posterior_weight, presence: true,
    numericality: { greater_than: 0 }
  validates :weight, presence: true,
    numericality: { greater_than: 0 }

  def male_classifier
    Classifier.new(prediction: self, respondents: Respondent.male_respondents)
  end

  def female_classifier
    Classifier.new(prediction: self, respondents: Respondent.female_respondents)
  end

  def male?
    male_classifier.score > female_classifier.score
  end

  def female?
    female_classifier.score > male_classifier.score
  end
end

