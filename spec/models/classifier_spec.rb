require 'rails_helper'

describe Classifier do
  before { @prediction = Prediction.new(height: "6", weight: "130") }
  before { @classifier = Classifier.new(prediction: @prediction, respondents: Respondent.male_respondents) }

  describe '#posterior_height' do
    it 'returns posterior height score' do
      expect(@classifier.posterior_height).to eq(0.4749088496333091)
    end
  end

  describe '#posterior_weight' do
    it 'returns posterior weight score' do
      expect(@classifier.posterior_weight).to eq(5.378643390299393e-07)
    end
  end

  describe '#posterior_numerator' do
    it 'returns posterior numerator' do
      expect(@classifier.posterior_numerator).to eq(5.378643390299393e-07*0.4749088496333091)
    end
  end
end
