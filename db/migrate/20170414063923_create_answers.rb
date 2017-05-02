class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :label
      t.string :value
      t.string :information
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
