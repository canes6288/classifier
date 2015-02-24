class AddPredictedGenderToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :gender, :string
  end
end
