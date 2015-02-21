class CreateRespondents < ActiveRecord::Migration
  def change
    create_table :respondents do |t|
      t.string :gender
      t.integer :height
      t.integer :weight

      t.timestamps
    end
  end
end
