class Respondent < ActiveRecord::Base

  validates :gender, presence: true, inclusion: { in: %w(male female),
    message: "%{value} is not a valid gender.  Please use 'male' or 'female'." }
  validates :height, presence: true,
    numericality: { greater_than: 0 }
  validates :weight, presence: true,
    numericality: { greater_than: 0 }

  scope :male_respondents, -> { where(gender: 'male') }
  scope :female_respondents, -> { where(gender: 'female') }

  def self.heights
    pluck(:height)
  end

  def self.weights
    pluck(:weight)
  end

  def self.sum_height
    heights.inject(:+).to_f
  end

  def self.sum_weight
    weights.inject(:+).to_f
  end

  def self.mean_height
    sum_height/heights.length.to_f
  end

  def self.mean_weight
    sum_weight/weights.length.to_f
  end

  def self.variance_height
    sum = heights.inject(0){|accum, i| accum + (i - mean_height) ** 2 }

    sum / (heights.length - 1).to_f
  end

  def self.variance_weight
    sum = weights.inject(0){|accum, i| accum + (i - mean_weight) ** 2 }

    sum / (weights.length - 1).to_f
  end

  def import_records
    json_parsed = retrieve_json_file

    respondents = json_parsed["people"]

    respondents.each do |respondent|
      entry = respondent["person"]

      Respondent.create(
        id: entry["id"],
        height: entry["height"],
        weight: entry["weight"],
        gender: entry["gender"])
    end
  end

  def retrieve_json_file(file_url)
    JSON.parse(HTTParty.get "#{file_url}")
  end

end
