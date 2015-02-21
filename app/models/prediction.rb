class Prediction < ActiveRecord::Base
  validates :height, presence: true,
    numericality: { greater_than: 0 }
  validates :weight, presence: true,
    numericality: { greater_than: 0 }

  def classifier
    Classifer.new(self)
  end
end

