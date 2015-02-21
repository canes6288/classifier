class Respondent < ActiveRecord::Base

  def self.heights
    pluck(:height)
  end

  def self.weights
    pluck(:weight)
  end

  def self.male_respondents
    where(gender:"male")
  end

  def self.female_respondents
    where(gender:"female")
  end


  def self.sum_height(gender)
    current_respondent(gender).heights.inject(:+).to_f
  end

  def self.sum_weight(gender)
    current_respondent(gender).weights.inject(:+).to_f
  end

  def self.mean_height(gender)
    (sum_height("#{gender}")/current_respondent(gender).heights.length).to_f
  end

  def self.mean_weight(gender)
    (sum_weight("#{gender}")/current_respondent(gender).weights.length).to_f
  end

  def self.variance_height(gender)
    mean = mean_height("#{gender}")
    sum = current_respondent(gender).heights.inject(0){|accum, i| accum + (i - mean) ** 2 }

    sum / (current_respondent(gender).heights.length - 1).to_f
  end

  def self.variance_weight(gender)
    mean = mean_weight("#{gender}")
    sum = current_respondent(gender).weights.inject(0){|accum, i| accum + (i - mean) ** 2 }

    sum / (current_respondent(gender).weights.length - 1).to_f
  end

end
